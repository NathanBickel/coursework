/*
 * Written by Nathan Bickel
 */
public interface QueueI<T> {
	//These methods are needed for any queue
	public void enqueue(T data);
	public T dequeue();
	public T peek();
	public void print();
}
