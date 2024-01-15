/*
 * Written by Nathan Bickel
 */
public class VideoGame {
		
	private String title;
	private String console;
		
	public VideoGame(String title, String console) {
		this.title = title;
		this.console = console;
	}
		
	public String getTitle() {
		return this.title;
	}
		
	public void setTitle(String title) {
		this.title = title;
	}
		
	public String getConsole() {
		return this.console;
	}
		
	public void setConsole(String console) {
		this.console = console;
	}
		
	public boolean equals(VideoGame other) {
		return this.title.equals(other.getTitle()) && this.console.equals(other.getConsole());
	}
		
	public String toString() {
		return (this.title + VideoGameDatabaseUI.DELIM + this.console);
	}
		
}