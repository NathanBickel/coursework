//Written by Nathan Bickel
public class LLStack<T> implements StackI<T> {
	
	private class ListNode {
		
		private T data;
		private ListNode link;
		
		public ListNode(T data, ListNode link) {
			this.data = data;
			this.link = link;
		}
		
	}
	
	private ListNode head;
	private int size;
	
	public void push(T data) {
		ListNode newNode = new ListNode(data, head);
		head = newNode;
		size++;
	}
	
	public T pop() {
		if (head != null) {
			T ret = head.data;
			head = head.link;
			size--;
			return ret;
			
		} else 
			return null;
	}
	
	public T peek() {
		if (head != null)
			return head.data;
		else
			return null;
	}
	
	public void print() {
		for (ListNode temp = head; temp != null; temp = temp.link)
			System.out.println(temp.data);
	}
	
	public int size() {
		return size;
	}
	
}
