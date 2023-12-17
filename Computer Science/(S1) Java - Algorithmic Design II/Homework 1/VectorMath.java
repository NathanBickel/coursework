/*
 * Written by Nathan Bickel
 */
//Import Scanner to get input
import java.util.Scanner;

public class VectorMath {

	//Maximum dimensions a vector is allowed to have to prevent memory issues; set at 100 for now, over 100 seems unreasonable
	public static final int MAX_DIMENSIONS = 100;
	//Maximum additional vectors the user is allowed to input; set at 100 for now for same reason
	public static final int MAX_ADDITIONAL_VECTORS = 100;
	//Maximum coordinate that wouldn't cause integer overflow if max values were used (based on MAX_DIMENSIONS and MAX_ADDITIONAL_VECTORS)
	public static final int MAX_COORDINATE = (int)((Integer.MAX_VALUE) / (Math.sqrt(MAX_DIMENSIONS) * Math.abs(MAX_ADDITIONAL_VECTORS)));
	
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		Vector originalVector = createVector();
		System.out.println();
		String response = "";
		//The way the user interacts with the program to do things with their vector
		do {
			System.out.println("What would you like to do with your original vector? Enter:\n'Change' to change your original vector\n'Magnitude' to find its magnitude\n'Add' to add other vectors to it\n'Subtract' to subtract other vectors from it\n'Exit' to stop");
			//Converts everything to lower-case so capitalization doesn't matter
			response = input.nextLine().toLowerCase();
			//Changes original vector to a new vector
			if (response.equals("change")) {
				originalVector = createVector();
			//Returns magnitude
			} else if (response.equals("magnitude")) {
				System.out.println("The magnitude is " + originalVector.getMagnitude());
			//Adds however many vectors the user wants
			} else if (response.equals("add")) {
				System.out.println("How many vectors do you want to add to your original vector?");
				System.out.println("Sum is a " + addOrSubtractVectors(originalVector, false));
			//Subtracts however many vectors the user wants
			} else if (response.equals("subtract")) {
				System.out.println("How many vectors do you want to subtract from your original vector?");
				System.out.println("Difference is a " + addOrSubtractVectors(originalVector, true));
			//Catch-all for if the user enters something other than one of the commands
			} else if (!response.toLowerCase().equals("exit")) {
				System.out.print("Command not understood, please try again:");
			}
		System.out.println();
		//Stops the program
		} while (!response.toLowerCase().equals("exit"));
	}
	
	//Creates vector given number of dimensions
	private static Vector createVector(int numDimensions) {
		Scanner input = new Scanner(System.in);
		double[] coordinates = new double[numDimensions];
		for (int i = 0; i < numDimensions; i++) {
			System.out.print("Enter coordinate " + (i + 1) + ": ");
			boolean isValidInput = false;
			coordinates[i] = 0;
			//Checks that the input to the Scanner is a double and keeps prompting until a double is entered
			while (!isValidInput || coordinates[i] > MAX_COORDINATE || coordinates[i] < -MAX_COORDINATE) {
				try {
					coordinates[i] = input.nextDouble();
					isValidInput = true;
				} catch (java.util.InputMismatchException e) {
					input.nextLine();
					isValidInput = false;
					System.out.print("Invalid input, enter a real number: ");
				} finally {
					if (coordinates[i] > MAX_COORDINATE || coordinates[i] < -MAX_COORDINATE) {
						coordinates[i] = 0;
						isValidInput = false;
						input.nextLine();
						System.out.print("Coordinates are capped between " + -MAX_COORDINATE + " and " + MAX_COORDINATE + ", enter a real number in that range: ");
					}
				}
			}
			input.nextLine();
		}
		return new Vector(coordinates);
	}
	
	//Overloaded method; Creates vector where user is asked for number of dimensions, used originally and if the user wants to change
	private static Vector createVector() {
		System.out.println("Creating your vector...");
		Scanner input = new Scanner(System.in);
		System.out.print("How many dimensions? ");
		boolean isValidInput = false;
		int numDimensions = -1;
		//Keeps prompting for a new number while the input is not valid or the number is less than 0 or greater than the maximum allowed
		while (!isValidInput || numDimensions < 0 || numDimensions > MAX_DIMENSIONS) {
			try {
				numDimensions = input.nextInt();
				isValidInput = true;
			} catch (java.util.InputMismatchException e) {
				input.nextLine();
				isValidInput = false;
			} finally {
				if (numDimensions < 0) {
					System.out.print("Invalid input, enter an integer between 0 and " + MAX_DIMENSIONS + ", inclusive: ");
				} else if (numDimensions > MAX_DIMENSIONS) {
					numDimensions = -1;
					System.out.print("Number of dimensions is capped at " + MAX_DIMENSIONS + ", enter a smaller non-negative integer: ");
				}
			}
		}
		//Creates vector with given number of dimensions
		input.nextLine();
		return createVector(numDimensions);
	}
	
	private static Vector addOrSubtractVectors(Vector originalVector, boolean negate) {
		Scanner input = new Scanner(System.in);
		boolean isValidInput = false;
		int numVectors = -1;
		//Checks that the user has entered a non-negative integer; if user wants to add 2 vectors, 1 should be entered 
		while (!isValidInput || numVectors < 0 || numVectors > MAX_ADDITIONAL_VECTORS) {
			try {
				numVectors = input.nextInt();
				isValidInput = true;
			} catch (java.util.InputMismatchException e) {
				input.nextLine();
				isValidInput = false;
			} finally {
				if (numVectors < 0) {
					System.out.print("Invalid input, enter an integer between 0 and " + MAX_ADDITIONAL_VECTORS + ", inclusive: ");
				} else if (numVectors > MAX_ADDITIONAL_VECTORS) {
					numVectors = -1;
					System.out.print("Number of additional vectors is capped at " + MAX_ADDITIONAL_VECTORS + ", enter a smaller non-negative integer: ");
				}
			}
		}
		//Creates list of vectors to add and adds in the original vector
		Vector[] vectors = new Vector[numVectors + 1];
		vectors[0] = originalVector;
		//Adds into the list as many vectors as the user requested, starting at position 1
		for (int i = 1; i <= numVectors; i++) {
			System.out.println("Creating additional vector " + i + "...");
			vectors[i] = createVector(originalVector.getNumDimensions());
			//Makes all the vectors negative for subtracting
			if (negate) {
				vectors[i].negate();
			}
		}
		input.nextLine();
		return Vector.addVectors(vectors);	
	}
}