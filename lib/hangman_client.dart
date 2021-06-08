import 'dart:io';
import 'dart:typed_data';


  Socket mSocket;

  void tcpSend(Function(Uint8List) dataHandler, Function errorHandler, String data){
  Socket.connect("iotsoftworks.com", 5050).then((Socket sock) {
    //Connect standard in to the socket 
   mSocket = sock;
   
   sock.write(data);
   
   sock.listen(dataHandler, 
      onError: errorHandler, 
      onDone: doneHandler, 
      cancelOnError: false);
   }).catchError((Object e) {
      print("Unable to connect: $e"); 
   });
  }  
  
  void doneHandler(){
    mSocket.destroy();   
  } 



