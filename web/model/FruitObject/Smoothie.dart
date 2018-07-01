import '../Figure.dart';
import 'AbstractUFO.dart';

/**
 * Smoothie erbt von AbstractUFO soll die Figur beschleunigen, wenn es eingesammelt wird
 */
class Smoothie extends AbstractUFO {

  /**
   * Mit dope kann geprüft werden, ob der Effekt aktiv ist
   */
  static bool dope = false;

  /**
   * Zeitpunkt, wann der Effekt enden soll
   */
  int timeEnd = 0;

  /**
   * Konstruktor
   * [x] StartPosition in x
   * [y] StartPosition in y
   * [type] Type des UFOs
   * [fieldWidth] Breite des Spielfeldes im Model
   * [fieldHeight] Höhe des Spielfeldes im Model
   * [movementtype] Art der Bewegung des UFOs (Default = null)
   * [gravity] Anziehnungskraft des UFOs in Richtung Boden ("Geschwindigkeit" in y Richtung)
   * [speed] Geschwindigkeit in x Richtung
   */
  Smoothie(double x, double y, double radius, int type, int fieldWidth, int fieldHeight, [int movementtype = null, double gravity = 10.0, double speed = 1.0]) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this. type = type;
    this. fieldHeight = fieldHeight;
    this.fieldWidth = fieldWidth;
    this.gravity = gravity;
    this.speed = speed;
    this.movementType = movementFactory.newMovement(movementtype);
    incrementID();
  }

  /**
   * Funktion zum aktivieren des Effektes.
   * Erwartet eine Wert für die Dauer, eine aktuelle Spielzeit und die Figur.
   */
  void drinkSmoothie(int duration, int gametime, Figure f) {
    if (!dope) { //Prüfen, ob der Effekt bereits aktiv ist
      timeEnd+= (duration+gametime);
      f.speed = f.speed*2; //Die Figur-Geschwindigkeit verdoppeln
      dope = true;
    }
  }

  /**
   * Funktion zum prüfen, ob der Effekt noch aktiv sein soll und ggf. wieder zu deaktivieren.
   * Erwartet die aktuelle Spielzeit und die Figur.
   */
  bool checkCounter(int gametime, Figure f) {
    if (gametime >= timeEnd) {
      f.speed = f.speed/2;
      dope = false;
      return true;
    }
    return false;
  }


  @override
  String getClassName() {
    return 'Smoothie';
  }

  bool getDope() {
    return dope;
  }

  void setDope(bool bool) {
    dope = bool;
  }
}