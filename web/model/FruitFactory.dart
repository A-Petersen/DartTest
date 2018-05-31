import '../view/Field.dart';
import 'Fruit.dart';

class FruitFactory {

  int fieldWidth, fieldHeight;

  FruitFactory(this.fieldWidth, this.fieldHeight);

  Fruit newFruit(int type, int movement) {
    switch (type) {
      case 1 : return new Fruit(0.0, 0.0, 10.0, 1, fieldWidth, fieldHeight, movement, 10.0, 1.0);
      case 2 : return new Fruit(0.0, 0.0, 10.0, 2, fieldWidth, fieldHeight, movement, 5.0, 1.5);
      case 3 : return new Fruit(0.0, 0.0, 10.0, 3, fieldWidth, fieldHeight, movement, 20.0, 2.0);
    }
  }

}