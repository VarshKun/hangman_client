import 'dart:io';
import 'dart:typed_data';

Socket mSocket;

void tcpSend(
    Function(Uint8List) dataHandler, Function errorHandler, String data) {
  Socket.connect("iotsoftworks.com", 5050).then((Socket sock) {
    //Connect standard in to the socket
    mSocket = sock;

    sock.write(data);

    sock.listen(dataHandler,
        onError: errorHandler, onDone: doneHandler, cancelOnError: false);
  }).catchError((Object e) {
    print("Unable to connect: $e");
  });
}

Future<String> tcpSendV2(Function errorHandler, String data) async {
  Socket _socket;
  String returnData;
  await Socket.connect("iotsoftworks.com", 5050).then((Socket sock) {
    _socket = sock;
  }).then((_) {
    _socket.write(data);
    return _socket.first;
  }).then((data) {
    returnData = new String.fromCharCodes(data).trim();
  }).catchError((Object e) {
    print("Unable to connect: $e");
    errorHandler();
  });
  return returnData;
}

void doneHandler() {
  mSocket.destroy();
}
