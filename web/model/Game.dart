import '../controller/Controller.dart';
import '../view/Field.dart';
import 'Figure.dart';
import 'Fruit.dart';
import 'FruitFactory.dart';
import 'Level.dart';
import 'dart:math';

class Game {

  Level level = new Level();
  List<Fruit> fruitsList = new List<Fruit>();
  int fieldWidth;
  int fieldHeight;
  FruitFactory fruitFactory;
  Controller controller;
  Figure figure;
  int score = 0;
  int attempts = 3;
  int fruits = 0;

  Game(this.controller, this.fieldWidth, this.fieldHeight) {
    this.figure = new Figure(0.0, 280.0, 100.0, 100.0, fieldWidth, fieldHeight);
    fruitFactory = new FruitFactory(fieldWidth, fieldHeight);
  }

  void movement(Fruit fruit) {
    fruit.move();
    controller.field.updateFruit(fruit);
  }

  void checkFruitState() {
    for (int i = 0 ; i < fruits ; i++) {
      if (fruitsList[i].moving) {
        movement(fruitsList[i]);
        if ((fruitsList[i].y >= 260.0 && !figure.onDrum(fruitsList[i]))) {
          fruitsList[i].moving = false;
          if (--attempts <= -100) {
            controller.gameover();
            return;
          }
        }
        if (fruitsList[i].y > fieldHeight - (figure.b * 0.75) && figure.onDrum(fruitsList[i])) {
          fruitsList[i].goingUp = true;
        }

        if (fruitsList[i].left >= 480 && fruitsList[i].heaven >= 240) {
          fruitsList[i].moving = false;
          controller.field.setScore(++score);
        }

      } else {
        removeFruit(fruitsList[i--]);
      }
    }
  }

  void checkFruits() {
    if (fruits < level.maxFruits) {
      int type = level.possibleFruits == 1 ? 1 :  new Random().nextInt(level.possibleFruits)+1;
      int movement = level.possibleMovments == 0 ?  0 : new Random().nextInt(level.possibleFruits);
      newFruit(fruitFactory.newFruit(type, movement));
    }
  }

  void checkLevel() {
    if (score > 3 && score < 6) {
      level.level = 2;
      level.maxFruits = 4;
      level.possibleFruits = 2;
      level.possibleMovments = 1;
    }

    if (score > 10 && score < 30) {
      level.level = 3;
      level.maxFruits = 5;
      level.possibleFruits = 3;
      level.possibleMovments = 2;
    }
  }

  void newFruit(Fruit f) {
    fruitsList.add(f);
    fruits++;
    controller.newFruitView(f);
  }

  void removeFruit(Fruit f) {
    fruitsList.remove(f);
    fruits--;
    controller.removeFruitView(f);
  }



}