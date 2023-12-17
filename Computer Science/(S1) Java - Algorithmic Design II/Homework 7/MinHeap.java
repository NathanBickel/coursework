//Written by Nathan Bickel
public class MinHeap <T extends Comparable<T>> {
	
	private T[] heap;
	private int lastIndex;
	public static final int DEF_SIZE = 128;
	
	public MinHeap(int size) {
		if (size > 0)
			heap = (T[])(new Comparable[size]);
		else
			heap = (T[])(new Comparable[DEF_SIZE]);
	}
	
	public void add(T data) {
		if (lastIndex < heap.length) {
			heap[lastIndex] = data;
			bubbleUp();
			lastIndex++;
		} else
			System.out.println("Heap full");
	}
	
	public T remove() {
		if (lastIndex > 0) {
			T ret = heap[0];
			heap[0] = heap[lastIndex-1];
			heap[lastIndex-1] = null;
			lastIndex--;
			bubbleDown();
			return ret;
		} else {
			System.out.println("Heap is empty");
			return null;
		}	
	}
	
	public boolean isEmpty() {
		return lastIndex == 0;
	}
	
	private void bubbleUp() {
		int index = lastIndex;
		while (index > 0 && heap[(index-1)/2].compareTo(heap[index]) > 0) {
			T temp = heap[(index-1)/2];
			heap[(index-1)/2] = heap[index];
			heap[index] = temp;
			index = (index-1)/2;
		}
	}
	
	private void bubbleDown() {
		int index = 0;
		while (index*2+1 < lastIndex) {
			int smallIndex = index*2+1;
			if (index*2+2 < lastIndex && heap[index*2+1].compareTo(heap[index*2+2]) > 0)
				smallIndex = index*2+2;
			if (heap[index].compareTo(heap[smallIndex]) > 0) {
				T temp = heap[index];
				heap[index] = heap[smallIndex];
				heap[smallIndex] = temp;
			} else
				break;
			index = smallIndex;
		}
	}
	
}
