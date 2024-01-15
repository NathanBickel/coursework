//Written by Nathan Bickel
public interface StackI<T> {
	public void push(T data);
	public T pop();
	public T peek();
	public void print();
	public int size();
}
