import 'AbstractUFO.dart';
import 'Bomb.dart';
import 'Fruit.dart';
import 'Smoothie.dart';

class UFOFactory {

  int fieldWidth, fieldHeight;
  double radius;

  UFOFactory(this.fieldWidth, this.fieldHeight) {
    this.radius = fieldWidth * 0.015 > fieldHeight * 0.015 ? fieldWidth * 0.015 : fieldHeight * 0.015;
  }

  AbstractUFO newFruit(int type, int movement) {
    switch (type) {
      case 1 : return new Fruit(0.0, 0.0, radius, 1, fieldWidth, fieldHeight, movement, 10.0, 1.0);
      case 2 : return new Fruit(0.0, 0.0, radius, 2, fieldWidth, fieldHeight, movement, 5.0, 1.5);
      case 3 : return new Fruit(0.0, 0.0, radius, 3, fieldWidth, fieldHeight, movement, 20.0, 2.0);
    }
  }

  AbstractUFO newBomb(int type, int movement) {
    switch (type) {
      case 1 : return new Bomb(0.0, 0.0, radius, 4, fieldWidth, fieldHeight, movement, 20.0, 2.0);
    }
  }

  AbstractUFO newSmoothie(int type, int movement) {
    switch (type) {
      case 1 : return new Smoothie(0.0, 0.0, radius, 4, fieldWidth, fieldHeight, movement, 20.0, 2.0);
    }
  }

}