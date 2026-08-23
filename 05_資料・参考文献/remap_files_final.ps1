$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$baseDir = "c:\Users\exlc6\Documents\antigravity\projects\idea_of_novel\05_資料・参考文献"
$files = Get-ChildItem -Path $baseDir -File -Recurse | Where-Object { $_.Name -ne 'README.md' -and $_.Name -ne 'remap_files_final.ps1' }

$categories = [ordered]@{
    "11_探偵" = @("探偵")
    "12_警察" = @("警察", "捜査", "逮捕", "勾留", "留置場")
    "01_文章表現・例文" = @("表現", "例文", "レトリック", "描写", "文章", "情景", "スピーチ")
    "02_鳥" = @("鳥", "鳩", "ハヤブサ", "トビ", "猛禽", "野鳥", "カラス", "フクロウ", "ホーク", "隼", "シマハヤブサ")
    "03_流丘市（流山市）" = @("流山", "流丘", "遺跡", "条例", "あるある", "レポート")
    "04_発達障害・精神疾患" = @("発達障害", "精神疾患", "ADHD", "ASD", "アスペルガー", "適応障害", "うつ病", "カサンドラ", "自閉症", "ニューロダイバーシティ", "二次障害")
    "05_小笠原＆伊豆諸島関連" = @("小笠原", "伊豆", "青ヶ島", "父島", "ハヤムサ", "ハヤムシ")
    "06_脳・脳科学・脳内物質系" = @("脳", "脳科学", "脳内物質", "BDNF", "神経伝達物質")
    "07_哲学・倫理" = @("哲学", "倫理", "決定論", "虚構")
    "08_心理学・カウンセリング・占い" = @("心理", "カウンセリング", "占い", "精神", "バンパイア", "孤独", "性格", "シングル", "幸福", "悲しみ", "ズーフィリア", "人相術", "生きづらさ", "壁", "結婚", "ソロ", "無理の構造")
    "09_人間・人体・神経" = @("人間", "人体", "神経", "顔")
    "10_生物・生態" = @("生物", "生態", "遺伝子", "動物", "ネコ", "猫", "虫", "色覚", "視覚", "進化", "アニマル", "ペット", "飼育", "痛覚", "交雑")
    "13_創作論・ミステリー関連" = @("ミステリ", "創作", "展開", "構成")
    "14_法律・業界" = @("法律", "業界", "法規制", "特定", "悪評", "事業", "善場")
    "15_神話・民俗・歴史" = @("神話", "民俗", "歴史", "太陽神", "神様", "八咫烏", "天狗", "産土神", "神棚", "行事", "四季")
    "16_工学" = @("工学", "機械")
    "17_物理" = @("物理")
    "18_医学" = @("医学", "症候群", "治療", "MRKH")
    "20_その他" = @()
}

$movedCount = 0

foreach ($file in $files) {
    $matchedFolder = $null
    $fileName = $file.BaseName
    
    foreach ($category in $categories.Keys) {
        $keywords = $categories[$category]
        foreach ($keyword in $keywords) {
            if ($fileName -match $keyword) {
                $matchedFolder = $category
                break
            }
        }
        if ($matchedFolder) {
            break
        }
    }
    
    if (-not $matchedFolder) {
        $matchedFolder = "20_その他"
    }
    
    $targetDir = Join-Path $baseDir $matchedFolder
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir | Out-Null
    }
    
    if ($file.DirectoryName -ne $targetDir) {
        Move-Item -Path $file.FullName -Destination $targetDir -Force
        Write-Host "Moved '$($file.Name)' to '$matchedFolder'"
        $movedCount++
    }
}

Write-Host "Re-categorization completed. Moved $movedCount files."

# Generate README
$readmePath = Join-Path $baseDir "README.md"
$markdown = @"
# 05_資料・参考文献 フォルダ一覧

## 📂 フォルダ分けのルール

当フォルダ内の資料・ファイルは、以下のルールに基づいて整理されています。

1. **内容に基づく分類**: ファイルの内容（タイトルまたは中身）に最も相応しいカテゴリのフォルダに格納します。
2. **特例優先ルール（探偵・警察）**: 「探偵」および「警察」の仕事に関する内容は、ナンバリングにかかわらず最優先で「11_探偵」「12_警察」のフォルダに振り分けます。
3. **ナンバリング優先則**: 上記以外のファイルで複数のカテゴリに該当し分類に迷う場合は、**フォルダ名冒頭のナンバリングが若い方のフォルダへ優先して**格納します。（例：鳥に関する文章表現の場合、「02_鳥」ではなく「01_文章表現・例文」に分類されます）
4. **新規作成時の注意**: 新しいファイルを追加する際は、上記の優先則に基づき、最も適切で番号の若いフォルダ（特例を除く）を選んで配置してください。

---

## 📄 ファイル一覧

"@

$directories = Get-ChildItem -Path $baseDir -Directory | Sort-Object Name

foreach ($dir in $directories) {
    $markdown += "### 📁 $($dir.Name)`n"
    $files = Get-ChildItem -Path $dir.FullName -File -Filter "*.md" | Sort-Object Name
    if ($files.Count -eq 0) {
        $markdown += "（ファイルなし）`n`n"
        continue
    }
    
    $markdown += "| ファイル名 |`n"
    $markdown += "| --- |`n"
    foreach ($file in $files) {
        $relativePath = "./$($dir.Name)/$($file.Name)"
        $markdown += "| [$($file.BaseName)]($relativePath) |`n"
    }
    $markdown += "`n"
}

$markdown | Out-File -FilePath $readmePath -Encoding UTF8
Write-Host "README.md generated successfully."
