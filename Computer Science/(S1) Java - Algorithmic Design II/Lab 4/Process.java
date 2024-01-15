/*
 * Written by Nathan Bickel
 */
public class Process {

	private String processName;
	private double completionTime;
	
	//Constructor calls setters
	public Process(String processName, double completionTime) {
		this.setProcessName(processName);
		this.setCompletionTime(completionTime);
	}
	
	public String getProcessName() {
		return this.processName;
	}
	
	public void setProcessName(String processName) {
		if (processName != null) this.processName = processName;
		else this.processName = "none";
	}
	
	public double getCompletionTime() {
		return this.completionTime;
	}
	
	//Assigns completion time unless paramater is less than zero
	public void setCompletionTime(double completionTime) {
		if (completionTime >= 0.0) this.completionTime = completionTime;
		else this.completionTime = 0.0;
	}
	
	public String toString() {
		return ("Process Name: " + this.processName + " Completion Time: " + this.completionTime);
	}
	
}
