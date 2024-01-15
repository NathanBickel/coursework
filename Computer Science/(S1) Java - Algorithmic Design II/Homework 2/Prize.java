/*
 * Written by Nathan Bickel
 */
public class Prize {

	private String name;
	private double price;
	
	public Prize() {
		this.setName(null);
		this.setPrice(price);
	}
	
	public Prize(String name, double price) {
		this.setName(name);
		this.setPrice(price);
	}
	
	public String getName() {
		return this.name;
	}
	
	public double getPrice() {
		return this.price;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setPrice(double price) {
		if (price >= 0) {
			this.price = price;
		} else {
			System.out.println("Price cannot be negative, used default value of 0");
			this.price = 0;
		}
	}
	
	public boolean equals(Prize other) {
		return this.name == other.getName() && this.price == other.getPrice(); 
	}
	
	public String toString() {
		return name + ": " + String.format("$%.0f", this.price);
	}
	
}
