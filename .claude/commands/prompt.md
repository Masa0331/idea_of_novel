---
description: プロンプト集から最適なテンプレートを選び、[ ]を埋めて実行する
---

# /prompt — プロンプト・ディスパッチャー起動（Claude Code 用）

このコマンドは Antigravity 版 `/prompt` と同一の手順書を参照します。
実体は `.agents/` 側にあり、ここでは重複させません（手順書の唯一の情報源を1箇所に保つため）。

1. `.agents/workflows/workflow-prompt.md` を読み込み、その手順に厳密に従うこと
2. 手順書の指示どおり `.agents/skills/prompt-dispatcher/SKILL.md` と `01_free_memo/プロンプト集.md` を読み込むこと
3. ユーザーの意図：$ARGUMENTS
   - 空の場合は、手順書の規定どおり「今日は何をしますか？」と1問だけ尋ねること
