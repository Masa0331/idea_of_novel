---
description: どんでん返し・叙述トリックを、真相から逆算して作る
---

# /fal-twist — トリック錬成起動（Claude Code 用）

このコマンドは Antigravity 版 `/fal-twist` と同一の手順書を参照します。
実体は `.agents/` 側にあり、ここでは重複させません（手順書の唯一の情報源を1箇所に保つため）。

1. `.agents/workflows/fal-twist.md` を読み込み、その手順に厳密に従うこと

2. 手順書の指示どおり `.agents/skills/twist-trick-forge/SKILL.md` を読み込み、以後はその手順・形式・HARD-GATE に従うこと

3. 参照資料・雛形は、`reference/` や `templates/` フォルダではなく次の場所にあるものを使うこと
   - `.agents/skills/twist-trick-forge/trick-catalog.md`（型カタログ。型を選ぶときに読む）
   - `.agents/skills/twist-trick-forge/twist-sheet-template.md`（真相ファイルの雛形）
   - `.agents/skills/mystery-deep-brainstorm/session-template.md`（状態ファイルの雛形）

4. ユーザーからの補足：$ARGUMENTS
   - 空の場合は、手順書の規定どおり（既存セッションにつなぐかを確認したうえで）最初の質問から開始すること

5. 既存セッションにつなぐ場合は、`brainstorm/<セッション名>.md` を読み込んで話と決まったことを引き継ぎ、
   ⚠️ **新しい状態ファイルを作らず**、既存の1本に書き足すこと

6. **Claude Code 固有：選択肢を出すとき、`AskUserQuestion` を使ってよい**
   - ⭐おすすめを必ず先頭に置くこと
   - ⚠️ **1ターンに出せる質問は1つだけ**（複数の質問を並べない）
   - ⚠️ **1件ずつ裁定を求めるための道具として使ってはならない。**まとめて片づけられる形で出す

7. **Claude Code 固有：ファイルの作成・編集は `Write` / `Edit` ツールを使う**
   - ⚠️ `cat > ファイル << EOF` のヒアドキュメントは、許可設定の前方一致に当たらず毎回確認を求められる
   - 検索・確認は `Read` / `Grep` / `Glob`、集計や一括置換は `python -` を使う

8. **全出力は日本語。**ターミナル操作が必要な場合は UTF-8 強制を前置すること

9. **Claude Code 固有：ほかのワークフローへ渡す選択肢は、`AskUserQuestion` の選択肢の1つとして出してよい**
   - 渡し先は `/fal-brainstorm`（案を増やす）／`/fal-twist`（仕掛け・伏線）／`/fal-polish`（1箇所ずつ詰める）
   - 選ばれたら、**このセッションのまま**渡し先の `SKILL.md` を `Read` で読み込んで続けること。⚠️ **コマンドを打ち直させない**
   - ⚠️ いまの内容をそのまま持ち込む（**貼り直させない**／**新しい状態ファイルを作らない**）
   - ⚠️ 勝手に渡らない。⚠️ 1ターンに渡す選択肢は1つまで
