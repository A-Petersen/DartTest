import '../Vector.dart';
import 'MovementType.dart';
import 'dart:math';

class MovementCircle extends MovementType {

  double angle = 0.0;
  double angleWidth;
  double radius;

  MovementCircle(this.angleWidth, this.radius);

  Vector move(double speed) {

    vector.x = (radius * sin(angle));
    vector.y = (radius * cos(angle));

    angle = (angle + angleWidth) % 360;

    vector.x += speed;

    return vector;
  }

  String toString() {
    return 'Circle';
  }
}