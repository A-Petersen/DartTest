import '../Fruit.dart';
import 'MovementType.dart';
import 'dart:math';

class MovementCircle extends MovementType {

  double angle = 0.0;
  double radius = 30.0;
  int speedCircle = 0;

  double xDummy = 50.0;
  double yDummy = 50.0;

  MovementCircle(Fruit fruit) : super(fruit);

  void move() {
    double hoeheInProzent = ( yDummy <= 1 ? 0.95 : (yDummy / 320) ); // 0.x
    double yMerk = hoeheInProzent * (fruit.goingUp ? (-1)*fruit.gravity : fruit.gravity);
    xDummy += fruit.speed;
    yDummy += yMerk;

//    fruit.x = xDummy;
//    fruit.y = yDummy;

    //Kreisbewegung
    fruit.x = (xDummy + radius * sin(angle));
    fruit.y = (yDummy + radius * cos(angle));

    angle = (angle + 0.3) % 360;

  }

  String toString() {
    return 'Circle';
  }
}