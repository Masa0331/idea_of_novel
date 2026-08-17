import re
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
files = [
    os.path.join(BASE_DIR, 'list_g_narrative_trick_150.md'),
    os.path.join(BASE_DIR, 'list_h_conflicting_emotions_list_100.md')
]
pattern = r'#### \*\*No\. \d{3}-[GH]\. .*? [《『](.*?)[》』]\*\*'

for filepath in files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Let's count matching headers
    matches = list(re.finditer(pattern, content))
    print(f'File: {filepath[-30:]}, matches: {len(matches)}')
    
    # Print the first 5 and last 5 genres
    for i, m in enumerate(matches):
        if i < 5 or i > len(matches) - 6:
            print(f'  {i}: {m.group(1)}')
