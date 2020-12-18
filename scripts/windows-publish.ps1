$scriptDir=$PSScriptRoot
$currentDir=Get-Location
Write-Host "currentDir" $currentDir
Write-Host "scriptDir" $scriptDir


function Main() {
    if ($args.Length -le 1 ) {
        Write-Host "args missing, need at last 2, real " $args.Length
        return
    }

    [string]$archiveName=$args[0]
    [string]$targetName=$args[1]
    
    New-Item -ItemType Directory $archiveName
    # 拷贝exe
    Copy-Item bin\release\$targetName $archiveName\
    Copy-Item bin\release\Trans $archiveName\Trans -Recurse
    # 拷贝依赖
    windeployqt --qmldir . $archiveName\$targetName
    # 删除不必要的库
    #$excludeList = @("*.qmlc", "*.ilk", "*.exp", "*.lib", "*.pdb")
    #Remove-Item -Path Qml -Include $excludeList -Recurse -Force
    # 打包zip
    Compress-Archive -Path $archiveName $archiveName'.zip'
}

Main $args


