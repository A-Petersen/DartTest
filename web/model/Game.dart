import '../controller/Controller.dart';
import '../view/Field.dart';
import 'Fruit.dart';
import 'FruitFactory.dart';
import 'Level.dart';
import 'dart:math';

class Game {

  Level level = new Level();
  List<Fruit> fruitsList = new List<Fruit>();
  FruitFactory fruitFactory = new FruitFactory();
  final Field field;
  Controller controller;
  int score = 0;
  int attempts = 3;
  int fruits = 0;

  Game(this.field, this.controller);

  void checkFruits() {
    if (fruits < level.maxFruits) {
      int type = level.possibleFruits == 1 ? 1 :  new Random().nextInt(level.possibleFruits)+1;
      int movement = level.possibleMovments == 0 ?  0 : new Random().nextInt(level.possibleFruits);
      newFruit(fruitFactory.newFruit(type, movement, field));
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