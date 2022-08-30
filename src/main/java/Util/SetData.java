package Util;

import java.sql.*;

public class SetData {
	private String driver = "com.mysql.cj.jdbc.Driver";
	private String url = Constant.DBUrl;
	private String user = Constant.DBUserName;
	private String password = Constant.DBPassword;
	Connection conn = null;
	
	public void getConn() {
		try {
			Class.forName(driver);
			this.conn = DriverManager.getConnection(  
					Constant.DBUrl, Constant.DBUserName,Constant.DBPassword);
		}
		catch(SQLException e) {
			
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public void insertSet(String setname, int user, String description, int numCards, int privacy) {
		try {
			getConn();
			String sql = "INSERT INTO flashcards.sets(set_name, owner, description, card_number, private) VALUES (?, ?, ?, ?, ?);";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, setname);
			stmt.setInt(2, user);
			stmt.setString(3, description);
			stmt.setInt(4, numCards);
			stmt.setInt(5, privacy);
			stmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void insertCard(int setid, String term, String def) {
		try {
			getConn();
			String sql = "INSERT INTO flashcards.cards (set_id, term, def) VALUES (?, ?, ?);";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, setid);
			stmt.setString(2, term);
			stmt.setString(3, def);
			stmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public int getSetID(String setname, int user) {
		int setID = 1;
		try {
			getConn();
			String sql = "SELECT * FROM flashcards.sets WHERE set_name = ? AND owner = ?;";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, setname);
			stmt.setInt(2, user);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				setID = rs.getInt("set_id");
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return setID;
	}
}
