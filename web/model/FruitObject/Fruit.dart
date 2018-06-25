import 'AbstractUFO.dart';


class Fruit extends AbstractUFO{

  /**
   * Konstruktor
   */
  Fruit(double x, double y, double radius, int type, int fieldWidth, int fieldHeight, [int movementtype = null, double gravity = 10.0, double speed = 1.0, bool rotate = true]) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this. type = type;
    this. fieldHeight = fieldHeight;
    this.fieldWidth = fieldWidth;
    this.gravity = gravity;
    this.speed = speed;
    this.movementType = movementFactory.newMovement(movementtype);
    this.rotate = rotate;
    incrementID();
  }

  @override
  String getClassName() {
    return 'Fruit';
  }

}