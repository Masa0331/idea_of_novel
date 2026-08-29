---
description: 01_free_memo フォルダ内の free_memo_01.md ~ free_memo_10.md と、fal用メモ/fal用_作品案メモ①〜⑤.md の不足分を補充する
---

# /fal-refill-free_memos — フリーメモ補充ワークフロー

`01_free_memo` フォルダ内の `free_memo_01.md` から `free_memo_10.md` までと、`01_free_memo/fal用メモ/` の `fal用_作品案メモ①.md` 〜 `⑤.md` の空白テンプレートメモをスキャンし、タイトル変更等で減った不足分を全自動で補充します。

## 実行手順

1. ターミナルで文字コード（UTF-8）を指定し、補充スクリプトを実行します。
   - 実行コマンド:
     `[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; $env:PYTHONUTF8=1; python .agents/scripts/refill_free_memos.py`
2. 補充されたファイルの一覧を確認し、結果をユーザーに日本語で報告します。
