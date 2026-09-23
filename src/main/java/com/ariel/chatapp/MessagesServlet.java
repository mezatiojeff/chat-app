package com.ariel.chatapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class MessagesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<String> messages = ChatStorage.getMessages();

        StringBuilder json = new StringBuilder();
        json.append("[");

        for (int i = 0; i < messages.size(); i++) {
            String[] parts = messages.get(i).split(" : ", 2);
            String pseudo = parts.length > 0 ? parts[0] : "";
            String texte = parts.length > 1 ? parts[1] : "";

            json.append("{");
            json.append("\"pseudo\":\"").append(escape(pseudo)).append("\",");
            json.append("\"texte\":\"").append(escape(texte)).append("\"");
            json.append("}");

            if (i < messages.size() - 1) {
                json.append(",");
            }
        }

        json.append("]");

        PrintWriter out = response.getWriter();
        out.print(json.toString());
    }

    // Empêche les messages contenant des guillemets de casser le JSON
    private String escape(String text) {
        return text.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
