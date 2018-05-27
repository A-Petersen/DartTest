import '../Vector.dart';

abstract class MovementType {
  Vector vector;

  MovementType() {
    this.vector = new Vector();
  }

  Vector move(double speed);

  String toString();
}