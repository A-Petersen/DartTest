import 'AbstractUFO.dart';

/**
 * Erbt von AbstractUFO und ist das UFO, dass in das Ziel gebracht werden soll.
 * Fällt es auf den Boden, gibt es ein Leben abzug.
 * Fällt es in den Korb, gibt es +1 Score.
 */
class Fruit extends AbstractUFO{

  Fruit(double x, double y, double radius, int type, int fieldWidth, int fieldHeight, [int movementtype = null, double gravity = 10.0, double speed = 1.0]) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this. type = type;
    this. fieldHeight = fieldHeight;
    this.fieldWidth = fieldWidth;
    this.gravity = gravity;
    this.speed = speed;
    this.movementType = movementFactory.newMovement(movementtype);
    if (movementtype != null) {
      destY = y;
      destX = x;
    }
    incrementID();
  }

  @override
  String getClassName() {
    return 'Fruit';
  }

}