import '../Figure.dart';
import 'AbstractUFO.dart';

class Smoothie extends AbstractUFO {

  static bool dope = false;

//  //TODO id sollte in abstract class stehen !?
//  static int id;
  int timeEnd = 0;

  Smoothie(double x, double y, double radius, int type, int fieldWidth, int fieldHeight, [int movementtype = null, double gravity = 10.0, double speed = 1.0]) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this. type = type;
    this. fieldHeight = fieldHeight;
    this.fieldWidth = fieldWidth;
    this.gravity = gravity;
    this.speed = speed;
    this.movementType = movementFactory.newMovement(movementtype, this);
    incrementID();
  }

  @override
  void move() {
    if (movementType == null) {
      moveGravity();
      this.destX = speed;
    } else {
      moveGravity();
      vector = movementType.move(this.speed);
      this.destX = vector.x;
      this.destY += vector.y;
    }
  }

  @override
  void moveGravity() {
    double gravityFactor = (y <= 1 ? 0.95 : (y / 320)); // 0.x
    double newY = gravityFactor * (goingUp ? (-1) * gravity : gravity);
    this.destY = newY;
  }

  @override
  void update() {
    this.x += destX / 640 * fieldWidth;
    this.y += destY / 360 * fieldHeight;

    if (this.goingUp && (this.y - this.radius <= 11) ) this.goingUp = false;

    if (this.heaven < 0) this.y = this.radius;
    if (this.ground > this.fieldHeight - 1) this.y = this.fieldHeight - 1 - this.radius;

    if (this.left < 0) this.x = this.radius;
    if (this.right > this.fieldWidth - 1) this.x = this.fieldWidth - 1 - this.radius;
  }

  @override
  void drinkSmoothie(int duration, int gametime, Figure f) {
    if (!dope) {
      timeEnd+= (duration+gametime);
      f.speed = f.speed*2;
      dope = true;
    }
  }

  bool checkCounter(int gametime, Figure f) {
    if (gametime >= timeEnd) {
      f.speed = f.speed/2;
      dope = false;
//      print("true");
      return true;
    }
//    print("doped");
//    print(gametime);
//    print(timeEnd);
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