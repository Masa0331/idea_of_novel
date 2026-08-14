import os

TEMPLATE = """> [!NOTE]
> このファイルは小説執筆のためのアイデアを記したメモであり、決定事項ではありません。
> AIがストーリー案を考える際などに参考にすることは推奨されますが、ここに書かれた内容に縛られる必要はなく、必要に応じて臨機応変に最も相応しい形へ改変・改良・修正してください。

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
    
    if created_files:
        print("以下のファイルを作成しました:")
        for f in created_files:
            print(f"  - {f}")
    else:
        print("不足しているファイルはありませんでした。")

if __name__ == "__main__":
    main()
