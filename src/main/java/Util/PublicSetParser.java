package Util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;


public class PublicSetParser {
	 public PublicSetParser() {
	    	
	 }
	 @SuppressWarnings("null")
	public ArrayList<CardSet> getPublicSets(String input, int userId) { // function name is misleading, this func can get private too
		 try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		 ArrayList<CardSet> sets = new ArrayList<CardSet>();
		 try (Connection con= DriverManager.getConnection(  
					Constant.DBUrl, Constant.DBUserName,Constant.DBPassword);) {
			 String setQuery, privateQuery, nameQuery, userQuery;
			 ResultSet rs = null, private_rs = null, name_rs = null, user_rs = null;

			 if (!input.isEmpty()) {
				 System.out.println("Search by name");
				 PreparedStatement nameStmt = null;
				 if (userId > 0) { // user registered
					 nameQuery = "SELECT sets.*, user.name FROM sets, user WHERE owner = user_id AND set_name = ? AND (owner = ? OR private = 0);";
					 nameStmt = con.prepareStatement(nameQuery);
					 nameStmt.setString(1, input);	
					 nameStmt.setInt(2, userId);
					 
				 } else { // user not logged in
					 nameQuery = "SELECT sets.*, user.name FROM sets, user WHERE owner = user_id AND set_name = ? AND private = 0;";
					 nameStmt = con.prepareStatement(nameQuery);
					 nameStmt.setString(1, input);	
				 }
				 name_rs = nameStmt.executeQuery();
				 while (name_rs.next()) {
					 String title = name_rs.getString("set_name");
					 int count = name_rs.getInt("card_number");
					 String description = name_rs.getString("description");
					 int id = name_rs.getInt("set_id");
					 String name = name_rs.getString("name");
					 CardSet cs = new CardSet(id, title, count, description, name); // Create constructor.
					 sets.add(cs);
				 }
				 return sets;					 
			 }
			 // private query
			 if (userId > 0) {
				 System.out.println("Search private sets");
				 privateQuery = "SELECT sets.*, user.name FROM sets, user WHERE owner = user_id AND private = 1 AND owner = ?;";
				 PreparedStatement privateStmt = con.prepareStatement(privateQuery);
				 privateStmt.setInt(1, userId);
				 private_rs = privateStmt.executeQuery();
				 while (private_rs.next()) {
					 String title = private_rs.getString("set_name");
					 int count = private_rs.getInt("card_number");
					 String description = private_rs.getString("description");
					 int id = private_rs.getInt("set_id");
					 String name = private_rs.getString("name");
					 CardSet cs = new CardSet(id, title, count, description, name); // Create constructor.
					 sets.add(cs);
				 }
			 }
			 // public query
			 System.out.println("Search public sets");
			 setQuery = "SELECT sets.*, user.name FROM sets, user WHERE owner = user_id AND private = 0;";
			 Statement stmt = con.createStatement();
			 rs = stmt.executeQuery(setQuery);
			 while(rs.next()) {
				 String title = rs.getString("set_name");
				 int count = rs.getInt("card_number");
				 String description = rs.getString("description");
				 int id = rs.getInt("set_id");
				 String name = rs.getString("name");
				 CardSet cs = new CardSet(id, title, count, description, name); // Create constructor.
				 sets.add(cs);
			 }
			 return sets;
		} 
		catch(Exception e) {
			 System.out.println(e.getMessage());
			 return null;
		}
	 }

//	 	public String getUsername(int id) {
//		 String result = null;
//		 try {
//				Class.forName("com.mysql.jdbc.Driver");
//			} catch (ClassNotFoundException e1) {
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			}
//		 try (Connection con= DriverManager.getConnection(  
//					Constant.DBUrl, Constant.DBUserName,Constant.DBPassword);) {
//			 String sql = "SELECT * FROM flashcards.user WHERE user_id = ?;";
//			 PreparedStatement userStmt = con.prepareStatement(sql);
//			 userStmt.setInt(1, id);
//			 ResultSet rs = userStmt.executeQuery();
//			 while (rs.next()) {
//				 result = rs.getString("name");
//			 }
//		 } catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return result;
//		}	
//		return result;
//	 }
}