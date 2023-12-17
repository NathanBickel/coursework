/*
 * Written by Nathan Bickel
 */
public class ProcessScheduler {
	
	private QueueI<Process> processQueue;
	private Process currentProcess;
	
	public ProcessScheduler() {
		processQueue = new LLQueue<Process>();
		currentProcess = null;
	}
	
	//Gets current process unless there isn't one, in which case it sets the current process to the first process in the queue
	public Process getCurrentProcess() {
		if (currentProcess == null || currentProcess.getCompletionTime() < 0.0) currentProcess = processQueue.dequeue();
		return currentProcess;
	}
	
	public void addProcess(Process process) {
		processQueue.enqueue(process);
	}
	
	public void runNextProcess() {
		currentProcess = processQueue.dequeue();
	}
	
	public void cancelCurrentProcess() {
		currentProcess = processQueue.dequeue();
	}
	
	public void printProcessQueue() {
		processQueue.print();
	}
}
