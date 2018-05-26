import '../Fruit.dart';
import '../Vector.dart';

abstract class MovementType {
  Vector vector;
  Fruit fruit;

  MovementType(Fruit fruit) {
    this.vector = new Vector();
    this.fruit = fruit;
  }

  void move();

  String toString();
}