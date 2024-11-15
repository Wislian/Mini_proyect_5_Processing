abstract class AbstractInputDevice
{
  int horizontalMoveButton, verticalMoveButton;
  boolean shotButtonPressed, longShotButtonPressed;

  void operateMoveButton(int horizontal, int vertical) {
    horizontalMoveButton = horizontal;
    verticalMoveButton = vertical;
  }
  void operateShotButton(boolean pressed) {
    shotButtonPressed = pressed;
  }
  void operateLongShotButton(boolean pressed) {
    longShotButtonPressed = pressed;
  }
}

final class InputDevice
  extends AbstractInputDevice
{
}

final class ShotDisabledInputDevice
  extends AbstractInputDevice
{
  void operateShotButton(boolean pressed) {
  }
  void operateLongShotButton(boolean pressed) {
  }
}

final class DisabledInputDevice
  extends AbstractInputDevice
{
  void operateMoveButton(int horizontal, int vertical) {
  }
  void operateShotButton(boolean pressed) {
  }
  void operateLongShotButton(boolean pressed) {
  }
}



abstract class PlayerEngine
{
  final AbstractInputDevice controllingInputDevice;

  PlayerEngine() {
    controllingInputDevice = new InputDevice();
  }

  abstract void run(PlayerActor player);
}

final class HumanPlayerEngine
  extends PlayerEngine
{
  final KeyInput currentKeyInput;
  final int playerId;

  HumanPlayerEngine(KeyInput _keyInput, int _playerId) {
    currentKeyInput = _keyInput;
    playerId = _playerId;
  }

  void run(PlayerActor player) {
   int intUp, intDown, intLeft, intRight;
    boolean isActionPressed, isSecondaryPressed;

    if (playerId == 1) {
      intUp = currentKeyInput.player1_UpPressed ? -1 : 0;
      intDown = currentKeyInput.player1_DownPressed ? 1 : 0;
      intLeft = currentKeyInput.player1_LeftPressed ? -1 : 0;
      intRight = currentKeyInput.player1_RightPressed ? 1 : 0;
      isActionPressed = currentKeyInput.player1_ActionPressed;
      isSecondaryPressed = currentKeyInput.player1_SecondaryPressed;
    } else {
      intUp = currentKeyInput.player2_UpPressed ? -1 : 0;
      intDown = currentKeyInput.player2_DownPressed ? 1 : 0;
      intLeft = currentKeyInput.player2_LeftPressed ? -1 : 0;
      intRight = currentKeyInput.player2_RightPressed ? 1 : 0;
      isActionPressed = currentKeyInput.player2_ActionPressed;
      isSecondaryPressed = currentKeyInput.player2_SecondaryPressed;
    } 

    controllingInputDevice.operateMoveButton(intLeft + intRight, intUp + intDown);
    controllingInputDevice.operateShotButton(isActionPressed);
    controllingInputDevice.operateLongShotButton(isSecondaryPressed);
  }
}
