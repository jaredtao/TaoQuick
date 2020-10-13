$cur= Get-Location
$ver="1.0"
$metaInfoFileName="designer/TaoQuick.metainfo"


function WriteMetaInfoBegin {
    $header="MetaInfo {"
    Out-File -Append -Encoding "utf8" -FilePath $metaInfoFileName -InputObject $header
}

function WriteMetaInfoEnd {
    $header="}"
    Out-File -Append -Encoding "utf8" -FilePath $metaInfoFileName -InputObject $header
}

function WriteMetaInfo {
    $info = $args[0]
    if ($info -is [System.IO.FileInfo]) {
        if ($info.BaseName -eq "Config" -or $info.BaseName.EndsWith("Constant") -or $info.BaseName -eq "TCommon" ) {
            return
        }
        $filePath = Resolve-Path -Relative $info.Directory
        $filePath = $filePath + "\" + $info.Name
        $filePath=$filePath.Replace('\', '/')
        if ($filePath.StartsWith('./')) 
        {
            $filePath = $filePath.Remove(0, 2)
        }
        if ($filePath.StartsWith('../Qml/')) 
        {
            $filePath = $filePath.Remove(0, 7)
        }
        $name = "TaoQuick." + $filePath.Replace('/','.')
        $name = $name.Replace(".qml",'')
        
        $str = @"
    Type {
        name: "{0}"
        icon: "images/{1}.png"

        ItemLibraryEntry {
            name: "{1}"
            category: "TaoQuick - {2}"
            libraryIcon: "images/{1}.png"
            version: "1.0"
            requiredImport: "TaoQuick"
            Property { name: "width"; type: "int"; value: 120 }
            Property { name: "height"; type: "int"; value: 80 }
        }
    }
"@
        $str = $str -Replace '\{0}', $name
        $str = $str -Replace '\{1}', $info.BaseName
        $str = $str -Replace '\{2}', $info.Directory.Name
        $str | Out-File -Append -Encoding "utf8" -FilePath $metaInfoFileName
    }
}

function Main {
    # clear qmldir
    if (Test-Path $metaInfoFileName) {
        Clear-Content $metaInfoFileName
    }
    $header="MetaInfo {"
    Out-File -Append -Encoding "utf8" -FilePath $metaInfoFileName -InputObject $header

    # write qmldir
    Get-ChildItem -Recurse Qml -Filter *.qml  | ForEach-Object -Process {
        WriteMetaInfo $_
    }

    $header="}"
    Out-File -Append -Encoding "utf8" -FilePath $metaInfoFileName -InputObject $header
}

Main $args
