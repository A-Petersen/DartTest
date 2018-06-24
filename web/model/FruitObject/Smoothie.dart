import '../Figure.dart';
import 'AbstractUFO.dart';

class Smoothie extends AbstractUFO {

  static bool dope = false;

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
    this.movementType = movementFactory.newMovement(movementtype);
    incrementID();
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