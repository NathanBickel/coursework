/*
 * Written by Nathan Bickel
 */
public class DoubleDoubleLL {
	
	private class ListNode {
		
		private double data;
		private ListNode linkF;
		private ListNode linkB;
		
		public ListNode(double data, ListNode linkF, ListNode linkB) {
			this.data = data;
			this.linkF = linkF;
			this.linkB = linkB;
		}
		
	}
		
	private ListNode head;
	private ListNode tail;
	private ListNode current;
	
	public DoubleDoubleLL() {
		head = tail = current = null;
	}
	
	public void gotoNext() {
		//Goes forward if current and link after current exist, can print what happened otherwise
		if (current == null) System.out.println("Current is null");
		else current = current.linkF;
	}	
	
		
	public void gotoPrev() {
		//Goes back if current and link before current exist, can print what happened otherwise
		if (current == null) System.out.println("Current is null");
		else current = current.linkB;
		
	}
	
	public void reset() {
		current = head;
	}
	
	public void gotoEnd() {
		current = tail;
	}
	
	public boolean hasMore() {
		return current != null;
	}
	
	//Outputs Double class to allow null to be returned
	public Double getCurrent() {
		if (current != null) return current.data;
		else {
			System.out.println("Current is null");
			return null;
		}
	}
	
	public void setCurrent(double data) {
		if (current != null) current.data = data;
		else System.out.println("Current is null");
	}
	
	public void add(double data) {
		//Adds a new ListNode and appends to tail's linkF if there any elements in the list
		if (head != null) {
			tail.linkF = new ListNode(data, null, tail);
			tail = tail.linkF;
		//Otherwise sets everything to the first element
		} else head = current = tail = new ListNode(data, null, null);
	}
	
	public void addAfterCurrent(double data) {
		if (current == null) System.out.println("Current is null");
		//Calls add method is current is last element
		else if (current == tail) add(data);
		else {
			ListNode temp = current.linkF;
			//Sets current's forward link to a new node, which points forward to temp and back to current
			current.linkF = new ListNode(data, temp, current);
			//Goes forward two nodes and sets the back link to the new node
			current.linkF.linkF.linkB = current.linkF;
		}
	}
	
	public void remove(double data) {
		if (head != null) {
			boolean removed = false;
			if (head.data == data) {
				removeHead();
				removed = true;
			} else {
				for (ListNode temp = head.linkF; temp.linkF != null; temp = temp.linkF) {
					if (temp.data == data) {
						//Sets the previous node's linkF to skip over the current node and link to the next one
						temp.linkB.linkF = temp.linkF;
						//Sets the next node's linkB to skip over the current node and link to the previous one
						temp.linkF.linkB = temp.linkB;
						removed = true;
						//Should remove this break, get rid of the else, and the !removed check in the next statement if method is supposed to remove every instance found rather than the first one
						break;
					}
				}
			}
			if (tail.data == data && !removed ) {
				removeTail();
				removed = true;
			}
			//Notifies user of class that no element has been removed
			if (!removed) System.out.println("Element not found, nothing removed");
		} else System.out.println("List is empty, nothing removed");
	}
	
	public void removeCurrent() {
		if (current == null) /*System.out.println("Current is null")*/;
		else if (current == head) removeHead();
		else if (current == tail) removeTail();
		else {
			//Uses same idea as remove(double data)
			current.linkB.linkF = current.linkF;
			current.linkF.linkB = current.linkB;
			current = current.linkF;
		}
	}
	
	public void print() {
		if (head != null) for (ListNode temp = head; temp != null; temp = temp.linkF) System.out.println(temp.data);	
		else System.out.println("List is empty, nothing to print");
	}
	
	public boolean contains(double data) {
		boolean contains = false;
		if (head != null) { 
			for (ListNode temp = head; temp != null; temp = temp.linkF) {
				if (temp.data == data) {
					contains = true;
				}
			}
		} else System.out.println("List is empty, contains nothing");
		return contains;
	}
	
	//Helper method
	private void removeHead() {
		if (current == head) current = current.linkF;
		head = head.linkF;
		head.linkB = null;
	}
	
	//Helper method
	private void removeTail() {
		if (current == tail) current = current.linkB;
		tail = tail.linkB;
		tail.linkF = null;
	}

}
