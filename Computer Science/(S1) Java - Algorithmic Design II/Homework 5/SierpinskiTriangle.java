//Written by Nathan Bickel
import java.awt.*;
import javax.swing.*;
import java.util.*;

public class SierpinskiTriangle extends Canvas {
	//Approximation of root 3: can be changed, used to create triangles that are nearly equilateral (since the height is the side length * sqrt(3) / 2) 
	public static final double RT3A = Math.sqrt(3);
	public static final double DEPTH = 20;
	
	//Creates GUI
	public static void main(String[] args) {
		JFrame frame = new JFrame("Sierpinski's 1.585-Dimensional Triangle");
		frame.setSize(900,900);
		SierpinskiTriangle triangle = new SierpinskiTriangle();
		frame.add(triangle);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	//Calls the inherited method that creates the canvas
	public void paint(Graphics graphics) {
		double size = this.getSize().height;
		drawTriangle(0,(int)(size/2*RT3A),size,graphics);
	}
	
	public void drawTriangle(int xStart, int yStart, double size, Graphics graphics) {
		//Creates a black equilateral triangle with bottom left point at (xStart, yStart) with side length size
		graphics.setColor(Color.BLACK);
		int[] xCoordsO = {xStart,(int)(xStart+size/2),(int)(xStart+size)};
		int[] yCoordsO = {yStart,(int)(yStart-size*RT3A/2),yStart};
		graphics.fillPolygon(xCoordsO,yCoordsO,3);
		//Creates a white equilateral triangle with points at the midpoint of each line in the black equilateral triangle
		graphics.setColor(Color.WHITE);
		int[] xCoordsI = {(int)(xStart + size/4), (int)(xStart + size/2), (int)(xStart + 3*size/4)};
		int[] yCoordsI = {(int)(yStart - size*RT3A/4), yStart, (int)(yStart - size*RT3A/4)};
		graphics.fillPolygon(xCoordsI, yCoordsI, 3);
		//Recursively calls method until size is greater than or equal to DEPTH, at which point the it is too small to continue making meaningful triangles
		if (size >= DEPTH) {
			drawTriangle(xStart, yStart, size/2, graphics);
			drawTriangle((int)(xStart + size/2), yStart, size/2, graphics);
			drawTriangle((int)(xStart + size/4), (int)(yStart - size*RT3A/4), size/2, graphics);
		}
	}
	
}