$cur= Get-Location
$ver="1.0"
$single="singleton"

function WriteLine {
    $info = $args[0]
    if ($info -is [System.IO.FileInfo]) {
        $filePath = Resolve-Path -Relative $info.Directory
        $filePath = $filePath.Remove(0, 2)
        $filePath = $filePath + "\" + $info.Name
        $filePath=$filePath.Replace('\', '/')
        $line = ($info.BaseName, $ver, $filePath) -join " "
        if ($info.BaseName -eq "TCommon") {
            $line = ($single, $line) -join " "
        }
        $line | Out-File -Append -Encoding "utf8" qmldir
    }
}

if (Test-Path qmldir) {
    Clear-Content qmldir
}

Get-ChildItem -Recurse BasicComponent | ForEach-Object -Process {
    WriteLine $_
}
Get-ChildItem -Recurse EffectComponent | ForEach-Object -Process {
    WriteLine $_
}