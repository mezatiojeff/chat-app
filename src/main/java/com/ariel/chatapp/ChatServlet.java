package com.ariel.chatapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ChatServlet extends HttpServlet {

    // Appelée quand on VISITE la page (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> messages = ChatStorage.getMessages();
        request.setAttribute("messages", messages);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/chat.jsp");
        dispatcher.forward(request, response);
    }

    // Appelée quand on ENVOIE le formulaire (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pseudo = request.getParameter("pseudo");
        String texte = request.getParameter("message");

        if (pseudo != null && texte != null && !texte.trim().isEmpty()) {
            ChatStorage.ajouterMessage(pseudo, texte);
        }

        // Après avoir envoyé, on redirige vers la page de chat pour voir le résultat
        response.sendRedirect("chat");
    }
}
