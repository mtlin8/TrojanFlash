package Util;

public class CardSet {
	String name; // Set title
	int count; // Set size
	String description;
	int id;
	String ownerName;
	
	public CardSet(int id, String n, int c, String d, String ownerName) {
		this.name = n;
		this.count = c;
		this.description = d;
		this.id = id;
		this.ownerName = ownerName;
	}
	
	public String getName() {
		return this.name;
	}
	
	public int getCount() {
		return this.count;
	}
	
	public int getID() {
		return this.id;
	}
	
	public String getDescription() {
		return this.description;
	}
	
	public String getOwner() {
		return this.ownerName;
	}
}
