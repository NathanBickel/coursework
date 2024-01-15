//Written by Nathan Bickel
import java.util.Scanner;
public class StringSorter {
	
	public static final String WORD = "sort";
	public static final String QUIT_WORD = "quit";
	public static final String DONE_WORD = "No";
	public static SearchTree tree;
	public static Scanner input = new Scanner(System.in);
	
	public static void main(String[] args) {
		boolean quitProgram = false;
		while (!quitProgram) {
			//Creates a new instance of a binary search tree to store LinkedLists of StringCounters
			tree = new SearchTree();
			System.out.println("Enter any number of strings and I will sort by " + WORD.toUpperCase() + "'s. Once you're done entering sentences enter \"quit\".\n");
			String response = input.nextLine();
			while (!response.equalsIgnoreCase(QUIT_WORD)) {
				tree.add(new StringCounter(response));
				response = input.nextLine();
			}
			if (tree.root != null)
				System.out.println(WORD + " SORTED!");
			tree.print();
			System.out.println("\nWould you like to sort more Strings?");
			String quit = input.nextLine();
			//Assumes the user wants to keep going unless they enter no; could be changed to opt-in
			if (quit.equalsIgnoreCase(DONE_WORD)) {
				quitProgram = true;
				System.out.println("Goodbye!");
			}
		}
	}
	
	//Each String that is input causes a StringCounter to be constructed
	private static class StringCounter {
		
		private String string;
		private int numWords;
		
		public StringCounter(String string) {
			this.string = string;
			this.numWords = 0;
			//Checks each set of characters equal to the length of the target word and checks for a match (and increments the counter if there is one)
			for (int i = 0; i < string.length() - WORD.length() + 1; i++) {
				if (string.substring(i,i+WORD.length()).equalsIgnoreCase(WORD))
					numWords++;
			}
		}
		
	}
	
	
	/* Each node of the tree contains an instance of the LinkedList class (which contains instances of the StringCounter class)
	 Since there are likely to be duplicates numbers of the target word, the word can be added to the list if there is a StringChecker with the same numWords there*/
	private static class LinkedList {
		
		private class ListNode {
			
			private StringCounter stringCounter;
			private ListNode link;
			
			public ListNode(StringCounter data, ListNode link) {
				this.stringCounter = data;
				this.link = link;
			}
			
		}
		
		private ListNode head;
		
		public void add(StringCounter stringCounter) {
			ListNode newNode = new ListNode(stringCounter, null);
			if (head == null)
				head = newNode;
			else {
				ListNode temp;
				for (temp = head; temp.link != null; temp = temp.link);
				temp.link = newNode;
			}
		}
		
		public void print() {
			for (ListNode temp = head; temp != null; temp = temp.link)
				System.out.println(temp.stringCounter.string);
		}
		
	}
	
	private static class SearchTree {
		
		private class Node {
			
			private LinkedList stringCounterList;
			private Node leftChild;
			private Node rightChild;
			
			public Node(StringCounter stringCounter) {
				stringCounterList = new LinkedList();
				stringCounterList.add(stringCounter);
				this.leftChild = this.rightChild = null;
			}
			
		}
		
		//First String that is input forms a linked list at the root
		private Node root;
		
		public void add(StringCounter stringCounter) {
			if (root == null)
				root = new Node(stringCounter);
			else
				add(root, stringCounter);
		}
		
		public Node add(Node node, StringCounter stringCounter) {
			if (node == null)
				node = new Node(stringCounter);
			else if (stringCounter.numWords < node.stringCounterList.head.stringCounter.numWords)
				node.leftChild = add(node.leftChild, stringCounter);
			else if (stringCounter.numWords > node.stringCounterList.head.stringCounter.numWords)
				node.rightChild = add(node.rightChild, stringCounter);
			else
				node.stringCounterList.add(stringCounter);
			return node;
		}
		
		public void print() {
			print(root);
		}
		
		//Uses in order printing since we want ascending order
		public void print(Node node) {
			if (node == null)
				return;
			print(node.leftChild);
			node.stringCounterList.print();
			print(node.rightChild);
		}
		
	}

}
