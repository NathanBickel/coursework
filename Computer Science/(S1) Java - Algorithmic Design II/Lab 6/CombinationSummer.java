//Written by Nathan Bickel
public class CombinationSummer {

	public static final int ARRAY_SIZE = 5;
	public static final int INT_MIN = 0;//Inclusive
	public static final int INT_MAX = 99;//Inclusive
	//Each array in the double array represents which numbers should be pulled: if false, number from that index isn't pulled; if true, it is
	public static boolean[][] combinations = new boolean[(int)(Math.pow(2, ARRAY_SIZE) - 1)][ARRAY_SIZE];
	
	public static void main(String[] args) {
		//Sets every boolean in combinations to false
		for (int r = 0; r < combinations.length; r++)
			for (int c = 0; c < combinations[0].length; c++)
				combinations[r][c] = false;
		int[] array = generateArray();
		System.out.println("Welcome to the sum of all combinations program!");
		//generateArray();
		System.out.print("Given array = {");
		for (int i = 0; i < ARRAY_SIZE - 1; i++)
			System.out.print(array[i] + " ");
		System.out.println(array[ARRAY_SIZE - 1] + "}, all summed combinations are:");
		recursiveSum(0, array);
	}
	
	public static void recursiveSum(int index, int[] array) {
		//Stops after 2^ARRAY_SIZE - 1 because that's how many combinations there should be (and we're not interested in all false so we exclude that case and subtract by 1)
		if (index >= Math.pow(2, ARRAY_SIZE) - 1)
			return;
		//Converts the index + 1 (since we're not interested in index = 0) to binary and then splits each boolean into its own element
		String[] boolArr = Integer.toBinaryString(index + 1).split("");
		int length = 0;
		for (int i = ARRAY_SIZE - 1; i >= ARRAY_SIZE - boolArr.length; i--) {
			combinations[index][i] = boolArr[i - (ARRAY_SIZE - boolArr.length)].equals("1");
			if (combinations[index][i])
				length++;
		}
		//Creates an array that is the length of the number of true booleans in the corresponding boolean array
		int[] temp = new int[length];
		for (int i = 0, j = 0; i < combinations[index].length; i++) {
			if (combinations[index][i]) {
				temp[j] = array[i];
				j++;
			}
		}
		//Prints the sum by calling the method
		printSum(temp);
		recursiveSum(index + 1, array);
	}
	
	public static int[] generateArray() {
		//Creates an array of ARRAY_SIZE and sets each element to a random number from 0 to 99, inclusive
		int[] ret = new int[ARRAY_SIZE];
		for (int i = 0; i < ARRAY_SIZE; i++)
			ret[i] = INT_MIN + (int)(Math.random() * (INT_MAX + 1));
		return ret;
	}
	
	public static void printSum(int[] array) {
		//Calculates total, and then prints each element in the given array with a plus between, and finally an equals sign and the total 
		String ret = "";
		int total = 0;
		for (int i = 0; i < array.length - 1; i++) {
			total += array[i];
			ret += array[i] + " + ";
		}
		total += array[array.length - 1];
		ret += array[array.length - 1] + " = " + total;
		System.out.println(ret);
	}
	
}

// Refactored Dec. 17, 2022
/*import java.util.List;
import java.util.ArrayList;

public class CombinationSummer {

	public static final int ARRAY_SIZE = 5;
	public static final int INT_MIN = 0; //Inclusive
	public static final int INT_MAX = 99; //Inclusive
	
	public static void main(String[] args) {
		int[] array = generateArray();
		System.out.println("Welcome to the sum of all combinations program!");
		System.out.print("Given array = {");
		for (int i = 0; i < ARRAY_SIZE - 1; i++)
			System.out.print(array[i] + " ");
		System.out.println(array[ARRAY_SIZE - 1] + "}, all summed combinations are:");
		recursiveSum(0, array);
	}
	
	public static void recursiveSum(int[] array, List<Integer> indicesIncluded) {
		if (indicesIncluded.size() >= 5)
			return;
		if (!indicesIncluded.isEmpty())
			printSum(array, indicesIncluded);
		List<Integer> indicesIncludedCopy = new ArrayList<Integer>(indicesIncluded);
		for (int i = indicesIncluded.get(indicesIncluded.size()); i < ARRAY_SIZE)
	}
	
	public static int[] generateArray() {
		//Creates an array of ARRAY_SIZE and sets each element to a random number from 0 to 99, inclusive
		int[] ret = new int[ARRAY_SIZE];
		for (int i = 0; i < ARRAY_SIZE; i++)
			ret[i] = INT_MIN + (int)(Math.random() * (INT_MAX + 1));
		return ret;
	}
	
	public static void printSum(int[] array, List<Integer> indices) {
		//Calculates total, and then prints each element in the given array with a plus between, and finally an equals sign and the total 
		String ret = "";
		int total = 0;
		for (int i = 0; i < indices.size() - 1; i++) {
			total += array[indices.get(i)];
			ret += array[indices.get(i)] + " + ";
		}
		ret += array[indices.get(indices.size() - 1)] + " = " + total;
		System.out.println(ret);
	}
	
}*/