<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%
    String monPseudo = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("monPseudo")) {
                monPseudo = c.getValue();
            }
        }
    }
%>

<html>
<head>
    <title>Chat App</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="chat-container">
        <div class="chat-header">💬 Chat App</div>

        <div class="messages">
            <%
                List<String> messages = (List<String>) request.getAttribute("messages");
                for (String msg : messages) {
                    String[] parts = msg.split(" : ", 2);
                    String pseudo = parts.length > 0 ? parts[0] : "";
                    String texte = parts.length > 1 ? parts[1] : "";

                    boolean estMoi = pseudo.equals(monPseudo);
                    String bulleClass = estMoi ? "message sent" : "message received";
            %>
                <div class="<%= bulleClass %>">
                    <% if (!estMoi) { %>
                        <span class="pseudo"><%= pseudo %></span>
                    <% } %>
                    <%= texte %>
                </div>
            <%
                }
            %>
        </div>

        <form class="chat-form" action="chat" method="post">
            <input type="text" id="pseudo" name="pseudo" placeholder="Pseudo" value="<%= monPseudo %>" required>
            <input type="text" id="message" name="message" placeholder="Écris un message..." required>
            <button type="submit">Envoyer</button>
        </form>

        <a class="refresh-link" href="chat">🔄 Actualiser</a>
    </div>

</body>
</html>