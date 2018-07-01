import 'AbstractUFO.dart';

/**
 * Erbt von AbstractUFO und soll, wenn es eingesammelt werden, den Spieler ein Leben abziehen.
 */
class Bomb extends AbstractUFO {

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
  Bomb(double x, double y, double radius, int type, int fieldWidth, int fieldHeight, [int movementtype = null, double gravity = 10.0, double speed = 1.0]) {
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

  @override
  String getClassName() {
    return 'Bomb';
  }
}