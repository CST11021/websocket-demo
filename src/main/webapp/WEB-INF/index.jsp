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
        var newEle1 = document.createElement("p");
        var data = ev.data;
        var ss = data.split("$$");
        if (ss.length > 1) {
            newEle.innerHTML = ss[0];
            newEle1.innerHTML = ss[1];
            var parent = document.getElementById("online");
            if(parent.firstChild!=null){
                parent.removeChild(parent.firstChild);
            }
            parent.appendChild(newEle1).appendChild(document.createElement("br"));
        } else {
            newEle.innerHTML = data;
        }
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
    请输入你想发送的用户: <label for="inputUser"></label><input id="inputUser" value="robot" type="text"><br>
    <button onclick="send()">发送</button>
    <br>
</div>

<div id="sendInfo"></div>

<div id="online">

</div>


</body>
</html>