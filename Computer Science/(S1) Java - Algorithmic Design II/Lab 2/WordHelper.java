import java.util.Arrays;

/*
 * Written by Nathan Bickel
 */
public class WordHelper {
	
	//Initializes vowels and consonant Strings to input into helper method
	private static final String VOWELS = "aeiouy";
	private static final String CONSONANTS = "bcdfghjklmnpqrstvwxz";
	
	public static String[] sortByVowels(String[] words) {
		//Copies parameter array into array to be processed
		String[] processed = Arrays.copyOf(words, words.length);
		//Bubble sort
		boolean hasSwapped;
		do {
			hasSwapped = false;
			for (int i = 0; i < processed.length - 1; i++) {
				//Uses helper method to see if the first string has more vowels than the second and switches them if they do
				if (hasMoreVowelsOrConsonants(processed[i].toLowerCase(), processed[i+1].toLowerCase(), VOWELS)) {
					String temp = processed[i];
					processed[i] = processed[i+1];
					processed[i+1] = temp;
					hasSwapped = true;
				}
			}
		} while (hasSwapped);
		return processed;
	}
	
	//Other methods follow the same procedure
	public static String[] sortByConsonants(String[] words) {
		String[] processed = Arrays.copyOf(words, words.length);
		boolean hasSwapped;
		do {
			hasSwapped = false;
			for (int i = 0; i < processed.length - 1; i++) {
				if (hasMoreVowelsOrConsonants(processed[i].toLowerCase(), processed[i+1].toLowerCase(), CONSONANTS)) {
					String temp = processed[i];
					processed[i] = processed[i+1];
					processed[i+1] = temp;
					hasSwapped = true;
				}
			}
		} while (hasSwapped);
		return processed;
	}
	
	public static String[] sortByLength(String[] words) {
		String[] processed = Arrays.copyOf(words, words.length);
		boolean hasSwapped;
		do {
			hasSwapped = false;
			for (int i = 0; i < processed.length - 1; i++) {
				if (processed[i].length() > processed[i+1].length()) {
					String temp = processed[i];
					processed[i] = processed[i+1];
					processed[i+1] = temp;
					hasSwapped = true;
				}
			}
		} while (hasSwapped);
		return processed;
	}
	
	//Returns true if str1 has more vowels or consonants than str2
	private static boolean hasMoreVowelsOrConsonants(String str1, String str2, String vowelsOrConsonants) {
		int numVowels1 = 0;
		int numVowels2 = 0;
		for (int i = 0; i < str1.length(); i++) {
			if (vowelsOrConsonants.contains(str1.substring(i, i+1)))
				numVowels1++;
		}
		for (int i = 0; i < str2.length(); i++) {
			if (vowelsOrConsonants.contains(str2.substring(i, i+1)))
				numVowels2++;
		}
		return numVowels1 > numVowels2;
	}
	
}