import '../Fruit.dart';
import 'MovementType.dart';
import 'MovementZigZag.dart';

class MovementFactory {
  MovementType newMevement(int type, Fruit fruit) {
    switch (type) {
      case 1 : return new MovementZigZag(fruit); break;
    }
  }
}