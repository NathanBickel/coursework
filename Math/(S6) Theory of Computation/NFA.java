// Author: Nathan Bickel

import java.util.*;
import java.io.*;
import java.util.stream.Collectors;

public class NFA {

    public final static int DEFAULT_START_STATE = 0;
    public final static char EPISLON = '\u03B5';
    public static Scanner fileReader;

    private Set<Integer> stateSet;
    private Set<Character> alphabet;
    private Set<Integer>[][] transitionFunction; // len(stateSet)xlen(alphabet)
    private int startState;
    private ArrayList<Integer> acceptingStates;

    public NFA(String fileName) {
        try {
            fileReader = new Scanner(new File(fileName));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        setStateSet(fileReader.nextLine().split(": ")[1]);
        setAlphabet(fileReader.nextLine().split(": ")[1]);
        setStartState(DEFAULT_START_STATE);
        String[] aStatesLoc = fileReader.nextLine().split(": ");
        setAcceptingStates(aStatesLoc.length == 2 ? aStatesLoc[1] : null); 
        String[] tableRepresentation = new String[stateSet.size()];
        for (int i = 0; i < stateSet.size(); i++)
            tableRepresentation[i] = fileReader.nextLine();
        setTransitionFunction(tableRepresentation);
    }

    public String toString() {
        String ret = "";
        ret += "Number of states: " + this.stateSet.size() + "\n";
        ret += "Alphabet size: " + this.alphabet.size() + "\n";
        ret += "Accepting states: ";
        for (int i = 0; i < this.acceptingStates.size(); i++)
            ret += this.acceptingStates.get(i)
                + (i == this.acceptingStates.size() - 1 ? "" : " ");
        ret += "\n";
        for (int r = 0; r < this.stateSet.size(); r++) {
            for (int c = 0; c <= this.alphabet.size(); c++) {
                Set<Integer> set = this.transitionFunction[r][c];
                ret += (set.isEmpty() ? "{}" 
                    : "{" + set.stream().sorted().map(Object::toString)
                            .collect(Collectors.joining(",")) + "}")
                    + (c == this.alphabet.size() ? "" : "\t");
            }
            ret += (r == this.stateSet.size() - 1 ? "" : "\n");
        }
        return ret;
    }

    public Set<Integer> transitionOn(int state, char symbol) {
        return this.transitionFunction[state][symbolToIndex(symbol)];
    }

    public boolean addTransition(int stateFrom, char symbol, int stateTo) {
        if (transitionOn(stateFrom, symbol).contains(stateTo))
            return false;
        else {
            transitionOn(stateFrom, symbol).add(stateTo);
            return true;
        }
    }

    public boolean removeTransition(int stateFrom, char symbol, int stateTo) {
        return transitionOn(stateFrom, symbol).remove(stateTo);
    }

    public boolean addAcceptingState(int state) {
        if (this.acceptingStates.contains(state))
            return false;
        else {
            this.acceptingStates.add(state);
            Collections.sort(this.acceptingStates);
            return true;
        }
    }

    public boolean removeAcceptingState(int state) {
        int indexToRemove = this.acceptingStates.indexOf(state);
        if (indexToRemove == -1)
            return false;
        else {
            this.acceptingStates.remove(indexToRemove);
            return true;
        }
    }

    public boolean accepts(int state) {
        return this.acceptingStates.contains(state);
    }

    public Set<Integer> getStateSet() {
        return this.stateSet;
    }
    
    public Set<Character> getAlphabet() {
        return this.alphabet;
    }

    public int getStartState() {
        return this.startState;
    }

    public ArrayList<Integer> getAcceptingStates() {
        return this.acceptingStates;
    }

    // Sets `stateSet` to {0, 1, 2, ..., `numberOfStates - 1`}
    private void setStateSet(String numberOfStates) {
        this.stateSet = new HashSet<Integer>();
        for (int i = 0; i < Integer.parseInt(numberOfStates); i++)
            this.stateSet.add(i);
    }

    // Sets `alphabet` to the first `alphabetSize` English letters
    private void setAlphabet(String alphabetSize) {
        this.alphabet = new HashSet<Character>();
        for (int i = 1; i <= Integer.parseInt(alphabetSize); i++)
            this.alphabet.add(NFA.indexToSymbol(i));
    }

    // Sets `transition` appropriately, indexing rows by states and columns
    // by the encoding of symbols, where epsilon-transitions are in column 0
    @SuppressWarnings("unchecked")
    private void setTransitionFunction(String[] tableRepresentation) {
        this.transitionFunction 
            = new HashSet[this.stateSet.size()][this.alphabet.size() + 1];
        for (int r = 0; r < this.stateSet.size(); r++) {
            String[] splitToLists = tableRepresentation[r].split("\\}\\s*\\{");
            String[] beginning = splitToLists[0].split("\\{");
            String[] end = splitToLists[splitToLists.length - 1].split("\\}");
            splitToLists[0] = beginning.length == 0 ? "" : beginning[beginning.length - 1];
            splitToLists[splitToLists.length - 1] = end.length == 0 ? "" : end[0];
            for (int c = 0; c <= this.alphabet.size(); c++) {
                Set<Integer> setOfStates = new HashSet<Integer>();
                for (String state : splitToLists[c].split(",")) {
                    try {
                        setOfStates.add(Integer.parseInt(state));
                    } catch (NumberFormatException e) {
                        continue;
                    }
                }
                this.transitionFunction[r][c] = setOfStates;
            }
        }
    }

    private void setStartState(int startState) {
        this.startState = startState;
    }

    // Sets `acceptingStates` to the whitespace-separated states in the param
    private void setAcceptingStates(String acceptingStatesList) {
        this.acceptingStates = new ArrayList<Integer>();
        if (acceptingStatesList == null)
            return;
        for (String state : acceptingStatesList.split("\\s"))
            this.acceptingStates.add(Integer.parseInt(state));
        Collections.sort(this.acceptingStates);
    }

    // `index` must be between 0 and 26, inclusive. Returns 'ε' for 0, 
    // 'a' for 1, 'b' for 2, ..., 'z' for 26
    private static char indexToSymbol(int index) {
        if (1 <= index && index <= 26)
            return (char)(index + 96);
        else
            return EPISLON;
    }

    // `symbol` must be in the canonical alphabet
    private static int symbolToIndex(char symbol) {
        if (symbol == EPISLON)
            return 0;
        else;
            return (int)symbol - 96;
    }
}
