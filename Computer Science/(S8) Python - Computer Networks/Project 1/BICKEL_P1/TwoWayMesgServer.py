# Implementation of a two way message server in python

# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

# Server needs the port number to listen on
if len(argv) != 3:
    print('usage:', argv[0], '<port> <server name>')
    exit()

# Get the port on which server should listen */
serverPort = int(argv[1])
serverName = argv[2]

# Create the server socket
serverSock = socket(AF_INET, SOCK_STREAM)

# Bind the socket to the given port
serverSock.bind(('', serverPort))

# Set the server for listening */
serverSock.listen()

# Wait to receive a connection request
print('Waiting for a client ...')
clientSock, clientAddr = serverSock.accept()
print('Connected to a client at', clientAddr)

# Make a file stream out of client socket
clientSockFile = clientSock.makefile(mode='r')

# Keep serving the client
while True:
    # Read a message from the client
    message = clientSockFile.readline().strip()

    # If no message ==> client closed the connection
    if not message:
        print('Client closed connection')
        clientSockFile.close()
        clientSock.close()
        break

    # Display the line
    print(message)

    response = input()

    # Send response to client
    clientSock.sendall((serverName + ": " + response + "\n").encode())