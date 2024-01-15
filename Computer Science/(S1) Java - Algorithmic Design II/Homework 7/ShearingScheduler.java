//Written by Nathan Bickel
import java.util.Scanner;
import java.io.*;
import java.util.LinkedList;

public class ShearingScheduler {
	
	private static MinHeap<Sheep> waiting;
	private static LinkedList<Sheep> notArrived;
	private static Scanner keyboard;
	private static Scanner fileReader;
	private static String fileName;
	private static int timeSinceStart;
	private static int timeUntilNextShear;
	public static final String EXIT_WORD = "quit";
	public static final String DELIM = "\t";
	
	public static void main(String[] args) {
		boolean quit = false;
		while (!quit) {
			notArrived = new LinkedList<Sheep>();
			keyboard = new Scanner(System.in);
			timeSinceStart = 0;
			timeUntilNextShear = 0;
			if (constructFileReader() && populateList()) {
				while (!waiting.isEmpty() || !notArrived.isEmpty()) {
					//If any sheep arrive at this time, add them to the heap
					for (int i = 0; i < notArrived.size(); i++) {
						if (notArrived.get(i).getArrivalTime() == timeSinceStart) {
							waiting.add(notArrived.remove(i));
							i--;
						}
					}
					//If it's time to shear another sheep, remove it from the heap and shear it
					if (timeUntilNextShear == 0) {
						Sheep shearing = waiting.remove();
						System.out.println(shearing);
						timeUntilNextShear = shearing.getShearTime();
					}
					//Count down until next shearing
					timeUntilNextShear--;
					//Increment the simulation clock
					timeSinceStart++;
				}
			} else
				break;
			System.out.print("\nWould you like to run the program again? Enter \"yes\" to do so or anything else to quit: ");
			String response = keyboard.nextLine();
			if (!response.equalsIgnoreCase("yes"))
				quit = true;
		}
	}
	
	//Asks user for a file name and makes a Scanner with it; returns false if something went wrong or the user quit
	public static boolean constructFileReader() {
		System.out.print("Input file name: ");
		fileName = keyboard.nextLine();
		boolean fileFound = false;
		while (!fileFound) {
			fileFound = false;
			try {
				fileReader = new Scanner(new File(fileName));
				return true;
			} catch (FileNotFoundException e) {
				System.out.print("File not found, please enter another file name or type \"" + EXIT_WORD + "\" to cancel: ");
				fileName = keyboard.nextLine();
				if (fileName.equalsIgnoreCase(EXIT_WORD))
					return false;
				fileFound = false;
			} catch (Exception e) {
				//Just in case something else goes wrong
				e.printStackTrace();
			}
		}
		return true;
	}
	
	//Creates a heap of the correct size and adds all the sheep to the notArrived list; return false if the list is empty
	public static boolean populateList() {
		//Constructs heap
		int size = 0;
		//Determine size
		while (fileReader.hasNextLine()) {
			size++;
			fileReader.nextLine();
		}
		//Construct a heap of the correct size for worst case-scenario where all sheep are added at once
		if (size == 0)
			return false;
		waiting = new MinHeap<Sheep>(size);
		try {
			fileReader = new Scanner(new File(fileName));
		} catch (Exception e) {
			//If there's an exception here something has truly gone terribly wrong since it just worked
			e.printStackTrace();
		}
		//Populates list
		while (fileReader.hasNextLine()) {
			//Read the line
			String sheepString = fileReader.nextLine();
			//Split the line
			String[] sheepStringArray = sheepString.split(DELIM);
			//Check the line 
			if (sheepStringArray.length == Sheep.NUM_ATTRIBUTES) {
				//Process
				String name = sheepStringArray[0];
				int shearTime;
				int arrivalTime;
				try {
					shearTime = Integer.parseInt(sheepStringArray[1]);
					arrivalTime = Integer.parseInt(sheepStringArray[2]);
				} catch (NumberFormatException e) {
					continue;
				}
				notArrived.add(new Sheep(name, shearTime, arrivalTime));
			}
		}
		return true;
	}
	
}
