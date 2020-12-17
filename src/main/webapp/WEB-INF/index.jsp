<%@page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<script type="text/javascript">
    var name = "${username}";
    var webSocket = new WebSocket("ws://localhost:8080/webSocket/${username}");
    webSocket.onopen = function () {
        alert("恭喜[${username}]成功连接.");
    };
    webSocket.onmessage = function (ev) {
        var newEle = document.createElement("p");
        newEle.innerHTML = ev.data;
        console.log(ev.data);
        document.getElementById("sendInfo").appendChild(newEle).appendChild(document.createElement("br"));
    };

    function send() {
        var user = document.getElementById("inputUser").value;
        var msg = document.getElementById("input").value;
        webSocket.send(user + "|" + name + "|" + msg);
        var newEle = document.createElement("p");
        newEle.innerHTML = "to[" + user + "]: " + msg;
        document.getElementById("sendInfo").appendChild(newEle).appendChild(document.createElement("br"));
    }

</script>

<div>
    请输入你想发送的消息: <label for="input"></label><input id="input" type="text"><br>
    请输入你想发送的用户: <label for="input"></label><input id="inputUser" value="robot" type="text"><br>
    <button onclick="send()">发送</button>
    <br>
</div>

<div id="sendInfo"></div>


</body>
</html>