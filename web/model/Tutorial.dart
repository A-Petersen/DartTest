/**
 * Die Klasse Tutorial hält die Information, ob ein Tutorial bereits gezeigt wurde in Form von Boolean-Werte und
 * die Erklärungen in Form von Strings für das Tutorial.
 */
class Tutorial {

  /**
   * Boolean-Werte, um zu prüfen, ob das Tuorial bereits gezeigt wurde.
   */
  bool movement = false;
  bool fruit = false;
  bool bomb = false;
  bool smoothie = false;
  bool heart = false;

  /**
   * Strings, die die Erklärung für das Tutorial beinhalten
   */
  String bananeText;
  String movementText;
  String bombText;
  String smootieText;
  String heartText;

  Tutorial(this.bananeText, this.movementText, this.bombText, this.heartText, this.smootieText,);

  String getBananeText() {
    return bananeText;
  }

  String getMovementText() {
    return movementText;
  }

  String getBombText() {
    return bombText;
  }

  String getSmootheText() {
    return smootieText;
  }

  String getHeartText() {
    return heartText;
  }


}