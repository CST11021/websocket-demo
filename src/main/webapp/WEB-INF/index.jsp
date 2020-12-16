<%@page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<script type="text/javascript">
    var webSocket = new WebSocket("ws://localhost:8080/webSocket/${username}");
    console.log("........");
    webSocket.onopen = function () {
        alert("恭喜你成功连接.");
    };
    webSocket.onmessage = function (ev) {
        var newEle = document.createElement("p");
        newEle.innerHTML = ev.data;
        document.getElementById("sendInfo").appendChild(newEle).appendChild(document.createElement("br"));
    };

    function send() {
        var msg = document.getElementById("input").value;
        webSocket.send(msg);
        var newEle = document.createElement("p");
        newEle.innerHTML = msg;
        document.getElementById("sendInfo").appendChild(newEle).appendChild(document.createElement("br"));
    }

</script>

<div>
    请输入你想发送的消息: <label for="input"></label><input id="input" type="text">
    <button onclick="send()">发送消息</button>
    <br>
</div>

<div id="sendInfo"></div>


</body>
</html>