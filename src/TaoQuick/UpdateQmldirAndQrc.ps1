$cur= Get-Location
$ver="1.0"
$single="singleton"
$qmldirFileName="qmldir"
$qrcFileName="TaoQuick.qrc"
function WriteQmlDirLine {
    $info = $args[0]
    if ($info -is [System.IO.FileInfo]) {
        $filePath = Resolve-Path -Relative $info.Directory
        $filePath = $filePath + "\" + $info.Name
        $filePath=$filePath.Replace('\', '/')
        if ($filePath.EndsWith("main.qml")) 
        {
            return
        }
        if ($filePath.StartsWith('./')) 
        {
            $filePath = $filePath.Remove(0, 2)
        }

        $line = ($info.BaseName, $ver, $filePath) -join " "
        if ($info.BaseName.EndsWith("Config") -or $info.BaseName.EndsWith("Constant") -or $info.BaseName.EndsWith("Common" )) {
            $line = ($single, $line) -join " "
        }
        Out-File -Append -Encoding "utf8"  -FilePath $qmldirFileName  -InputObject $line
    }
}

function WriteQrcBegin {
    $header="<RCC>"
    Out-File -Append -Encoding "utf8" -FilePath $qrcFileName -InputObject $header

    $prefix='    <qresource prefix="/TaoQuick">' 
    Out-File -Append -Encoding "utf8" -FilePath $qrcFileName -InputObject $prefix

    $line = '        <file>' + $qmldirFileName+ '</file>'
    Out-File -Append -Encoding "utf8" -FilePath $qrcFileName -InputObject $line
}

function WriteQrcEnd {
    $prefix='    </qresource>'
    Out-File -Append -Encoding "utf8" -FilePath $qrcFileName -InputObject $prefix

    $header="</RCC>"
    Out-File -Append -Encoding "utf8" -FilePath $qrcFileName -InputObject $header
}

function WriteQrcLine {
    $info = $args[0]
    if ($info -is [System.IO.FileInfo]) {
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
        $line = '        <file>' + $filePath + '</file>'
        Out-File -Append -Encoding "utf8" -FilePath $qrcFileName -InputObject $line
    }
}

function Main {
    # clear qmldir
    if (Test-Path $qmldirFileName) {
        Clear-Content $qmldirFileName
    }
    "module TaoQuick" | Out-File -Append -Encoding "utf8" $qmldirFileName
    # write qmldir
    Get-ChildItem -Recurse Qml -Exclude designer -Filter *.qml  | ForEach-Object -Process {
        WriteQmlDirLine $_
    }
    # clear qrc
    if (Test-Path $qrcFileName) {
        Clear-Content $qrcFileName
    }
    # write qrc header
    WriteQrcBegin
    # write qrc content
    Get-ChildItem -Recurse Qml -Filter *.qml | ForEach-Object -Process {
        WriteQrcLine $_
    }
    Get-ChildItem -Recurse Images -Filter *.png | ForEach-Object -Process {
        WriteQrcLine $_
    }
    Get-ChildItem -Recurse Images -Filter *.jpg | ForEach-Object -Process {
        WriteQrcLine $_
    }
    # write qrc tail
    WriteQrcEnd
}

Main $args
