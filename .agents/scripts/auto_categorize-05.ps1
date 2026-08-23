$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$baseDir = "c:\Users\exlc6\Documents\antigravity\projects\idea_of_novel\05_資料・参考文献"
$unclassifiedDir = Join-Path $baseDir "未分類"

if (-not (Test-Path $unclassifiedDir)) {
    Write-Host "未分類フォルダが見つかりません。作成します。"
    New-Item -ItemType Directory -Path $unclassifiedDir | Out-Null
}

$files = Get-ChildItem -Path $unclassifiedDir -File

if ($files.Count -eq 0) {
    Write-Host "未分類フォルダにファイルはありません。"
} else {
    $categories = [ordered]@{
        "12_探偵" = @("探偵")
        "13_警察" = @("警察", "捜査", "逮捕", "勾留", "留置場")
        "01_文章表現・例文" = @("表現", "例文", "レトリック", "描写", "文章", "情景", "スピーチ")
        "02_鳥" = @("鳥", "鳩", "ハヤブサ", "トビ", "猛禽", "野鳥", "カラス", "フクロウ", "ホーク", "隼", "シマハヤブサ")
        "03_流丘市（流山市）" = @("流山", "流丘", "遺跡", "条例", "あるある", "レポート")
        "04_発達障害・精神疾患" = @("発達障害", "精神疾患", "ADHD", "ASD", "アスペルガー", "適応障害", "うつ病", "カサンドラ", "自閉症", "二次障害", "^アニマルセラピー$")
        "05_コンプライアンス（広義）" = @("コンプライアンス", "ポリコレ", "ハラスメント", "多様性", "社会規範", "ニューロダイバーシティ")
        "06_小笠原＆伊豆諸島関連" = @("小笠原", "伊豆", "青ヶ島", "父島", "ハヤムサ", "ハヤムシ")
        "07_脳・脳科学・脳内物質系" = @("脳", "脳科学", "脳内物質", "BDNF", "神経伝達物質")
        "08_哲学・倫理" = @("哲学", "倫理", "決定論", "虚構", "アニマルウェルフェア")
        "09_心理学・カウンセリング・占い" = @("心理", "カウンセリング", "占い", "精神", "バンパイア", "孤独", "性格", "シングル", "幸福", "悲しみ", "ズーフィリア", "人相術", "生きづらさ", "壁", "結婚", "ソロ", "無理の構造")
        "10_人間・人体・神経" = @("人間", "人体", "神経", "顔")
        "11_生物・生態" = @("生物", "生態", "遺伝子", "動物", "ネコ", "猫", "虫", "色覚", "視覚", "進化", "アニマル", "ペット", "飼育", "痛覚", "交雑")
        "14_創作論・ミステリー関連" = @("ミステリ", "創作", "展開", "構成")
        "15_法律・業界" = @("法律", "業界", "法規制", "特定", "悪評", "事業", "善場")
        "16_神話・民俗・歴史" = @("神話", "民俗", "歴史", "太陽神", "神様", "八咫烏", "天狗", "産土神", "神棚", "行事", "四季")
        "17_工学" = @("工学", "機械")
        "18_物理" = @("物理")
        "19_医学" = @("医学", "症候群", "治療", "MRKH")
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
        
        Move-Item -Path $file.FullName -Destination $targetDir -Force
        Write-Host "Moved '$($file.Name)' to '$matchedFolder'"
        $movedCount++
    }

    Write-Host "未分類フォルダの整理が完了しました。$movedCount 個のファイルを移動しました。"
}

# Generate README
Write-Host "README（フォルダ内容）を更新しています..."
$readmePath = Join-Path $baseDir "フォルダ内容（05_資料・参考文献）.md"
$markdown = @"
# 05_資料・参考文献 フォルダ一覧

## 📂 フォルダ分けのルール

当フォルダ内の資料・ファイルは、以下のルールに基づいて整理されています。

1. **内容に基づく分類**: ファイルの内容（タイトルまたは中身）に最も相応しいカテゴリのフォルダに格納します。
2. **05_コンプライアンス（広義）の定義**: 「社会規範や倫理観に配慮し、ポリコレやハラスメント防止、多様性の尊重を含む社会的な要請に応えること全体を指す言葉」として定義し、この内容に関連するファイル（神経多様性・ニューロダイバーシティなどを含む）は本フォルダへ分類します。
3. **特例優先ルール（探偵・警察）**: 「探偵」および「警察」の仕事に関する内容は、ナンバリングにかかわらず最優先で「12_探偵」「13_警察」のフォルダに振り分けます。
4. **ナンバリング優先則**: 上記以外のファイルで複数のカテゴリに該当し分類に迷う場合は、**フォルダ名冒頭のナンバリングが若い方のフォルダへ優先して**格納します。（例：鳥に関する文章表現の場合、「02_鳥」ではなく「01_文章表現・例文」に分類されます）
5. **新規作成時の注意**: 新しいファイルを追加する際は、一時的に「未分類」フォルダに入れ、ワークフロー(`/fal-auto-categorize-05`)を実行するか、上記の優先則に基づき最も適切で番号の若いフォルダを選んで手動で配置してください。

---

## 📄 ファイル一覧

"@

$directories = Get-ChildItem -Path $baseDir -Directory | Where-Object { $_.Name -ne '未分類' } | Sort-Object Name

# 未分類フォルダもあればリストに加える
$unclassified = Get-ChildItem -Path $baseDir -Directory | Where-Object { $_.Name -eq '未分類' }
if ($unclassified) {
    $directories += $unclassified
}

foreach ($dir in $directories) {
    $markdown += "### 📁 $($dir.Name)`n"
    $mdFiles = Get-ChildItem -Path $dir.FullName -File -Filter "*.md" | Sort-Object Name
    if ($mdFiles.Count -eq 0) {
        $markdown += "（ファイルなし）`n`n"
        continue
    }
    
    $markdown += "| ファイル名 |`n"
    $markdown += "| --- |`n"
    foreach ($file in $mdFiles) {
        $relativePath = "./$($dir.Name)/$($file.Name)"
        $markdown += "| [$($file.BaseName)]($relativePath) |`n"
    }
    $markdown += "`n"
}

$markdown | Out-File -FilePath $readmePath -Encoding UTF8
Write-Host "更新完了。"
