import '../FruitObject/AbstractUFO.dart';
import 'MovementCircle.dart';
import 'MovementType.dart';
import 'MovementZigZag.dart';

class MovementFactory {
  MovementType newMovement(int type, AbstractUFO fruit) {
    switch (type) {
      case 0 : return null;
      case 1 : return new MovementZigZag(15, 3.0);
      case 2 : return new MovementCircle(0.2, 5.0);
      default : return null;
    }
  }
}