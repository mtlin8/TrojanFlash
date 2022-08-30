package Util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;


public class CardParser {
	private String user = Constant.DBUserName;
	private String password = Constant.DBPassword;
	
	 public CardParser() {
	    	
	 }
	 
	 public ArrayList<Card> getCards(int set) {
		 ArrayList<Card> cards = new ArrayList<Card>();
		 try {
            Class.forName("com.mysql.jdbc.Driver");
            //TODO check if you've done the initialization
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
		try (Connection con= DriverManager.getConnection(  
					Constant.DBUrl, Constant.DBUserName,Constant.DBPassword);) {
			 
		    // Query/statement to insert the values
			String query1 = "SELECT * FROM flashcards.cards WHERE set_id =?";
			PreparedStatement in = con.prepareStatement(query1);
			in.setInt(1, set);
		    ResultSet rs = 	in.executeQuery();
		    while(rs.next()) {
		      	String def = rs.getString("def");
            	String term = rs.getString("term");
            	Card c = new Card(term, def);
            	cards.add(c);
		    }
            return cards;
      
		} 
		catch(Exception e) {
			 System.out.println(e.getMessage());
			 return null;
		}  
	 }
}