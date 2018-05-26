import '../Fruit.dart';
import 'MovementType.dart';

class MovementZigZag extends MovementType {

  int counter = 0;
  bool goLeft = false;

  MovementZigZag(Fruit fruit) : super(fruit);

  void move() {
    double hoeheInProzent = ( fruit.y <= 1 ? 0.95 : (fruit.y / 320) ); // 0.x
    double yMerk = hoeheInProzent * (fruit.goingUp ? (-1)*fruit.gravity : fruit.gravity);
    fruit.destX = fruit.speed;
    fruit.destY = yMerk;

//    vector.setVector(fruit.speed, yMerk);

    if (!goLeft) {
      fruit.destX = (fruit.destX + (3.0 - fruit.speed));
      counter++;
    }
    if (goLeft) {
      fruit.destX = (fruit.destX - 3.0);
      counter--;
    }
    if (goLeft && counter < -20) goLeft = false;
    if (!goLeft && counter > 20) goLeft = true;

  }

  String toString() {
    return 'ZigZag';
  }
}