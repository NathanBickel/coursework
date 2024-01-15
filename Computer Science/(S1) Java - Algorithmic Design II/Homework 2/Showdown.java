/*
 * Written by Nathan Bickel
 */

import java.util.Scanner;
import java.io.*;

public class Showdown {

	private final static int NUM_PRIZES = 5;
	private final static String DELIM = "\t";
	private final static String FILE_NAME = "prizeList.txt";
	private static int totalNumPrizes;
	private static Prize[] allPrizes;
	
	static {
		Showdown.createPrizeList();
	}
	
	public static void main(String[] args) {
		boolean stop = false;
		Scanner input = new Scanner(System.in);
		while (!stop) {
			Prize[] chosenPrizes = choosePrizes();
			double trueSum = 0;
			System.out.println("The five items are:");
			for (Prize prize : chosenPrizes) {
				System.out.println(prize.getName());
				trueSum += prize.getPrice();
			}
			System.out.print("What is your guess for the combined price of these items? ");
			double guessSum = 0;
			boolean isValidInput = false;
			//Keeps asking user for a double until they provide a double
			while (!isValidInput) {
				try {
					guessSum = input.nextDouble();
					isValidInput = true;
					input.nextLine();
				} catch (java.util.InputMismatchException e) {
					input.nextLine();
					System.out.print("Please enter a real number: ");
				}
			}
			//Checks that the guess the user gives is in the range
			boolean userWins = guessSum <= trueSum && guessSum >= (trueSum - 2000);
			if (userWins) {
				System.out.print("You win! ");
			} else {
				System.out.print("Sorry, you lose. ");
			}
			//Not strictly necessary but provides user with actual sum, which could be nice to know 
			System.out.print("The actual combined price was " + String.format("$%.0f", trueSum) + ".");
			System.out.println("\n");
			/* If uncommented, prints out each item with its price after winstate is announced
			 * for (Prize prize : chosenPrizes) {
				System.out.println(prize);
			}*/
			//Prompt user to see what they want to do
			System.out.print("Play again? Enter 'exit' to quit or 'continue' to play again: ");
			String response = input.nextLine();
			boolean followup;
			do {
				followup = false;
				if (response.toLowerCase().equals("exit")) {
					stop = true;
				} else if (response.toLowerCase().equals("continue")) {
					stop = false;
				} else {
					System.out.print("Please enter 'exit' or 'continue': ");
					response = input.nextLine();
					followup = true;
				}
			} while (followup);
		}
		input.close();
	}
	
	private static Prize[] choosePrizes() {
		Prize[] chosenPrizes = new Prize[NUM_PRIZES];
		//Generates 5 unique random indices
		int[] chosenPrizesIndices = new int[NUM_PRIZES];
		for (int i = 0; i < NUM_PRIZES; i++) {
			boolean isValidIndex = true;
			int index;
			do {
				index = (int)(Math.random() * totalNumPrizes);
				for (int j = 0; j < i; j++) {
					if (chosenPrizesIndices[j] == index)
						isValidIndex = false;
				}
			} while (!isValidIndex);
			chosenPrizesIndices[i] = index;
		}
		//Adds in prizes to array
		for (int i = 0; i < NUM_PRIZES; i++) {
			chosenPrizes[i] = allPrizes[chosenPrizesIndices[i]];
		}
		return chosenPrizes;
	}
	
	private static void createPrizeList() {
		int totalNumPrizes = 0;
		try {
			//Counts number of valid lines with prizes and creates Prize array of that length
			Scanner fileReader = new Scanner(new File(FILE_NAME));
			while (fileReader.hasNextLine()) {
				String[] line = fileReader.nextLine().split(DELIM);
				if (line.length == 2)
					totalNumPrizes++;
			}
			fileReader.close();
			Prize[] allPrizes = new Prize[totalNumPrizes];
			//Resets scanner at beginning
			fileReader = new Scanner(new File(FILE_NAME));
			int i = 0;
			while (fileReader.hasNextLine()) {
				String[] line = fileReader.nextLine().split(DELIM);
				if (line.length == 2) {
					allPrizes[i] = new Prize(line[0], Double.parseDouble(line[1]));
					i++;
				}
			}
			Showdown.totalNumPrizes = totalNumPrizes;
			Showdown.allPrizes = allPrizes;
			fileReader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}