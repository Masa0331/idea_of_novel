---
description: ワークスペースのディレクトリ構造、ファイル一覧、およびキャラクターリストを読み取り、README.mdを最新の状態に自動更新する。
---

# README自動更新ワークフロー

このワークフローは、プロジェクト内のフォルダやファイルが追加・削除された際に、`README.md` の構成表を最新の状態に同期するために使用します。

## 前提条件
- `README.md` 内に以下のマーカーが存在すること：
    - `<!-- START_FOLDER_TREE -->` / `<!-- END_FOLDER_TREE -->`
    - `<!-- START_CHAR_LIST -->` / `<!-- END_CHAR_LIST -->`

## 手順

// turbo-all

1. **更新スクリプトの実行**
   Pythonスクリプト `.agents/scripts/update_readme.py` を実行して、`README.md` の内容を書き換えます。
   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; $env:PYTHONUTF8=1; python .agents/scripts/update_readme.py
   ```

2. **結果の確認と完了報告**
   `README.md` が正しく更新されたことを確認し、ユーザーに完了を報告します。

## 注意事項
- スクリプトは `README.md` のマーカーに挟まれた部分のみを置換します。手書きした「作品情報」や「コンセプト」などのセクションは保持されます。
- キャラクターリストは数が多い場合、主要キャラクターの抜粋のみが表示されます。
