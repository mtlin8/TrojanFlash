package Util;

public class Card {
	String term;
	String def;
	
    public Card(String t, String d) {
    	this.term = t;
    	this.def = d;
    }

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getDef() {
		return def;
	}

	public void setDef(String def) {
		this.def = def;
	}
}
