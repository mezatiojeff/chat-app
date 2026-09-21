package com.ariel.chatapp;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ChatStorage {

    private static final List<String> messages = Collections.synchronizedList(new ArrayList<>());

    public static void ajouterMessage(String pseudo, String texte) {
        messages.add(pseudo + " : " + texte);
    }

    public static List<String> getMessages() {
        return messages;
    }
}
