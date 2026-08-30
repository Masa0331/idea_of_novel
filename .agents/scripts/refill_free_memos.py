import os

TEMPLATE = """> [!NOTE]
> このファイルは小説執筆のためのアイデアを記したメモであり、決定事項ではありません。
> AIがストーリー案を考える際などに参考にすることは推奨されますが、ここに書かれた内容に縛られる必要はなく、必要に応じて臨機応変に最も相応しい形へ改変・改良・修正してください。

---

"""

FAL_DIR_NAME = "fal用メモ"
FAL_CIRCLED = ["①", "②", "③", "④", "⑤"]

FAL_TEMPLATE = """# fal用_作品案メモ{mark}

> **作品の思いつきを、形にならないまま置いておく場所。**
> `/fal-brainstorm` `/fal-twist` `/fal-setting` の**チャットモード**に入ると、AI はまずこのファイルを読みます。
> ⭐ 書きっぱなしで構いません。整える必要はありません。
> ⚠️ 決まったことは `brainstorm/` の状態ファイルに入るので、ここには**まだ決まっていないもの**を置いてください。
> 💡 ①から順に使います。長くなってきたら次の番号へ。

---

## 置き場


"""


def main():
    target_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), '01_free_memo')
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    created_files = []
    for i in range(1, 11):
        filename = f"free_memo_{i:02d}.md"
        filepath = os.path.join(target_dir, filename)
        if not os.path.exists(filepath):
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(TEMPLATE)
            created_files.append(filename)

    # fal用メモ/ の作品案メモ①〜⑤ も常に5本に保つ
    fal_dir = os.path.join(target_dir, FAL_DIR_NAME)
    if not os.path.exists(fal_dir):
        os.makedirs(fal_dir)
    for mark in FAL_CIRCLED:
        filename = f"fal用_作品案メモ{mark}.md"
        filepath = os.path.join(fal_dir, filename)
        if not os.path.exists(filepath):
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(FAL_TEMPLATE.format(mark=mark))
            created_files.append(f"{FAL_DIR_NAME}/{filename}")

    if created_files:
        print("以下のファイルを作成しました:")
        for f in created_files:
            print(f"  - {f}")
    else:
        print("不足しているファイルはありませんでした。")

if __name__ == "__main__":
    main()
