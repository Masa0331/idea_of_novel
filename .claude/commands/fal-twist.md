---
description: どんでん返し・叙述トリックの設計セッションを開始する
---

# /fal-twist — どんでん返し・叙述トリック錬成起動（Claude Code 用）

このコマンドは Antigravity 版 `/fal-twist` と同一の手順書を参照します。
実体は `.agents/` 側にあり、ここでは重複させません（手順書の唯一の情報源を1箇所に保つため）。

1. `.agents/workflows/fal-twist.md` を読み込み、その手順に厳密に従うこと
2. 手順書の指示どおり `.agents/skills/twist-trick-forge/SKILL.md` を読み込み、以後はその手順・フォーマット・HARD-GATEに従うこと
3. 参照資料・雛形は、`reference/` や `templates/` フォルダではなく
   `.agents/skills/twist-trick-forge/` 直下にある以下を使うこと
   - `trick-catalog.md`（型カタログ。フェーズ2で読み込む）
   - `twist-sheet-template.md`（真相シートの雛形）
4. ユーザーからの補足：$ARGUMENTS
   - 空の場合は、手順書の規定どおり（既存ブレストセッションへの接続可否を確認したうえで）フェーズ0の質問から開始すること
5. 既存セッションに接続する場合は、`brainstorm/<セッション名>.md` を読み込んで文脈と決まったことを引き継ぎ、
   **新しい状態ファイルを作らず**、既存の1本に書き足すこと
