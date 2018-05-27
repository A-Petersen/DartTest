import '../Fruit.dart';
import 'MovementCircle.dart';
import 'MovementType.dart';
import 'MovementZigZag.dart';

class MovementFactory {
  MovementType newMovement(int type, Fruit fruit) {
    switch (type) {
      case 0 : return null;
      case 1 : return new MovementZigZag();
      case 2 : return new MovementCircle();
      default : return null;
    }
  }
}