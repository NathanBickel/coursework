//Written by Nathan Bickel
public class LinkedBST<T extends Comparable<T>> {
	
	private class Node {
		
		T data;
		Node leftChild;
		Node rightChild;
		
		public Node(T data) {
			this.data = data;
			leftChild = rightChild = null;
		}
		
	}
	
	private Node root;
	
	public void add(T data) {
		if (root == null)
			root = new Node(data);
		else
			add(root,data);
	}
	
	private Node add(Node node, T data) {
		if (node == null)
			node = new Node(data);
		else if (data.compareTo(node.data) < 0)
			node.leftChild = add(node.leftChild, data);
		else if (data.compareTo(node.data) > 0)
			node.rightChild = add(node.rightChild, data);
		return node;
	}
	
	public void printPreOrder() {
		System.out.println("Printing the pre-order traversal");
		printPreOrder(root);
		System.out.println();
	}
	
	private void printPreOrder(Node node) {
		if (node != null) {
			System.out.println(node.data);
			printPreOrder(node.leftChild);
			printPreOrder(node.rightChild);
		}
	}
	
	public void printInOrder() {
		System.out.println("Printing the in-order traversal");
		printInOrder(root);
		System.out.println();
	}
	
	private void printInOrder(Node node) {
		if (node != null) {
			printInOrder(node.leftChild);
			System.out.println(node.data);
			printInOrder(node.rightChild);
		}
	}
	
	public void printPostOrder() {
		System.out.println("Printing the post-order traversal");
		printPostOrder(root);
		System.out.println();
	}
	
	private void printPostOrder(Node node) {
		if (node != null) {
			printPostOrder(node.leftChild);
			printPostOrder(node.rightChild);
			System.out.println(node.data);
		}
	}
	
	public boolean search(T data) {
		return search(root, data);
	}
	
	private boolean search(Node node, T data) {
		if (node == null)
			return false;
		else if (data.compareTo(node.data) < 0)
			return search(node.leftChild, data);
		else if (data.compareTo(node.data) > 0)
			return search(node.rightChild, data);
		else
			return true;
	}
	
	public void remove(T data) {
		root = remove(root, data);
	}
	
	private Node remove(Node node, T data) {
		if (node == null)
			return null;
		else if (data.compareTo(node.data) < 0)
			node.leftChild = remove(node.leftChild, data);
		else if (data.compareTo(node.data) > 0)
			node.rightChild = remove(node.rightChild, data);
		else {
			if (node.rightChild == null)
				return node.leftChild;
			else if (node.leftChild == null)
				return node.rightChild;
			Node temp = findMinInTree(node.rightChild);
			node.data = temp.data;
			node.rightChild = remove(node.rightChild, temp.data);
		}
		return node;
	}
	
	private Node findMinInTree(Node node) {
		if (node == null)
			return null;
		else if (node.leftChild == null)
			return node;
		else
			return findMinInTree(node.leftChild);
	}
	
}
