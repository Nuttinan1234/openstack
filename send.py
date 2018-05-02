import socket
import sys
def Main():
        host = str(sys.argv[1])
        port = 9898
        mySocket = socket.socket()
        mySocket.connect((host,port))
        message = str(sys.argv[2])
        for i in range(0,2):
                mySocket.send(message.encode())
                data = mySocket.recv(1024).decode()
                message = str(sys.argv[3])
        mySocket.close()
if __name__ == '__main__':
    Main()

