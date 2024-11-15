import netP5.*;
import oscP5.*;

OscP5 oscP5;
NetAddress route;


color bgColor;
color targetBgColor;  
int lastChangeTime;   
float transitionSpeed = 0.02;
float changeColor;

private static final float IDEAL_FRAME_RATE = 60.0;
private static final int INTERNAL_CANVAS_SIDE_LENGTH = 640;

KeyInput currentKeyInput;
GameSystem system;
PFont smallFont, largeFont;
boolean paused;
Song song_1, song_2;

Table table;

int canvasSideLength = INTERNAL_CANVAS_SIDE_LENGTH;
float scaleFactor;

void settings() {
  size(canvasSideLength, canvasSideLength);
}


void setup() {
  
  size(canvasSideLength, canvasSideLength);

  scaleFactor = (float)canvasSideLength / (float)INTERNAL_CANVAS_SIDE_LENGTH;

  frameRate(IDEAL_FRAME_RATE);

  // Prepare font
  final String fontFilePath = "Lato-Regular.ttf";
  smallFont = createFont(fontFilePath, 20.0, true);
  largeFont = createFont(fontFilePath, 96.0, true);
  textFont(largeFont, 96.0);
  textAlign(CENTER, CENTER);

  rectMode(CENTER);
  ellipseMode(CENTER);

  currentKeyInput = new KeyInput();
  table = loadTable("spotify-2023.csv", "header");
  oscP5 = new OscP5(this, 9001);
  route = new NetAddress("localhost", 9000);
  changeColor = 30000;
  bgColor = color(128, 0, 255);        
  targetBgColor = color(128, 0, 255);  
  lastChangeTime = millis();           
  newGame(true); 
}

void draw() {
  if (millis() - lastChangeTime >= changeColor) {  
    targetBgColor = color(random(255), random(255), random(255)); 
    lastChangeTime = millis();  
  }

  
  bgColor = lerpColor(bgColor, targetBgColor, transitionSpeed);
  
  background(bgColor);  
  scale(scaleFactor);
  system.run();
}

void exit() {
  modifyWaves(0,0,0);
  send_message("/turnWaves",turnWaves);
  super.exit();
}


void newGame(boolean instruction) {
  modifyWaves(0,0,0);
  system = new GameSystem(instruction);
}


void mousePressed() {
  system.showInstructionWindow = !system.showInstructionWindow;
}
