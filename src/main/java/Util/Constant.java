package Util;

import java.util.regex.Pattern;

public class Constant {
    //TODO replace it with your DB credentials
    static public String DBUserName = "root";
    static public String DBPassword = "password";
    static public String DBUrl = "jdbc:mysql://localhost:3306/flashcards";
    static public String namePattern = "^[ A-Za-z]+$";
    static public String emailPattern = "^[a-zA-Z0-9_+&*-]+(?:\\."
            + "[a-zA-Z0-9_+&*-]+)*@"
            + "(?:[a-zA-Z0-9-]+\\.)+[a-z"
            + "A-Z]{2,7}$";

}
