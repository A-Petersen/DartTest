import '../FruitObject/AbstractUFO.dart';
import 'MovementCircle.dart';
import 'MovementType.dart';
import 'MovementZigZag.dart';
import 'MovementHalfCircle.dart';

/**
 * Die MovementFactor erstellt verschiedene Movements anhand des Typs.
 */
class MovementFactory {
  MovementType newMovement(int type) {
    switch (type) {
      case 0 : return null;
      case 1 : return new MovementZigZag(15, 3.0);
      case 2 : return new MovementCircle(0.2, 5.0);
      case 3 : return new MovementHalfCircle(2.0, 70.0, 130.0, 220.0);
      default : return null;
    }
  }
}