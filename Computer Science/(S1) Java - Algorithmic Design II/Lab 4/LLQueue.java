/*
 * Written by Nathan Bickel
 */
public class LLQueue<T> implements QueueI<T> {
	
	//Internal ListNode class to store data in nodes
	private class ListNode {
		
		private T data;
		private ListNode link;
		
		public ListNode(T data, ListNode link) {
			this.data = data;
			this.link = link;
		}
		
	}
	
	//Implements Queue functionality
	private ListNode head;
	private ListNode tail;
	
	//Default constructor used so not written
	
	public void enqueue(T data) {
		ListNode newNode = new ListNode(data, null);
		if (head != null) {
			tail.link = newNode;
			tail = tail.link;
		} else head = tail = newNode;
	}
	
	public T dequeue() {
		T ret = null;
		if (head != null) {
			ret = head.data;
			head = head.link;
		}
		return ret;
	}
	
	public T peek() {
		if (head == null) return null;
		else return head.data;
	}
	
	public void print() {
		for (ListNode temp = head; temp != null; temp = temp.link) System.out.println(temp.data);
	}
}
