import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
WORKSPACE_ROOT = os.path.dirname(BASE_DIR)

memo_path = os.path.join(WORKSPACE_ROOT, '01_settings', '00_free_memo', 'free_memo_01.md')
out_path = os.path.join(BASE_DIR, 'literature', 'ref_japanese_seasonality_and_folklore.md')

with open(memo_path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

def get_lines(start, end):
    # 1-indexed to 0-indexed
    return ''.join(lines[start-1:end])

compiled = f"""# 書籍資料：日本の四季と行事・まじない（旬の文化とその構造）

{get_lines(7, 43)}

{get_lines(385, 450)}

## 第二章：春の行事（再生の祈りと「霊的更新」）

{get_lines(48, 80)}

{get_lines(292, 328)}

{get_lines(199, 212)}

## 第三章：夏の行事（防御のまじないと生命力の維持）

{get_lines(85, 108)}

{get_lines(333, 368)}

## 第四章：秋の行事（収穫の感謝と対の思想）

{get_lines(113, 141)}

## 第五章：空間の異差「地貌（ちぼう）」と地域文化の多様性

{get_lines(564, 653)}

## 第六章：食文化の深層（「土用」と「節供」の再生）

{get_lines(498, 562)}

## 結論：現代社会への示唆

{get_lines(779, 785)}
"""

os.makedirs(os.path.dirname(out_path), exist_ok=True)
with open(out_path, 'w', encoding='utf-8') as f:
    f.write(compiled)

# empty the original
with open(memo_path, 'w', encoding='utf-8') as f:
    f.write("")

print("Compiled successfully to", out_path)
