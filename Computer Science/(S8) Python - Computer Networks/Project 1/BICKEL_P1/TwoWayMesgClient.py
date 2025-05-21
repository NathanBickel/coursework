# Implementation of the two way message client in python

# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

# Client needs server's contact information
if len(argv) != 4:
    print("usage:", argv[0], "<server name> <port number> <client name>")
    exit()

# Get server's whereabouts
serverName = argv[1]
serverPort = int(argv[2])
clientName = argv[3]

# Create a socket
sock = socket(AF_INET, SOCK_STREAM)

# Connect to the server
sock.connect((serverName, serverPort))
print(f"Connected to server at ('{serverName}', '{serverPort}')")

# Make a file stream out of socket
sockFile = sock.makefile(mode='r')

# Keep conversing
while True:
    try:
        # Send message to server
        sock.send((clientName + ": " + input() + "\n").encode())

        # Read response from server
        response = sockFile.readline()

        # If no response ==> server closed the connection
        if not response:
            print('Server closed connection')
            sockFile.close()
            break

        # Display the line
        print(response)

    except:
        print("Closing connection")
        break

sock.close()