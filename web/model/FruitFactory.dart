import '../view/Field.dart';
import 'Fruit.dart';

class FruitFactory {

  Fruit newFruit(int type, int movement, Field field) {
    switch (type) {
      case 1 : return new Fruit(0.0, 0.0, 10.0, field, 1, movement, 10, 1);
      case 2 : return new Fruit(0.0, 0.0, 10.0, field, 2, movement, 5.0, 0.5);
      case 3 : return new Fruit(0.0, 0.0, 10.0, field, 3, movement, 20.0, 2.0);
    }
  }

}