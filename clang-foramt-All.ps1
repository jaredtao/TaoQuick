$scriptDir=$PSScriptRoot
$currentDir=Get-Location
Write-Host "currentDir" $currentDir
Write-Host "scriptDir" $scriptDir
$names="*.h","*.cpp","*.c","*.hpp"
$env:Path="C:\Program Files\LLVM\bin;C:\Qt\Tools\QtCreator\bin\clang\bin;$env:Path"
Get-ChildItem -Include $names -Recurse $currentDir | ForEach-Object {
        clang-format -i $_.FullName
}
timeout /t 3