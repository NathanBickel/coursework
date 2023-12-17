//Written by Nathan Bickel
public class Sheep implements Comparable<Sheep> {
	
	private String name;
	private int shearTime;
	private int arrivalTime;
	public static final int DEF_SHEAR_TIME = 1;
	public static final int DEF_ARRIVAL_TIME = 0;
	public static final int NUM_ATTRIBUTES = 3;
	
	public Sheep(String name, int shearTime, int arrivalTime) {
		setName(name);
		setShearTime(shearTime);
		setArrivalTime(arrivalTime);
	}
	
	public String getName() {
		return this.name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getShearTime() {
		return this.shearTime;
	}
	
	public void setShearTime(int shearTime) {
		if (shearTime < 0) {
			System.out.println("Error, shear time cannot be negative, using default value of " + DEF_SHEAR_TIME);
			this.shearTime = DEF_SHEAR_TIME;
		} else
			this.shearTime = shearTime;		
	}
	
	public int getArrivalTime() {
		return this.arrivalTime;
	}
	
	public void setArrivalTime(int arrivalTime) {
		if (arrivalTime < 0) {
			System.out.println("Error, arrival time cannot be negative, using default value of " + DEF_ARRIVAL_TIME);
			this.arrivalTime = DEF_ARRIVAL_TIME;
		} else {
			this.arrivalTime = arrivalTime;
		}
	}
	
	public int compareTo(Sheep other) {
		if (this.shearTime < other.getShearTime())
			return -1;
		else if (this.shearTime > other.getShearTime())
			return 1;
		else {
			if (this.name.compareTo(other.getName()) < 0)
				return -1;
			else if (this.name.compareTo(other.getName()) > 0)
				return 1;
			else
				return 0;
		}
	}
	
	public String toString() {
		return "Name: " + this.name + ", Shear Time: " + this.shearTime + ", Arrival Time: " + this.arrivalTime;
	}
}
