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

        <div class="messages" id="messages">
            <!-- Le JavaScript va remplir cette zone -->
        </div>

        <form class="chat-form" id="chatForm">
            <input type="text" id="pseudo" name="pseudo" placeholder="Pseudo" value="<%= monPseudo %>" required>
            <input type="text" id="message" name="message" placeholder="Écris un message..." required>
            <button type="submit">Envoyer</button>
        </form>
    </div>

    <script>
        const monPseudo = "<%= monPseudo %>";
        const messagesDiv = document.getElementById("messages");
        const form = document.getElementById("chatForm");
        const messageInput = document.getElementById("message");

        function chargerMessages() {
            // On vérifie si l'utilisateur est déjà proche du bas AVANT de mettre à jour
            const estEnBas = messagesDiv.scrollHeight - messagesDiv.scrollTop - messagesDiv.clientHeight < 50;

            fetch("messages")
                .then(response => response.json())
                .then(data => {
                    messagesDiv.innerHTML = "";

                    data.forEach(msg => {
                        const bulle = document.createElement("div");
                        const estMoi = msg.pseudo === monPseudo;

                        bulle.className = estMoi ? "message sent" : "message received";

                        if (!estMoi) {
                            const nom = document.createElement("span");
                            nom.className = "pseudo";
                            nom.textContent = msg.pseudo;
                            bulle.appendChild(nom);
                        }

                        bulle.appendChild(document.createTextNode(msg.texte));
                        messagesDiv.appendChild(bulle);
                    });

                    // On ne redescend que si l'utilisateur était déjà en bas
                    if (estEnBas) {
                        messagesDiv.scrollTop = messagesDiv.scrollHeight;
                    }
                });
        }

        form.addEventListener("submit", function (e) {
            e.preventDefault();

            const formData = new URLSearchParams();
            formData.append("pseudo", document.getElementById("pseudo").value);
            formData.append("message", messageInput.value);

            fetch("chat", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: formData
            }).then(() => {
                messageInput.value = "";
                chargerMessages();
            });
        });

        // Charge les messages immédiatement, puis toutes les 2 secondes
        chargerMessages();
        setInterval(chargerMessages, 2000);
    </script>

</body>
</html>