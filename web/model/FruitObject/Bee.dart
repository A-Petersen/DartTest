import '../Figure.dart';
import 'AbstractUFO.dart';
import 'Fruit.dart';

class HelpingBee extends AbstractUFO {

  int timeEnd = 0;

  Fruit fruit;

  HelpingBee(double x, double y, double radius, int type, int fieldWidth, int fieldHeight, [int movementtype = null, double gravity = 10.0, double speed = 1.0]) {
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

  void startHelp(int duration, int gametime){
    timeEnd+= (duration+gametime);
  }

  void newFruit(Fruit f) {
    this.fruit = f;
    this.x = f.x;
  }

  bool checkCounter(int gametime, Figure f) {
    if (gametime >= timeEnd) {
      f.speed = f.speed/2;
      return true;
    }
    return false;
  }

  @override
  String getClassName() {
    return 'Bee';
  }

  @override
  void move() {
    this.destX = fruit.destX;
  }

  @override
  void moveGravity() {

  }

  @override
  void update() {
    this.x += destX / 640 * fieldWidth;

    if (this.heaven < 0) this.y = this.radius;
    if (this.ground > this.fieldHeight - 1) this.y = this.fieldHeight - 1 - this.radius;

    if (this.left < 0) this.x = this.radius;
    if (this.right > this.fieldWidth - 1) this.x = this.fieldWidth - 1 - this.radius;
  }
}