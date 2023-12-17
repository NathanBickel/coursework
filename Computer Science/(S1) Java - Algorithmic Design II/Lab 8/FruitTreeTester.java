//Written by Nathan Bickel
import java.util.*;
import java.io.*;
public class FruitTreeTester {

	public static LinkedBST<Fruit> fruitTree = new LinkedBST<Fruit>();
	public static LinkedList<Fruit> fruitList = new LinkedList<Fruit>();
	public static Scanner keyboard = new Scanner(System.in);
	public static Scanner fileReader;
	public static final String DELIM = "\t";
	
	public static void main(String[] args) {
		if (constructFileReader()) {
			populateTree();
			fruitTree.printInOrder();
			fruitTree.printPreOrder();
			fruitTree.printPostOrder();
			removeRandomFruit();
		}
	}
	
	//Keeps trying to make the file reader until the user gives a file name that exists or tells it to quit
	public static boolean constructFileReader() {
		System.out.println("Welcome to the fruit tree!");
		System.out.println("Please enter a Fruit File Name");
		String fileName = keyboard.nextLine();
		while (fileReader == null) {
			try {
				fileReader = new Scanner(new File(fileName));
			} catch (FileNotFoundException e) {
				System.out.println("File not found, please enter an existing Fruit File Name or \"quit\" to cancel");
				fileName = keyboard.nextLine();
				//Program stops immediately if they type quit
				if (fileName.equalsIgnoreCase("quit"))
					return false;
			} catch (Exception e) {
				//In case something else goes wrong
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}
	
	//Populates tree as well as linked list
	public static void populateTree() {
		System.out.println("Populating tree file");
		while (fileReader.hasNextLine()) {
			//Read the line
			String fruitString = fileReader.nextLine();
			//Split the line
			String[] fruitStringArray = fruitString.split(DELIM);
			//Check the line
			if (fruitStringArray.length == Fruit.NUM_ATTRIBUTES) {
				String type = fruitStringArray[0];
				double weight;
				try {
					weight = Double.parseDouble(fruitStringArray[1]);
				} catch (NumberFormatException e) {
					continue;
				}
				//Process
				fruitTree.add(new Fruit(type, weight));
				fruitList.add(new Fruit(type, weight));
			}	
		}
	}
	
	public static void removeRandomFruit() {
		//Takes a random fruit reference from the list, passes it to the tree's remove method, and prints out which fruit is being removed
		Fruit fruit = fruitList.remove((int)(Math.random() * fruitList.size()));
		fruitTree.remove(fruit);
		System.out.println("Deleting " + fruit);
		fruitTree.printInOrder();
	}

}
