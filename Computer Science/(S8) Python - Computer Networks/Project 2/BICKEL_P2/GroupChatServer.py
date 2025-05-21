# Import socket related methods
from socket import *

# Import argv related methods
from sys import *

# Import select method
from select import *

# Import thread API
import threading
from threading import Thread

import time

clients = []
print('Waiting for someone to join...')

class Client:
    global clients

    def __init__(self, input):
        self.sock, self.addr = input
        self.sockFile = self.sock.makefile()
        self.name = self.sockFile.readline().strip()
        print(f"*** {self.name} joined")
        self.receive_thread = Thread(target=receive_message, args=(self,))
        self.receive_thread.start()

    def closed(self) -> bool:
        return self.sock._closed

    def close(self):
        print(f"*** {self.name} left")

        for otherClient in clients:
            if not otherClient == self:
                otherClient.sock.send((f"*** {self.name} left\n").encode())

        self.sock.close()
        self.sockFile.close()

    def __eq__(self, other):
        return self.sock == other.sock and self.addr == other.addr

def monitor_clients(clients: list[Client]):
    while True:
        for c in clients:
            if c.closed():
                clients.remove(c)

        if len(clients) == 0:
            break

        time.sleep(0.5)


def receive_message(client):
    global clients
    try:
        while True:
            # Read a message from the client
            line = client.sockFile.readline()

            # If EOF ==> client closed the connection
            if not line:
                break

            message = f"{client.name}: {line.rstrip()}\n"
            print(message.strip())

            for otherClient in clients:
                if not otherClient == client:
                    otherClient.sock.send(message.encode())

    finally:
        client.close()

# Server needs the port number to listen on
if len(argv) != 2:
    print('usage:', argv[0], '<port>')
    exit()

# Get the port on which server should listen */
serverPort = int(argv[1])

# Create the server socket
welcomeServerSock = socket(AF_INET, SOCK_STREAM)

# Bind the socket to the given port
welcomeServerSock.bind(('', serverPort))

# Set the server for listening */
welcomeServerSock.listen()

new_client = Client(welcomeServerSock.accept())
clients.append(new_client)

welcomeServerSock.settimeout(1.0)

monitor_thread = Thread(target=monitor_clients, args=(clients,))
monitor_thread.daemon = True
monitor_thread.start()

while len(clients) > 0:
    try:
        new_client = Client(welcomeServerSock.accept())
        clients.append(new_client)

    except timeout:
        if len(clients) == 0:
            print("*** No one remaining. Closing chat room.")
            break

monitor_thread.join()

welcomeServerSock.close()
