//Written by Nathan Bickel
public class ReversePolishCalculator {
	
	private StackI<Integer> values;
	public static final String VALID_OPERATORS = "[\\+\\-\\*\\/]";
	public static final String DELIMITERS = "[\s\t\n]+";
	
	public int calculate(String input) {
		//Constructs values stack
		values = new LLStack<Integer>();
		//Splits array at one or more instances of tabs, new lines, or spaces
		String[] parts = input.split(DELIMITERS);
		for (int i = 0; i < parts.length; i++) {
			if (isInteger(parts[i])) {
				values.push(Integer.parseInt(parts[i]));
			} else if (isOperator(parts[i])) {
				//Makes sure there are enough operands
				if (values.size() >= 2) {
					int value2 = values.pop();
					int value1 = values.pop();
					String operator = parts[i];
					//Makes sure something isn't being divided by 0
					if (value2 == 0 && operator.equals("/")) {
						System.out.println("Cannot divide by 0");
						return 0;
					} else {
						//Should only get here if everything's gone perfectly: calculates result given two operands and an operator and pushes it onto the stack
						values.push(calculateGivenInputs(value1, value2, operator));
					}
				} else {
					System.out.println("This wasn't formatted correctly. There were too many operators and not enough numbers");
					return 0;
				}
			//Makes sure the string is either an integer or a valid operator
			} else {
				System.out.println("Not a valid operator");
				return 0;
			}
		}
		//Makes sure there's only one integer left on the stack
		if (values.size() == 1) {
			return values.pop();
		} else {
			System.out.println("This was not properly formatted. There were too many numbers and not enough operators");
			return 0;
		}
	}
	
	//Helper method to determine whether a string is an integer
	private boolean isInteger(String input) {
		try {
			Integer.parseInt(input);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	//Helper method to determine whether a string is a valid operator
	private boolean isOperator(String input) {
		//Checks if the String contains '+', '-', '*', or '/'
		return input.matches(VALID_OPERATORS);
	}
	
	//Helper method to calculate (should only be used after edge cases are checked)
	private int calculateGivenInputs(int value1, int value2, String operator) {
		switch(operator) {
		case "+":
			return value1 + value2;
		case "-":
			return value1 - value2;
		case "*":
			return value1 * value2;
		case "/":
			return value1 / value2;
		}
		return 0;
	}
	
}
