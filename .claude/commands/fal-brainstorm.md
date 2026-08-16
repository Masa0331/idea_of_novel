---
description: エンタメ系ミステリーのあらすじ・プロットのブレインストーミングを開始する
---

# /fal-brainstorm — ミステリー深掘りブレスト起動（Claude Code 用）

このコマンドは Antigravity 版 `/fal-brainstorm` と同一の手順書を参照します。
実体は `.agents/` 側にあり、ここでは重複させません（手順書の唯一の情報源を1箇所に保つため）。

1. `.agents/workflows/workflow-fal-brainstorm.md` を読み込み、その手順に厳密に従うこと
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
6. フェーズ2の「枠指定」（例：`2改[舞台] 5改[フック] 1+3合 4,6却下`）を受け取ったら、
   SKILL.md の枠配分ルールに従って次案を生成すること。指定が明確なら確認せず即生成し、
   `📥受領` 行で解釈を1行示す
   - **Claude Code 固有：** SKILL.md の「曖昧判定」に当たり確認が必要な場合のみ、`AskUserQuestion` を使ってよい
     （選択肢は SKILL.md の指定どおり、AIの推奨解釈を先頭に置くこと）。曖昧でないときに使ってはならない
   - 選択肢末尾の枠指定テンプレートは、コピーしやすいよう ```text ブロックで出力すること
