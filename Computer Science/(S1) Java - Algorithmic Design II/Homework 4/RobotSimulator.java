/*
 * Written by Nathan Bickel
 */
import java.util.Scanner;
import java.io.*;

public class RobotSimulator {
	
	//Declares objects used throughout
	private static char[][] board;
	private static Queue<String> commands;
	private static Scanner fileReader;
	private static Scanner keyboard = new Scanner(System.in);
	private static int[] location = {0,0};
	
	//Declares constants
	public static final int BOARD_SIZE = 10;
	public static final char EMPTY = '_';
	public static final char OBSTC = 'X';
	public static final char ROBOT = '@';
	public static final String UP = "Move Up";
	public static final String DOWN = "Move Down";
	public static final String LEFT = "Move Left";
	public static final String RIGHT = "Move Right";
	
	public static void main(String[] args) {
		System.out.println("Welcome to the Robot Command Simulator!\nEnter a file containing a board and another containing commands, and the program will run the robot until it finishes or crashes.");
		boolean stop = false;
		//Constructs the command queue
		while (!stop) {
			commands = new Queue<String>();
			if (generateBoard() && generateCommandList()) {
				//Sets robot's position to top left
				board[0][0] = '@';
				location[0] = 0;
				location[1] = 0;
				boolean crash = false;
				while (commands.peek() != null) {
					printBoard();
					if(!move()) {
						System.out.println("CRASH");
						crash = true;
						break;
					}
				}
				//Prints the board a final time if the robot didn't crash
				if (!crash)
					printBoard();
			} else
				break;
			//Checks if the user wants to play again
			System.out.print("\nEnter 'continue' to play again or 'stop' to exit: ");
			String response = keyboard.nextLine();
			switch(response.toLowerCase()) {
				case "continue":
					break;
				case "stop":
					stop = true;
					break;				
				default:
					stop = true;
					System.out.print("Answer not undestood, interpreted as 'stop'");
			}
		}
	}
	
	//Returns if cancelled or something went wrong
	public static boolean generateBoard() {
		//Creates board
		board = new char[BOARD_SIZE][BOARD_SIZE];
		System.out.print("Enter name of board file: ");
		String fileName = keyboard.nextLine();
		//Is set to true if the board file can be found
		boolean boardRead = false;
		//Is set to true if the board contains only OBSTC and EMPTY and can be properly transferred to a BOARD_SIZE x BOARD_SIZE char array
		boolean boardPopulated = false;
		while (!boardRead || !boardPopulated) {
			//Resets variables to false in case this has been run multiple times
			boardRead = false;
			boardPopulated = false;
			try {
				//Tries to construct a scanner reading a given file name
				fileReader = new Scanner(new File(fileName));
				//If the try block gets here the board has been read to sets boolean to true
				boardRead = true;
				//Keeps track of row number in board array
				int r = 0;
				while (fileReader.hasNextLine()) {
					//Read the line
					String line = fileReader.nextLine();
					//Split the line
					char[] row = line.toCharArray();
					//Check the line to see if it contains only OBSTC or EMTPY at each character and if it's the right length
					if (line.matches("[" + OBSTC + "" + EMPTY + "]+") && row.length == BOARD_SIZE) {
						if (r < BOARD_SIZE)
							board[r] = row;
						r++;
					}
				}
				//Checks to see if BOARD_SIZE valid rows have been added to the array and keeps asking user for files until one satisfies this
				if (r == BOARD_SIZE)
					boardPopulated = true;
				else {
					boardPopulated = false;
					System.out.print("File entered is in an invalid format, enter another file name or 'STOP' to cancel/quit: ");
					fileName = keyboard.nextLine();
					if (fileName.equals("STOP"))
						return false;
				}
				fileReader.close();
			//Keeps prompting user for files until one is found
			} catch (FileNotFoundException e) {
				System.out.print("File not found, enter another file name or 'STOP' to cancel/quit: ");
				boardRead = false;
				fileName = keyboard.nextLine();
				if (fileName.equals("STOP"))
					return false;
			//Terminates if something other than the file not being found goes wrong
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		//If the program gets here, it should have worked so true is returned
		System.out.println("\nBoard:");
		printBoard();
		return true;
	}
	
	public static void printBoard() {
		for (int r = 0; r < BOARD_SIZE; r++) {
			for (int c = 0; c < BOARD_SIZE; c++)
				System.out.print(board[r][c]);
			System.out.println();
		}
	}
	
	//Returns false if something went wrong or the user cancelled 
	public static boolean generateCommandList() {
		System.out.print("\nEnter name of command file: ");
		String fileName = keyboard.nextLine();
		boolean commandsRead = false;
		while (!commandsRead) {
			commandsRead = false;
			try {
				fileReader = new Scanner(new File(fileName));
				commandsRead = true;
				while (fileReader.hasNextLine()) {
					String command = fileReader.nextLine();
					//Adds commands to the queue as long as they contain the right format
					switch (command) {
						case "Move Up": 
							commands.enqueue(UP);
							break;
						case "Move Down": 
							commands.enqueue(DOWN);
							break;
						case "Move Left":
							commands.enqueue(LEFT);
							break;
						case "Move Right":
							commands.enqueue(RIGHT);
							break;
						default:
							break;	
					}
				}
				fileReader.close();
			} catch (FileNotFoundException e) {
				commandsRead = false;
				System.out.print("File not found, enter another file name or 'STOP' to cancel/quit: ");
				fileName = keyboard.nextLine();
				if (fileName.equals("STOP"))
					return false;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		System.out.println("\nCommands:");
		commands.print();
		System.out.println();
		//If the function gets here nothing should have gone wrong
		return true;
	}
	
	//Returns true if not crash or false if crash
	public static boolean move() {
		System.out.println("\nAttempting To " + commands.peek() + "...");
		String command = commands.dequeue();
		int tempLocR = location[0];
		int tempLocC = location[1];
		switch (command) {
			case UP: 
				tempLocR--;
				break;
			case DOWN:
				tempLocR++;
				break;
			case LEFT:
				tempLocC--;
				break;
			case RIGHT:
				tempLocC++;
				break;
		}
		if (isValidLocation(tempLocR, tempLocC)) {
			board[location[0]][location[1]] = '_';
			location[0] = tempLocR;
			location[1] = tempLocC;
			board[location[0]][location[1]] = '@';
			return true;
		} else
			return false;
	}
	
	//Returns true if r and c are both in bounds of the board and the robot isn't hitting an obstacle
	public static boolean isValidLocation(int r, int c) {
		return r >= 0 && r < BOARD_SIZE && c >= 0 && c < BOARD_SIZE && board[r][c] == EMPTY;
	}
	
}