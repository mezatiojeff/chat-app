<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Chat App</title>
</head>
<body>

    <h1>💬 Chat App</h1>

    <div style="border: 1px solid #ccc; padding: 10px; width: 400px; height: 300px; overflow-y: scroll;">
        <%
            List<String> messages = (List<String>) request.getAttribute("messages");
            for (String msg : messages) {
        %>
            <p><%= msg %></p>
        <%
            }
        %>
    </div>

    <form action="chat" method="post">
        <input type="text" name="pseudo" placeholder="Ton pseudo" required>
        <input type="text" name="message" placeholder="Ton message" required>
        <button type="submit">Envoyer</button>
    </form>

    <br>
    <a href="chat">🔄 Actualiser</a>

</body>
</html>