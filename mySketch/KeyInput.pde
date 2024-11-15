void keyPressed() {
  if (key != CODED) {
    switch(key){
      case 'z':
      case 'Z':
        currentKeyInput.zPressed = true;
        return;
      case 'w':
      case 'W':
        currentKeyInput.player1_UpPressed = true;
        return;
      case 's':
      case 'S':
        currentKeyInput.player1_DownPressed = true;
        return;
      case 'a':
      case 'A':
        currentKeyInput.player1_LeftPressed = true;
        return;
      case 'd':
      case 'D':
        currentKeyInput.player1_RightPressed = true;
        return; 
      case 'c':
      case 'C':
        currentKeyInput.player1_ActionPressed = true;
        return; 
      case 'v':
      case 'V':
        currentKeyInput.player1_SecondaryPressed = true;
        return;    
      case 'k':
      case 'K':
        currentKeyInput.player2_ActionPressed = true;
        return; 
      case 'l':
      case 'L':
        currentKeyInput.player2_SecondaryPressed = true;
        return; 
      case 'p':
      case 'P':
        if(paused) loop();
        else noLoop();
        paused = !paused;
        return;
      }
  }
  switch(keyCode) {
  case UP:
    currentKeyInput.player2_UpPressed = true;
    return;
  case DOWN:
    currentKeyInput.player2_DownPressed = true;
    return;
  case LEFT:
    currentKeyInput.player2_LeftPressed = true;
    return;
  case RIGHT:
    currentKeyInput.player2_RightPressed = true;
    return;
  }
}

void keyReleased() {
if (key != CODED) {
    switch(key){
      case 'z':
      case 'Z':
        currentKeyInput.zPressed = false;
        return;
      case 'w':
      case 'W':
        currentKeyInput.player1_UpPressed = false;
        return;
      case 's':
      case 'S':
        currentKeyInput.player1_DownPressed = false;
        return;
      case 'a':
      case 'A':
        currentKeyInput.player1_LeftPressed = false;
        return;
      case 'd':
      case 'D':
        currentKeyInput.player1_RightPressed = false;
        return; 
      case 'c':
      case 'C':
        currentKeyInput.player1_ActionPressed = false;
        return; 
      case 'v':
      case 'V':
        currentKeyInput.player1_SecondaryPressed = false;
        return;    
      case 'k':
      case 'K':
        currentKeyInput.player2_ActionPressed = false;
        return; 
      case 'l':
      case 'L':
        currentKeyInput.player2_SecondaryPressed = false;
        return; 
      }
  }
  switch(keyCode) {
  case UP:
    currentKeyInput.player2_UpPressed = false;
    return;
  case DOWN:
    currentKeyInput.player2_DownPressed = false;
    return;
  case LEFT:
    currentKeyInput.player2_LeftPressed = false;
    return;
  case RIGHT:
    currentKeyInput.player2_RightPressed = false;
    return;
  }
}



final class KeyInput {
  boolean zPressed = false;
  
  boolean player1_UpPressed = false;
  boolean player1_DownPressed = false;
  boolean player1_LeftPressed = false;
  boolean player1_RightPressed = false;
  boolean player1_ActionPressed = false;
  boolean player1_SecondaryPressed = false;

  // Controles Jugador 2
  boolean player2_UpPressed = false;
  boolean player2_DownPressed = false;
  boolean player2_LeftPressed = false;
  boolean player2_RightPressed = false;
  boolean player2_ActionPressed = false;
  boolean player2_SecondaryPressed = false;

}
