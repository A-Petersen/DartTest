import '../Vector.dart';
import 'MovementType.dart';

class MovementZigZag extends MovementType {

  int counter = 0;
  int zigzagWidth;
  double zigzagSpeed;
  bool goLeft = false;

  MovementZigZag(this.zigzagWidth, this.zigzagSpeed);

  Vector move(double speed) {

    vector.x = speed;

    if (!goLeft) {
      vector.x = (vector.x + (zigzagSpeed - speed));
      counter++;
    }
    if (goLeft) {
      vector.x = (vector.x - zigzagSpeed);
      counter--;
    }
    if (goLeft && counter < -zigzagWidth) goLeft = false;
    if (!goLeft && counter > zigzagWidth) goLeft = true;

    return vector;
  }

  String toString() {
    return 'ZigZag';
  }
}