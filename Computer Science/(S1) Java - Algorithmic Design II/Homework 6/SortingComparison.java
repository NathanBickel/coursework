//Written by Nathan Bickel
import java.util.Arrays;

public class SortingComparison {

	public static final int MIN_VALUE = 0;
	public static final int MAX_VALUE = 999;
	public static final int ARRAY_SIZE = 1000;
	public static final int NUM_TESTS = 20;
	public static int[] VALUES = new int[ARRAY_SIZE];
	//All counters are declared as static so they can be accessed/changed by all methods and are initialized as 0
	public static int countSelectionSort = 0;
	public static int countBubbleSort = 0;
	public static int countMergeSort = 0;
	public static int countQuickSort = 0;
	
	public static void main(String[] args) {
		for (int i = 0; i < NUM_TESTS; i++) {
			for (int j = 0; j < ARRAY_SIZE; j++)
				VALUES[j] = MIN_VALUE + (int)(Math.random() * MAX_VALUE);
			selectionSort(Arrays.copyOf(VALUES, ARRAY_SIZE));
			bubbleSort(Arrays.copyOf(VALUES, ARRAY_SIZE));
			mergeSort(Arrays.copyOf(VALUES, ARRAY_SIZE));
			quickSort(Arrays.copyOf(VALUES, ARRAY_SIZE));
		}
		System.out.println("Selection: " + countSelectionSort / NUM_TESTS);
		System.out.println("Bubble: " + countBubbleSort / NUM_TESTS);
		System.out.println("Merge: " + countMergeSort / NUM_TESTS);
		System.out.println("Quick: " + countQuickSort / NUM_TESTS);
	}
	
	public static void selectionSort(int[] arr) {
		for (int i = 0; i < arr.length - 1; i++) {
			int min = i;
			for (int j = i + 1; j < arr.length; j++) {
				countSelectionSort++;
				if (arr[min] > arr[j]) {
					min = j;
				}
			}
			if (min == i)
				//No need to swap the values if they're equal
				continue;
			else {
				//Swaps by pointing temp to the first value to avoid GC, one pointer to the second value, and the other pointer to temp
				int temp = arr[i];
				arr[i] = arr[min];
				arr[min] = temp;
			}
		}
	}
	
	public static void bubbleSort(int[] arr) {
		boolean swapsMade = true;
		//Keeps going until the list is iterated through with no swaps being made, which means it's sorted
		while (swapsMade) {
			//Assume no swaps will be made until some are
			swapsMade = false;
			for (int i = 0; i < arr.length - 1; i++) {
				countBubbleSort++;
				if (arr[i] > arr[i+1]) {
					int temp = arr[i+1];
					arr[i+1] = arr[i];
					arr[i] = temp;
					swapsMade = true;
				}
			}	
		}
	}
	
	public static void mergeSort(int[] arr) {
		int size = arr.length;
		//If size isn't this, it's just one element and thus is already "sorted"
		if (size >= 2) {
			int mid = size / 2;
			int leftSize = mid;
			int rightSize = size - mid;
			int[] left = new int[leftSize];
			int[] right = new int[rightSize];
			for (int i = 0; i < mid; i++)
				left[i] = arr[i];
			for (int i = mid; i < size; i++)
				right[i-mid] = arr[i];
			mergeSort(left);
			mergeSort(right);
			merge(left, right, arr);
		}
	}
	
	public static void merge(int[] left, int[] right, int[] arr) {
		int leftSize = left.length;
		int rightSize = right.length;
		int i = 0;
		int j = 0;
		int k = 0;
		while (i < leftSize && j < rightSize) {
			countMergeSort++;
			if (left[i] <= right[j]) {
				arr[k] = left[i];
				i++;
				k++;
			} else {
				arr[k] = right[j];
				j++;
				k++;
			}
		}
		while (i < leftSize) {
			countMergeSort++;
			arr[k] = left[i];
			i++;
			k++;
		}
		while (j < rightSize) {
			countMergeSort++;
			arr[k] = right[j];
			j++;
			k++;
		}
	}
	
	public static void quickSort(int[] arr) {
		quickSort(arr, 0, arr.length - 1);
	}
	
	public static void quickSort(int[] arr, int start, int end) {
		if (start < end) {
			int pivot = partition(arr, start, end);
			quickSort(arr, start, pivot - 1);
			quickSort(arr, pivot + 1, end);
		}
	}
	
	public static int partition(int[] arr, int start, int end) {
		int pivot = arr[end];
		int i = start;
		for (int j = start; j <= end; j++) {
			countQuickSort++;
			if (arr[j] > pivot) {
				int temp = arr[i];
				arr[i] = arr[j];
				arr[j] = temp;
				i++;
			}
		}
		int temp = arr[i];
		arr[i] = arr[end];
		arr[end] = temp;
		return i;
	}

}
