/*
 * Written by Nathan Bickel
 */
import java.util.Scanner;
import java.io.*;

public class VideoGameDatabaseUI {

	public static final String DELIM = "\t";
	public static final String DEFAULT_FILE = "Collection.txt";
	public static Scanner keyboard = new Scanner(System.in);
	public static GenLL<VideoGame> gameList;
	
	public static void main(String[] args) {
		System.out.println("Welcome! The default list " + DEFAULT_FILE + " has been loaded.");
		readFromFile(true);
		boolean exit = false;
		while (!exit) {
			System.out.println("\nWhat would you like to do next?\nEnter 'change' to load a new list\nEnter 'search' to search for a game\nEnter 'exit' to exit");
			String response = keyboard.nextLine().toLowerCase();
			boolean validResponse = false;
			while (!validResponse) {
				if (response.equals("change")) {
					validResponse = true;
					readFromFile(false);
				}
				else if (response.equals("search")) {
					validResponse = true;
					GenLL<VideoGame> results = search();
					//No sense asking the user if they want to print out an empty file
					if (results.getSize() > 0) {
						System.out.print("Would you like to print these results to a file? Enter 'yes' if you would or 'no' otherwise: ");
						String response2 = keyboard.nextLine().toLowerCase();
						boolean validResponse2 = false;
						while (!validResponse2) {
							if (response2.equals("yes")) {
								validResponse2 = true;
								printToFile(results);
							} else if (response2.equals("no")) {
								validResponse2 = true;
								break;
							} else {
								validResponse2 = false;
								System.out.print("Response not understood, please enter 'yes' or 'no': ");
								response2 = keyboard.nextLine().toLowerCase();
							}
						}
					}
				} else if (response.equals("exit")) {
					validResponse = true;
					exit = true;
				} else {
					validResponse = false;
					System.out.print("Response not understood, please enter 'change', 'search', or 'exit': ");
					response = keyboard.nextLine().toLowerCase();
				}
			}
		}
	}
	
	public static void readFromFile(boolean useDefault) {
		gameList = new GenLL<VideoGame>();
		boolean found = true;
		//Repeats until user enters a valid filename
		if (!useDefault) System.out.print("Enter file name: ");
		do {
			try {
				String fileName;
				if (useDefault) fileName = DEFAULT_FILE;
				else {
					fileName = keyboard.nextLine();
				}
				//Gives user option after initial ask to cancel request to read from a file
				if (found == false && fileName.equals("CANCEL")) fileName = DEFAULT_FILE;
				Scanner fileReader = new Scanner(new File(fileName));
				found = true;
				while (fileReader.hasNextLine()) {
					String[] line = fileReader.nextLine().split(DELIM);
					if (line.length == 2) gameList.add(new VideoGame(line[0], line[1]));
				}
				fileReader.close();
			} catch (FileNotFoundException e) {
				found = false;
				System.out.print("File not found, please enter a file name in the folder, or 'CANCEL' to cancel and use default file: ");
			} catch (Exception e) {
				e.printStackTrace();
				break;
			}	
		} while (!found);
	}
	
	public static GenLL<VideoGame> search() {
		//Gets input
		System.out.print("Enter title to search for (or '*' for wildcard): ");
		String title = keyboard.nextLine().toLowerCase();
		System.out.print("Enter console to search for (or '*' for wildcard): ");
		String console = keyboard.nextLine().toLowerCase();
		//Searches
		GenLL<VideoGame> searchResults = new GenLL<VideoGame>();
		gameList.reset();
		boolean titleMatches;
		boolean consoleMatches;
		while(gameList.hasMore()) {
			//Checks if parameter title is contained in current title or is wildcard
			if (gameList.getCurrent().getTitle().toLowerCase().contains(title) || title.equals("*")) titleMatches = true;
			else titleMatches = false;
			//Checks if parameter console is contained in current console or is wildcard
			if (gameList.getCurrent().getConsole().toLowerCase().contains(console) || console.equals("*")) consoleMatches = true;
			else consoleMatches = false;
			if (titleMatches && consoleMatches) searchResults.add(new VideoGame(gameList.getCurrent().getTitle(), gameList.getCurrent().getConsole()));
			gameList.goToNext();
		}
		if (searchResults.getSize() > 0) {
			System.out.println("Found these matches:");
			searchResults.printlns();
		} else System.out.println("No matches found");
		return searchResults;
	}
	
	public static void printToFile(GenLL<VideoGame> searchResults) {
		//Asking user for file name and whether they want to append or not
		System.out.print("Enter text file name to print to: ");
		String fileName = keyboard.nextLine();
		//Checks that the user is entering a text file and fixes if they aren't
		if (!fileName.endsWith(".txt")) fileName += ".txt";
		System.out.println("Assuming this file already exists, do you want to replace it or append the results to the end?");
		System.out.print("Enter 'append' to append or 'replace' to replace: ");
		String response = keyboard.nextLine();
		boolean validResponse = false;
		//Boolean append defaults to false but to appease compiler but is always reassigned based on user input
		boolean append = false;
		while (!validResponse) {
			if (response.toLowerCase().equals("append")) {
				append = true;
				validResponse = true;
			} else if (response.toLowerCase().equals("replace")) {
				append = false;
				validResponse = true;
			} else {
				validResponse = false;
				System.out.print("Response not understood, please enter 'append' or 'replace: ");
				response = keyboard.nextLine();
			}
		}
		//Prints to file
		try {
			PrintWriter fileWriter;
			if (append) fileWriter = new PrintWriter(new FileOutputStream(fileName, true));
			else fileWriter = new PrintWriter(new FileOutputStream(fileName));
			searchResults.reset();
			while (searchResults.hasMore()) {
				VideoGame current = searchResults.getCurrent();
				fileWriter.println(current.getTitle() + DELIM + current.getConsole());
				searchResults.goToNext();
			}
			fileWriter.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}