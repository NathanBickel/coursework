/*
 * Written by Nathan Bickel
 */
public class Queue<T> {
	
	private class ListNode {
		
		private T data;
		private ListNode link;
		
		public ListNode(T data, ListNode link) {
			this.data = data;
			this.link = link;
		}
		
	}
	
	private ListNode head;
	private ListNode tail;
	
	public void enqueue(T data) {
		ListNode newNode = new ListNode(data, null);
		if (head == null) 
			head = tail = newNode;
		else {
			tail.link = newNode;
			tail = tail.link;
		}
	}
	
	public T dequeue() {
		if (head == null) 
			return null;
		else {
			T ret = head.data;
			head = head.link;
			return ret;
		}
	}
	
	public T peek() {
		if (head == null) 
			return null;
		else return head.data;
	}
	
	public void print() {
		for (ListNode temp = head; temp != null; temp = temp.link) 
			System.out.println(temp.data);
	}
}
