package com.moseoh.assistant.utils;

public class Utils {
    public static String toCapitalize(String str) {
        return Character.toUpperCase(str.charAt(0)) + str.substring(1);
    }

    public static String toCamel(String str) {
        var result = "";
        var temp = str.split("_");
        for (int k = 0; k < temp.length; k++) {
            if (k == 0) {
                result += temp[k];
            } else {
                result += Character.toUpperCase(temp[k].charAt(0)) + temp[k].substring(1);
            }
        }
        return result;
    }
}
