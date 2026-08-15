---
description: エンタメ系ミステリーのあらすじ・プロットのブレインストーミングを開始する
---

# /brainstorm — ミステリー深掘りブレスト起動（Claude Code 用）

このコマンドは Antigravity 版 `/brainstorm` と同一の手順書を参照します。
実体は `.agents/` 側にあり、ここでは重複させません（手順書の唯一の情報源を1箇所に保つため）。

1. `.agents/workflows/workflow-brainstorm.md` を読み込み、その手順に厳密に従うこと
2. 手順書の指示どおり `.agents/skills/mystery-deep-brainstorm/SKILL.md` を読み込み、以後はその手順・フォーマット・HARD-GATEに従うこと
3. 状態ファイル（`brainstorm/<セッション名>_tree.md` / `_preferences.md`）の雛形は、`templates/` フォルダではなく
   `.agents/skills/mystery-deep-brainstorm/` 直下にある以下を使うこと
   - `tree-template.md`
   - `preferences-template.md`
4. ユーザーからの補足：$ARGUMENTS
   - 空の場合は、手順書の規定どおり（既存セッションの有無を確認したうえで）フェーズ0の質問から開始すること
   - 補足がある場合は、それをフェーズ0の「大雑把なテーマ・出発点」として扱い、重複する質問はしないこと
5. セッション中に「トリック錬成」と指示された場合は、`.agents/skills/twist-trick-forge/SKILL.md` を読み込み、
   **新規ファイルを作らず**現在の tree.md に枝を継ぎ足す形で接続すること
