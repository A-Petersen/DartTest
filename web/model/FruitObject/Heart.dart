import 'AbstractUFO.dart';

/**
 * Heart erbt von AbstractUFO und soll, wenn es eingesammlt wird, dem Spieler ein Leben geben.
 */
class Heart extends AbstractUFO {

  Heart(double x, double y, double radius, int type, int fieldWidth, int fieldHeight, [int movementtype = null, double gravity = 10.0, double speed = 1.0]) {
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
    return 'Heart';
  }
}