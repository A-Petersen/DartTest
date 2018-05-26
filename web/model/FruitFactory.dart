import '../view/Field.dart';
import 'Fruit.dart';

class FruitFactory {

  Fruit newFruit(int type, Field field) {
    switch (type) {
      case 1 : return new Fruit(0.0, 0.0, 10.0, field, 1, 1); break;
      case 2 : return new Fruit(0.0, 0.0, 10.0, field, 2, 1, 5.0, 0.5); break;
      case 3 : return new Fruit(0.0, 0.0, 10.0, field, 3, 1, 20.0, 2.0); break;
    }
  }

}