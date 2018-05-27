import '../Vector.dart';
import 'MovementType.dart';
import 'dart:math';

class MovementCircle extends MovementType {

  double angle = 0.0;
  double radius = 5.0;

  MovementCircle();

  Vector move(double speed) {

    vector.x = (radius * sin(angle));
    vector.y = (radius * cos(angle));

    angle = (angle + 0.2) % 360;

    vector.x += speed;

    return vector;
  }

  String toString() {
    return 'Circle';
  }
}