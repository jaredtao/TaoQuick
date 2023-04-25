$scriptDir=$PSScriptRoot
$currentDir=Get-Location
Write-Host "currentDir" $currentDir
Write-Host "scriptDir" $scriptDir
$names="*.h","*.cpp","*.c","*.hpp"
Get-ChildItem -Include $names -Recurse $currentDir | ForEach-Object {
        clang-format -i $_.FullName
}