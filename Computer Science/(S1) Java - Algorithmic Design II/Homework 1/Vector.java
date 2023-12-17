/*
 * Written by Nathan Bickel
 */
public class Vector {
	
	/* Instance variables:
	 * numDimensions: Non-negative integer representing how many dimensions the vector has
	 * coordinates: Double array with length numDimensions representing each coordinate of the vector
	 */
	private double[] coordinates;
	private int numDimensions;
	
	//Constructor
	public Vector(double[] coordinates) {
		this.setCoordinates(coordinates);
		numDimensions = this.coordinates.length;
	}
	
	//Takes an array of vectors and adds them all together
	public static Vector addVectors(Vector[] vectors) {
		//Checks that every vector has the same number of dimensions
		int numDimensions = vectors[0].getNumDimensions();
		for (int i = 1; i < vectors.length; i++) {
			if (vectors[0].getNumDimensions() != vectors[i].getNumDimensions()) {
				System.out.println("Every vector must be the same number of dimensions, aborting");
				//If not, dimensionless vector is returned
				double[] coordinates = {};
				return new Vector(coordinates);
			}
		}
		double[] coordinates = new double[numDimensions];
		for (int v = 0; v < vectors.length; v++) {
			for (int c = 0; c < numDimensions; c++) {
				coordinates[c] += vectors[v].getCoordinates()[c];
			}
		}
		return new Vector (coordinates);
	}
	
	//Uses Pythagorean theorem to find magnitude of vector
	public double getMagnitude() {
		double sumOfSquares = 0;
		for (int i = 0; i < numDimensions; i++) {
			sumOfSquares += Math.pow(coordinates[i], 2);
		}
		return Math.sqrt(sumOfSquares);
	}
	
	//Multiplies every vector by a negative (used for subtraction)
	public void negate() {
		for (int i = 0; i < this.numDimensions; i++) {
			coordinates[i] = coordinates[i] * -1;
		}
	}
	
	
	
	public int getNumDimensions() {
		return this.numDimensions;
	}
	
	public double[] getCoordinates() {
		return this.coordinates;
	}
	
	public void setCoordinates(double[] coordinates) {
			this.coordinates = coordinates;
	}
	
	public void setCoordinate(double coordinate, int dimension) {
		if (dimension > 0 && dimension < this.coordinates.length)
			this.coordinates[dimension] = coordinate;
	}
	
	public boolean equals(Vector other) {
		if (this.getNumDimensions() != other.getNumDimensions() || other == null) {
			return false;
		} else {
			for (int i = 0; i < this.coordinates.length; i++) {
				if (this.coordinates[i] != other.getCoordinates()[i])
					return false;
			}
		}
		return true;
	}
	
	public String toString() {
		if (this.numDimensions == 0) {
			return "vector with 0 dimensions: <0>";
		} else if (this.numDimensions == 1) {
			return "vector with 1 dimension: <" + this.coordinates[0] + ">";
		} else {
			String result = "vector with " + this.numDimensions + " dimensions: <";
			for (int i = 0; i < this.coordinates.length - 1; i++) {
				result += this.coordinates[i] + ", ";
			}
			result += this.coordinates[this.coordinates.length - 1] + ">";
			return result;
		}
	}
}
