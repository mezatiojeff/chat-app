package com.ariel.chatapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ChatServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> messages = ChatStorage.getMessages();
        request.setAttribute("messages", messages);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/chat.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pseudo = request.getParameter("pseudo");
        String texte = request.getParameter("message");

        if (pseudo != null && texte != null && !texte.trim().isEmpty()) {
            ChatStorage.ajouterMessage(pseudo, texte);

            // On mémorise le pseudo dans un cookie, pour 1 jour
            Cookie cookie = new Cookie("monPseudo", pseudo);
            cookie.setMaxAge(60 * 60 * 24);
            cookie.setPath("/");
            response.addCookie(cookie);
        }

        response.sendRedirect("chat");
    }
}