#pragma once
#include <QString>
#include <string>
namespace Logger {
const static auto logTemplate = QString::fromUtf8(u8R"logTemplate(
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>

<head>
    <title>JaredTao log file</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css" id="logCss">
        body {
            background: #18242b;
            color: #afc6d1;
            margin-right: 20px;
            margin-left: 20px;
            font-size: 14px;
            font-family: Arial, sans-serif, sans;
        }

        a {
            text-decoration: none;
        }

        a:link {
            color: #a0b2bb;
        }

        a:active {
            color: #f59504;
        }

        a:visited {
            color: #adc7d4;
        }

        a:hover {
            color: #e49115;
        }

        h1 {
            text-align: center;
        }

        h2 {
            color: #ebe5e5;
        }

        .d,
        .w,
        .c,
        .f,
        .i {
            padding: 3px;
            overflow: auto;
        }

        .d {
            background-color: #0f1011;
            color: #a8c1ce;
        }

        .i {
            background-color: #294453;
            color: #a8c1ce;
        }

        .w {
            background-color: #7993a0;
            color: #1b2329;
        }

        .c {
            background-color: #ff952b;
            color: #1d2930;
        }

        .f {
            background-color: #fc0808;
            color: #19242b;
        }
    </style>
</head>

<body>
    <h1><a href="http://jaredtao.github.io/">TaoLogger</a> 日志文件</h1>
    <script type="text/JavaScript">
        function objHide(obj) {
            obj.style.display="none"
        }
        function objShow(obj) {
            obj.style.display="block"
        }
        function selectType() {
            var sel = document.getElementById("typeSelect");
            const hideList = new Set(['d', 'i', 'w', 'c', 'f']);
            if (sel.value === 'a') {
                hideList.forEach(element => {
                    var list = document.querySelectorAll('.' + element);
                    list.forEach(objShow);
                });
            } else {
                var ss = hideList;
                ss.delete(sel.value);
                ss.forEach(element => {
                    var list = document.querySelectorAll('.' + element);
                    list.forEach(objHide);
                });
                var showList = document.querySelectorAll('.' + sel.value);
                showList.forEach(objShow);
            }
        }
    </script>
    <select id="typeSelect" onchange="selectType()">
        <option value='a' selected="selected">All</option>
        <option value='d'>Debug</option>
        <option value='i'>Info</option>
        <option value='w'>Warning</option>
        <option value='c'>Critical</option>
        <option value='f'>Fatal</option>
    </select>
)logTemplate");
}
