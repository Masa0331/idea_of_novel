---
description: 01_free_memo フォルダ内の free_memo_01.md ~ free_memo_10.md と、fal用メモ/fal用_作品案メモ①〜⑤.md の不足分を補充する
---

# /fal-refill-free_memos — フリーメモ補充ワークフロー（Claude Code 用）

このコマンドは Antigravity 版 `/fal-refill-free_memos` と同一の手順書を参照します。
実体は `.agents/` 側にあり、ここでは重複させません（手順書の唯一の情報源を1箇所に保つため）。

1. `.agents/workflows/fal-refill-free_memos.md` を読み込み、その手順に厳密に従うこと
2. スクリプトの実行には **PowerShell ツール**を使い、文字化け防止のため UTF-8 指定を前置すること
   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8; $env:PYTHONUTF8=1; python .agents/scripts/refill_free_memos.py
   ```
   - カレントディレクトリはプロジェクトルート（`idea_of_novel/`）であること
3. このスクリプトは `free_memo_01.md` 〜 `free_memo_10.md` と `fal用メモ/fal用_作品案メモ①.md` 〜 `⑤.md` のうち**存在しない番号だけを新規作成**し、
   既存ファイルは中身を読まず、上書きも削除もしない。したがって事前確認なしに実行してよい
4. 実行後、作成されたファイル名の一覧（または「不足しているファイルはありませんでした」）を日本語で報告すること
