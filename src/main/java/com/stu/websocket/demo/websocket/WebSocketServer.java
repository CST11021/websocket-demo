package com.stu.websocket.demo.websocket;

import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author yousj
 * @since 2020/12/16
 */
@Component
@ServerEndpoint("/webSocket/{username}")
public class WebSocketServer {

    private static AtomicInteger onlineNum = new AtomicInteger();

    public static ConcurrentHashMap<String, Session> sessionPools = new ConcurrentHashMap<>();

    //发送消息
    private synchronized void sendMessage(Session session, String message) throws IOException {
        if (session != null) {
            session.getBasicRemote().sendText(message);
        }
    }

    //给指定用户发送信息
    public void sendInfo(String userName, String message) {
        Session session = sessionPools.get(userName);
        try {
            sendMessage(session, message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //建立连接成功调用
    @OnOpen
    public void onOpen(Session session, @PathParam(value = "username") String username) {
        sessionPools.put(username, session);
        addOnlineCount();
        System.out.println(username + "加入webSocket！当前人数为" + onlineNum);
        try {
            for (Session s : sessionPools.values()) {
                sendMessage(s, "系统消息: 欢迎" + username + "加入连接！$$当前在线人数: " + onlineNum);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //关闭连接时调用
    @OnClose
    public void onClose(@PathParam(value = "sid") String userName) {
        sessionPools.remove(userName);
        subOnlineCount();
        System.out.println(userName + "断开webSocket连接！当前人数为" + onlineNum);
    }

    //收到客户端信息
    @OnMessage
    public void onMessage(String message) throws IOException {
        System.out.println("收到消息: " + message);
        String[] split = message.split("\\|");
        if (message.contains("robot")) {
            // 机器人 http://api.qingyunke.com/api.php?key=free&appid=0&msg=
            sendMessage(sessionPools.get(split[1]), "from[robot]: " + JSONObject.parseObject(HttpUtil.get("http://api.qingyunke.com/api.php?key=free&appid=0&msg=" + split[1])).get("content").toString());
        } else {
            sendInfo(split[0], "from[" + split[1] + "]: " + split[2]);
        }
    }

    //错误时调用
    @OnError
    public void onError(Session session, Throwable throwable) {
        System.out.println("发生错误");
        throwable.printStackTrace();
    }

    public static void addOnlineCount() {
        onlineNum.incrementAndGet();
    }

    public static void subOnlineCount() {
        onlineNum.decrementAndGet();
    }


}
