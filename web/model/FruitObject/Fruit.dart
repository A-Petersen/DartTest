import 'AbstractUFO.dart';


class Fruit extends AbstractUFO{

  /**
   * Konstruktor
   */
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
    incrementID();
  }

//  void moveGravity() {
//    double gravityFactor = (y <= 1 ? 0.95 : (y / 320)); // 0.x
//    double newY = gravityFactor * (goingUp ? (-1) * gravity : gravity);
//    this.destY = newY;
//  }

//  /**
//   * Position des Objektes setzten.
//   */
//  void position(double posX, double posY) {
//    this.x = posX;
//    this.y = posY;
//  }

//  /**
//   * Update
//   */
//  void update() {
//    this.x += destX;
//    this.y += destY;
//
//    if (this.goingUp && (this.y - this.radius <= 11) ) this.goingUp = false;
//
//    if (this.heaven < 0) this.y = this.radius;
//    if (this.ground > this.fieldHeight - 1) this.y = this.fieldHeight - 1 - this.radius;
//
//    if (this.left < 0) this.x = this.radius;
//    if (this.right > this.fieldWidth - 1) this.x = this.fieldWidth - 1 - this.radius;
//  }

  @override
  String getClassName() {
    return 'Fruit';
  }

}