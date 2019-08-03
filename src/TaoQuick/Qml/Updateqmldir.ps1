$cur= Get-Location
$ver="1.0"
if (Test-Path qmldir) {
    Clear-Content qmldir
}
Get-ChildItem -Recurse BasicComponent | ForEach-Object -Process {
    if ($_ -is [System.IO.FileInfo]) {
        $filePath = Resolve-Path -Relative $_.Directory
        $filePath = $filePath.Remove(0, 2)
        $filePath = $filePath + "\" + $_.Name
        $filePath=$filePath.Replace('\', '/')
        $line = ($_.BaseName, $ver, $filePath) -join " "
        $line | Out-File -Append -Encoding "utf8" qmldir
    }
}