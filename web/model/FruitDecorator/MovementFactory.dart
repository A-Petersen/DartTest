import '../Fruit.dart';
import 'MovementCircle.dart';
import 'MovementType.dart';
import 'MovementZigZag.dart';

class MovementFactory {
  MovementType newMevement(int type, Fruit fruit) {
    switch (type) {
      case 1 : return new MovementZigZag(fruit); break;
      case 2 : return new MovementCircle(fruit); break;
    }
  }
}