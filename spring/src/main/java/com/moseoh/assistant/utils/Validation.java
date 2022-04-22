package com.moseoh.assistant.utils;

import java.util.regex.Pattern;

public class Validation {
    public static boolean checkEmail(String email) {
        String regexPattern = "^(.+)@(\\S+)$";
        return Pattern.compile(regexPattern).matcher(email).matches();
    }
}
