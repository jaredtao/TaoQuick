$baiduId = "xxxx"
$baiduSecret = "xxxx"
$baiduLangs = @{
    zh="中文";
    # cht="繁体中文";
    yue="粤语";
    wyw="文言文";
    jp="日语";
    kor="韩语";
    fra="法语";
    spa="西班牙语";
    th="泰语";
    ara="阿拉伯语";
    ru="俄语";
    pt="葡萄牙语";
    de="德语";
    it="意大利语";
    el="希腊语";
    nl="荷兰语";
    # pl="波兰语";
    bul="保加利亚语";
    est="爱沙尼亚语";
    dan="丹麦语";
    fin="芬兰语";
    cs="捷克语";
    rom="罗马尼亚语";
    # slo="斯洛文尼亚语";
    # swe="瑞典语";
    hu="匈牙利语";
    # vie="越南语";
}


$youdaoId = "1bd659586c52ea1d"
$youdaoSecret = "5ZktXhHfLCpI0KnAdcxx4cPyGJwcVXaV"

function getHash([string]$source) {
    $stringAsStream = [System.IO.MemoryStream]::new()
    $writer = [System.IO.StreamWriter]::new($stringAsStream)
    $writer.write($source)
    $writer.Flush()
    $stringAsStream.Position = 0
    $hash = Get-FileHash -InputStream $stringAsStream -algorithm MD5
    
    return $hash.Hash.toString().toLower()
}


function baiduTrans {
    param(
        [string]$q,
        [string]$from = 'en',
        [string]$to = 'zh'
    
    )
    
    $salt = Get-Random
    $signtoken = "{0}{1}{2}{3}" -f $baiduId, $q, $salt, $baiduSecret
    $signtoken = getHash $signtoken
    $body = @{
        q     = $q
        from  = $from
        to    = $to
        appid = $baiduId
        salt  = $salt
        sign  = $signtoken
    }
    $response = Invoke-RestMethod http://api.fanyi.baidu.com/api/trans/vip/translate -Method Post -Body $body
    
    #return $response.dst.toString()
    if ($null -ne $response.trans_result) {
        return  $response.trans_result[0].dst 
    }
    else {
        return $q
    }
}
function trans() {
    $json = Get-Content 'Trans/keys.json' -Encoding  utf8 | ConvertFrom-Json
    foreach ($lang in $baiduLangs.Keys) {
        Write-Host $lang
        $tlang = $baiduLangs[$lang]
        if ($lang -ne "zh") {
            $tlang = baiduTrans $baiduLangs[$lang] "zh" $lang
        }
        $res=@()
        foreach ($key in $json) {
            Write-Host $key
            $dst = baiduTrans $key "en" $lang
            $t = @{'key'=$key; 'value'=$dst}
            $res +=$t
            Start-Sleep -Seconds 1
        }
        $obj = @{
            "lang" = $tlang
            "trans" = $res
        }
        $targetFileName = "Trans/language_{0}.json" -f $lang
        $obj | ConvertTo-Json | Set-Content $targetFileName -Encoding UTF8
    }
}

# baiduTrans  "apple" "en" "zh"

trans