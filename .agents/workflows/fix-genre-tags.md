---
description: ナラティブエンジン用リストのジャンル指定の不備を修正する
---

# 目的
`06_narrative_engine` フォルダ内の `list_*.md` ファイル（例: `list_g_narrative_trick_150.md` や `list_h_conflicting_emotions_list_100.md`）に記載されているジャンル指定を、`format_narrative_engine_list.md` で定義されている「許可されたジャンルリスト」に沿って修正し、表記揺れや無効なジャンルタグを自動的に置換・除去する。

# 手順

このワークフローは、**ユーザーへの途中確認を一切挟まず**に最後まで一気に実行を行うための手順です。

// turbo-all

## 1. 修正スクリプトの作成
以下の内容のPythonスクリプト `fix_genres.py` を作成する。このスクリプトは指定されたファイルの見出しにおけるジャンルタグ（《》または『』で囲まれた部分）を読み取り、`allowed_genres` リストと `genre_map` を使って正しいタグに置換する。

```python
import re

allowed_genres = [
    '悲劇', '希望', '感情反転', '鬱・イヤミス', 'サスペンス', 'ホラー', 'ほのぼの・癒やし', 'ギャグ・コメディ', 'シュール・不条理', '不条理',
    'どんでん返し', '叙述トリック', 'ミステリ・伏線', '物理・科学トリック', '論理・パラドックス', '誤解・すれ違い', 'ジレンマ', 'ループ・因果', 'メタフィクション', '時間', '象徴', '心理戦・情報戦', '群像劇',
    '社会派・テーマ', '人間ドラマ・絆', '恋愛・献身', '仕事・職能', 'バトル・アクション', '日常・リアリズム', '雰囲気・美学', '知識・うんちく', '成長・変化', '決定論・自由意志', '心理学', '日常の奇跡', '自然の神秘',
    'SF', '鳥類学・生物学・生態学', '機械工学・電子工学', 'クライム', 'ノワール', 'ハードボイルド',
    'ラストシーン', 'スパイス', '伝説・神話', '余韻・空白'
]

# 表記揺れや類似表現を正しいジャンルにマッピングする辞書
genre_map = {
    'ギャグ': 'ギャグ・コメディ',
    'コメディ': 'ギャグ・コメディ',
    '人間ドラマ': '人間ドラマ・絆',
    '絆': '人間ドラマ・絆',
    '恋愛': '恋愛・献身',
    'シュール': 'シュール・不条理',
    '日常': '日常・リアリズム',
    'メタ': 'メタフィクション',
    'キャラ': '人間ドラマ・絆',
    'その他': 'スパイス',
    'シリアス': '雰囲気・美学',
    '愛': '恋愛・献身',
    '心理': '心理学',
    '感動': '希望',
    'ミステリー': 'ミステリ・伏線',
    'ミステリ': 'ミステリ・伏線',
    '伏線': 'ミステリ・伏線',
    '誤解': '誤解・すれ違い',
    'すれ違い': '誤解・すれ違い',
    '知識': '知識・うんちく',
    'アイテム': '象徴',
    '感覚': '雰囲気・美学',
    '共犯': '人間ドラマ・絆',
    '逆説': '論理・パラドックス',
    '信頼': '人間ドラマ・絆',
    '比喩': '象徴',
    '風刺': 'シュール・不条理',
    'リアリズム': '日常・リアリズム',
    'テーマ': '社会派・テーマ',
}

# 修正対象のファイルを指定 (全てのlist_*.mdを自動取得)
import glob
import os
base_dir = r'06_narrative_engine_list'
files = glob.glob(os.path.join(base_dir, 'list_*.md'))

for filepath in files:
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        replaced_count = 0
        for i, line in enumerate(lines):
            # 見出し行を検索：#### **No. 000-A. タイトル 《ジャンル》**
            if re.search(r'####\s*\*\*No\.\s*\d{3}-[A-Z]\.', line):
                m = re.search(r'[《『](.*?)[》』]', line)
                if m:
                    og_genres = [g.strip() for g in m.group(1).split('、')]
                    new_genres = []
                    for g in og_genres:
                        if g in allowed_genres:
                            new_genres.append(g)
                        elif g in genre_map:
                            new_genres.append(genre_map[g])
                        else:
                            print(f'Unmapped genre: {g} in line: {line.strip()}')
                            new_genres.append('スパイス') # 未知のタグはとりあえず「スパイス」に置換
                    
                    # 重複削除 (順序を保持)
                    seen = set()
                    new_genres_dedup = [x for x in new_genres if not (x in seen or seen.add(x))]
                    
                    new_genres_str = '、'.join(new_genres_dedup)
                    # 元の括弧を維持しつつ中身を置換
                    bracket_left = m.group(0)[0]
                    bracket_right = m.group(0)[-1]
                    new_line = re.sub(r'[《『].*?[》』]', f'{bracket_left}{new_genres_str}{bracket_right}', line)
                    if new_line != line:
                        lines[i] = new_line
                        replaced_count += 1
                        print(f'Replaced: {m.group(1)} -> {new_genres_str}')
                        
        with open(filepath, 'w', encoding='utf-8', newline='') as f:
            for l in lines:
                f.write(l)
        print(f'Processed {filepath}, replaced {replaced_count} lines.')
    except Exception as e:
        print(f'Error processing {filepath}: {str(e)}')
```

## 2. 修正スクリプトの実行

// turbo
```powershell
$env:PYTHONUTF8=1; python fix_genres.py
```

## 3. 検証スクリプトの作成と実行
修正後、不正なタグが残っていないか検証するためのスクリプト `verify_genres.py` を作成し実行する。

```python
import re

allowed_genres = [
    '悲劇', '希望', '感情反転', '鬱・イヤミス', 'サスペンス', 'ホラー', 'ほのぼの・癒やし', 'ギャグ・コメディ', 'シュール・不条理', '不条理',
    'どんでん返し', '叙述トリック', 'ミステリ・伏線', '物理・科学トリック', '論理・パラドックス', '誤解・すれ違い', 'ジレンマ', 'ループ・因果', 'メタフィクション', '時間', '象徴', '心理戦・情報戦', '群像劇',
    '社会派・テーマ', '人間ドラマ・絆', '恋愛・献身', '仕事・職能', 'バトル・アクション', '日常・リアリズム', '雰囲気・美学', '知識・うんちく', '成長・変化', '決定論・自由意志', '心理学', '日常の奇跡', '自然の神秘',
    'SF', '鳥類学・生物学・生態学', '機械工学・電子工学', 'クライム', 'ノワール', 'ハードボイルド',
    'ラストシーン', 'スパイス', '伝説・神話', '余韻・空白'
]

import glob
import os
base_dir = r'06_narrative_engine_list'
files = glob.glob(os.path.join(base_dir, 'list_*.md'))
pattern = r'#### \*\*No\. \d{3}-[A-Z]\. .*? [《『](.*?)[》』]\*\*'

has_invalid = False
for filepath in files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    matches = list(re.finditer(pattern, content))
    invalid = set()
    for m in matches:
        genres = [g.strip() for g in m.group(1).split('、')]
        for g in genres:
            if g not in allowed_genres:
                invalid.add(g)
                has_invalid = True
    
    if len(invalid) > 0:
        print(f'INVALID GENRES FOUND in {filepath[-30:]}: {invalid}')

if not has_invalid:
    print('SUCCESS: NO INVALID GENRES FOUND!')
```

// turbo
```powershell
$env:PYTHONUTF8=1; python verify_genres.py
```
