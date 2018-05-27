import '../Vector.dart';
import 'MovementType.dart';

class MovementZigZag extends MovementType {

  int counter = 0;
  bool goLeft = false;

  MovementZigZag();

  Vector move(double speed) {

    vector.x = speed;

    if (!goLeft) {
      vector.x = (vector.x + (3.0 - speed));
      counter++;
    }
    if (goLeft) {
      vector.x = (vector.x - 3.0);
      counter--;
    }
    if (goLeft && counter < -20) goLeft = false;
    if (!goLeft && counter > 20) goLeft = true;

    return vector;
  }

  String toString() {
    return 'ZigZag';
  }
}