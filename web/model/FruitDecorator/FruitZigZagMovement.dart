import '../AbstractFruit.dart';
import 'FruitDecorator.dart';

class FruitZigZagMovement extends FruitDecorator {

  int counter = 0;
  bool goLeft = false;

  FruitZigZagMovement(AbstractFruit fruit) : super(fruit);

  void move() {

    fruit.move();

    if (counter >= 0 && !goLeft) {
      fruit.destX = (fruit.destX + 1.0);
      counter++;
    }
      if (counter < 0 && goLeft) {
        fruit.destX = (fruit.destX - 1.0);
      counter--;
    }
      if (goLeft && counter > -10) goLeft = false;
      if (!goLeft && counter > 9) goLeft = true;


  }


  int get ground => fruit.ground;


  int get heaven => fruit.heaven;


  int get height => fruit.height;


  int get left => fruit.left;


  void position(double posX, double posY) {
    fruit.position(posX, posY);
  }


  int get right => fruit.right;


  void update() {
    print('help');
    fruit.update();
  }


  int get width => fruit.width;
}