String[] pathWavesFrec = {"/sin", "/square", "/saw"};
String[] pathWavesVol = {"/vSin", "/vSquare", "/vSaw"};
String[] pathWaves = {"/tSin", "/tSquare", "/tSaw"};

void send_float(String path, float data){
   OscMessage msg = new OscMessage(path);
   msg.add(data);
   oscP5.send(msg, route);
}

void send_int(String path, int data){
  OscMessage msg = new OscMessage(path);
   msg.add(data);
   oscP5.send(msg, route);
}

void send_message(String path, int data[]){
  OscMessage msg = new OscMessage(path);
  for(int i = 0; i<data.length;i++){
    msg.add(data[i]);
  }
  oscP5.send(msg, route);
}

void modifyWaves(int a, int b, int c) {
  turnWaves[0] = a;  
  turnWaves[1] = b; 
  turnWaves[2] = c;  
}
