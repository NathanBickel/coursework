/*
 * Written by Nathan Bickel
 */
public class GenLL<T> {
	
	//Private class that is used as nodes of linked list
	private class ListNode {
		
		private T data;
		private ListNode link;
		
		public ListNode(T data, ListNode link) {
			this.data = data;
			this.link = link;
		}
		
	}
	
	private ListNode head;
	private ListNode previous;
	private ListNode current;
	private int size;
	
	//Default constructor used
	
	//Returns data at current
	public T getCurrent() {
		if (current == null) return null;
		else return current.data;
	}
	
	//Lets user set data at current
	public void setCurrent(T data) {
		if (current == null) System.out.println("Current is null");
		else current.data = data;
	}
	
	//Returns size
	public int getSize() {
		return size;
	}
	
	//Moves current one element forward if possible and returns whether or not the element was able to go forward
	public boolean goToNext() {
		if (current != null) {
			previous = current;
			current = current.link;
			return true;
		} else {
			System.out.println("End of list reached");
			return false;
		}
	}
	
	//Moves current a specified number of times forward, or to the end of the list if number of times exceeds length
	public void goToNext(int numberTimes) {
		for (int i = 0; i < numberTimes; i++) if (!goToNext()) {
			current = previous;
			break;
		}
	}
	
	//Moves current back to the beginning of the list
	public void reset() {
		current = head;
		previous = null;
	}
	
	//Returns if current is null, which means there are no more nodes to go to
	public boolean hasMore() {
		return current != null;
	}
	
	//Adds node at end of list
	public void add(T data) {
		ListNode newNode = new ListNode(data, null);
		if (head == null) {
			head = current = newNode;
		} else {
			ListNode temp;
			for (temp = head; temp.link != null; temp = temp.link);
			temp.link = newNode;
		}
		size++;
	}
	
	//Adds node after current
	public void addAfterCurrent(T data) {
		if (current != null) {
			ListNode newNode = new ListNode(data, current.link);
			current.link = newNode;
			size++;
		}
	}
	
	//Returns data at index i
	public T get(int index) {
		if (index < 0 || index >= this.size) {
			System.out.println("Out of bounds error");
			return null;
		} else {
			ListNode temp = head;
			for (int i = 0; i < index; i++) {
				temp = temp.link;
			}
			return temp.data;
		}
	}
	
	//Sets data at index i
	public void set(T data, int index) {
		if (index < 0 || index >= this.size) System.out.println("Out of bounds error");
		else {
			ListNode temp = head;
			for (int i = 0; i < index; i++) {
				temp = temp.link;
			}
			temp.data = data;
		}
	}
	
	//Removes element at index i
	public T removeAt(int index) {
		if (!(index < 0 || index >= this.size)) {
			ListNode temp = head;
			//Checks if removing head
			if (index == 0) {
				T returnData = head.data;
				if (current == head) current = current.link;
				head = head.link;
				return returnData;
			}
			for (int i = 0; i < index - 1; i++) temp = temp.link;
			T returnData = temp.link.data;
			if (current == temp.link) current = current.link;
			temp.link = temp.link.link;
			return returnData;
		} else {
			System.out.println("Out of bounds error");
			return null;
		}
	}
	
	//Removes current from list and returns it
	public T removeCurrent() {
		T temp = null;
		if (current == null);
		else if (current == head) {
			temp = current.data;
			head = head.link;
			current = head;
			size--;
		} else {
			temp = current.data;
			previous.link = current.link;
			current = current.link;
			size--;
		}
		return temp;
	}
	
	//Removes the first instance of a node containing data from list and returns index it was removed from
	public int remove(T data) {
		int index = this.indexOf(data);
		this.removeAt(index);
		return index;
	}
	
	//Removes all instances in list containing parameter data and returns GenLL containing indices of removals
	public GenLL<Integer> removeAll(T data) {
		GenLL<Integer> removals = new GenLL<Integer>();
		int i = 0;
		while (this.contains(data)) {
			removals.add(remove(data) + i);
			//Correction factor since indices are being changed 
			i++;
		}
		return removals;
	}
	
	//Returns whether any of the nodes contain parameter data
	public boolean contains(T data) {
		boolean contains = false;
		for (ListNode temp = head; temp != null; temp = temp.link) if (temp.data == data) contains = true;
		return contains;
	}
	
	//Returns index of first instance of element containing parameter data found
	public int indexOf(T data) {
		int i = 0;
		for (ListNode temp = head; temp.data != data; temp = temp.link) i++;
		return i;
	}
	
	//Returns indices of all instances of elements contains parameter data found
	public GenLL<Integer> indicesOf(T data) {
		GenLL<Integer> indices = new GenLL<Integer>();
		int i = 0;
		for (ListNode temp = head; temp != null; temp = temp.link) {
			if (temp.data == data) {
				indices.add(i);
			}
			i++;
		}
		return indices;
	}
	
	//Prints data on one line
	public void print() {
		System.out.println(this);
	}
	
	//Prints data on separate lines
	public void printlns() {
		for (ListNode temp = head; temp != null; temp = temp.link) System.out.println(temp.data);
	}
	
	//Prints size with identifier
	public void printSize() {
		System.out.println("Size: " + this.size);
	}
	
	//Prints data in current with identifier
	public void printCurrent() {
		System.out.println("Current: " + this.getCurrent());
	}
	
	//Checks whether each value is equal
	public boolean equals(GenLL<T> other) {
		boolean equals = true;
		if (this.head == null);
		else if (this.size == other.getSize()) {
			//Stores value of current so it get be reinstated
			int i = other.indexOf(other.getCurrent());
			ListNode temp1 = this.head;
			other.reset();
			T temp2 = other.getCurrent();
			while (temp1 != null) {
				if (!temp1.data.equals(temp2)) {
					equals = false;
				}
				temp1 = temp1.link;
				other.goToNext();
				temp2 = other.getCurrent();
			}
			//Resets current back to where it was
			other.reset();
			other.goToNext(i);
		} else equals = false;
		return equals;
	}
	
	//Returns String that is printed out in print()
	public String toString() {
		String str = "[";
		ListNode temp;
		for (temp = head; temp.link != null; temp = temp.link) str += temp.data + ", ";
		str += temp.data + "]";
		return str;
	}
}
