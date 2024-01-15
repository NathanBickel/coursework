//Written by Nathan Bickel
public class Fruit implements Comparable<Fruit> {
	
	private String type;
	private double weight;
	public static final String DEF_TYPE = "apple";
	public static final String[] VALID_TYPES = {"apple", "orange", "banana", "kiwi", "tomato"};
	public static final double DEF_WEIGHT = 1.0;
	public static final int NUM_ATTRIBUTES = 2;
	
	public Fruit() {
		setType(DEF_TYPE);
		setWeight(DEF_WEIGHT);
	}
	
	public Fruit(String type, double weight) {
		setType(type);
		setWeight(weight);
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		if (type != null) {
			for (int i = 0; i < VALID_TYPES.length; i++)
				if (type.equalsIgnoreCase(VALID_TYPES[i]))
					this.type = type;
			if (this.type == null)
				this.type = DEF_TYPE;
		} else
			this.type = DEF_TYPE;
	}
	
	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		if (weight > 0)
			this.weight = weight;
		else
			this.weight = DEF_WEIGHT;
	}
	
	public String toString() {
		return "Type: " + this.type + " Weight: " + this.weight;
	}
	
	//Returns 2 if higher, -2 if lower, 0 if equal, -1 if other doesn't exist
	public int compareTo(Fruit other) {
		if (other != null) {
			if (this.weight > other.getWeight())
				return 2;
			else if (this.weight < other.getWeight())
				return -2;
			else {
				if (this.type.compareTo(other.getType()) > 0)
					return 2;
				else if (this.type.compareTo(other.getType()) < 0)
					return -2;
				else
					return 0;
			}
		} else
			return -1;
	}
	
}
