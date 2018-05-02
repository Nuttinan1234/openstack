import socket
import sys
def Main():
    host = str(sys.argv[1])
    port = 9898
    mySocket = socket.socket()
    mySocket.bind((host,port))
    mySocket.listen(1)
    conn, addr = mySocket.accept()
    while True:
            data = conn.recv(1024).decode()
            if data == '1':
              break
            respon = '1'
            conn.send(respon.encode())
    print('Success')
    conn.close()
if __name__ == '__main__':
    Main()
