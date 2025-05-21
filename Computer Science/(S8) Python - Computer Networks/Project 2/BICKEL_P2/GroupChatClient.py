# Implementation of the two-way async message client in python

# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

# Import select method
from select import *

# Import thread API
import threading
from threading import Thread

# Client needs server's contact information
if len(argv) != 3:
    print("usage:", argv[0], "<server name> <server port>")
    exit()

# Get server's whereabouts
serverName = argv[1]
serverPort = int(argv[2])

# Create a socket
sock = socket(AF_INET, SOCK_STREAM)

# Connect to the server
sock.connect((serverName, serverPort))
print(f"Connected to server at ('{serverName}', '{serverPort}')")

# Make a file stream out of socket
sockFile = sock.makefile(mode='r')

def send_message(sock, sockFile):
	try:
		while True:
			# Read a line form the keyboard
			line = stdin.readline()
			
			# If EOF ==> client wants to close connection
			if not line:
				sock.shutdown(SHUT_WR)
				break
			
			# Send the line to client
			sock.send(line.encode())
		
	finally:
		# Close the connection
		print('Leaving chat room')
		

def receive_message(sock, sockFile):
	try:
		while True:
			# Read a message from the client
			line = sockFile.readline()
			
			# If EOF ==> client closed the connection
			if not line:
				break
			    
			# Display the line
			print(line.strip())

	finally:
		sockFile.close()
		sock.close()
		
sock.send((input("Name: ") + "\n").encode())

Thread(target=send_message, args=(sock, sockFile, )).start()  
Thread(target=receive_message, args=(sock, sockFile,)).start()

