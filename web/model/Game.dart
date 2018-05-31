import '../controller/Controller.dart';
import '../view/Field.dart';
import 'Figure.dart';
import 'Fruit.dart';
import 'FruitFactory.dart';
import 'Level.dart';
import 'dart:math';
import 'dart:html';

class Game {

  Level level = new Level();
  List<Fruit> fruitsList = new List<Fruit>();
  int fieldWidth;
  int fieldHeight;
  FruitFactory fruitFactory;
  Controller controller;
  Figure figure;
  int score = 0;
  int highscore;
  int attempts = 3;
  int fruits = 0;

  Game(this.controller, this.fieldWidth, this.fieldHeight, this.highscore) {
    this.figure = new Figure(0.0, fieldHeight.toDouble()-100 , 100.0, 100.0, fieldWidth, fieldHeight);
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
        if ((fruitsList[i].y >= figure.heaven+70 && !figure.onDrum(fruitsList[i]))) {
          fruitsList[i].moving = false;
          if (--attempts <= 2) {
            if (score > highscore) {
              highscore = score;
              controller.setHighscore(highscore);
            }
              controller.gameover();
              return;

          }
        }
        if (fruitsList[i].y > fieldHeight - (figure.b * 0.75) && figure.onDrum(fruitsList[i])) {
          fruitsList[i].goingUp = true;
        }

        if (fruitsList[i].x >= fieldWidth-85 && fruitsList[i].y >= fieldHeight-85) {
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
      level.maxFruits = 3;
      level.possibleFruits = 2;
      level.possibleMovments = 0;
    }

    if (score > 6 && score < 9) {
      level.level = 3;
      level.maxFruits = 3;
      level.possibleFruits = 3;
      level.possibleMovments = 0;
    }

    if (score > 9 && score < 12) {
      level.level = 4;
      level.maxFruits = 3;
      level.possibleFruits = 3;
    }

    if (score > 12 && score < 15) {
      level.level = 5;
      level.maxFruits = 3;
      level.possibleFruits = 3;
    }

    if (score > 15 && score < 18) {
      level.level = 6;
      level.maxFruits = 4;
      level.possibleFruits = 3;
    }

    if (score > 18 && score < 21) {
      level.level = 7;
      level.maxFruits = 5;
      level.possibleFruits = 3;
    }

    if (score > 15 && score % 10 == 0) {
      level.level++;
      level.maxFruits++;
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

  void reset() {
    level.reset();
    fruits = 0;
    score = 0;
    attempts = 3;
    figure.x = 0.0;
    fruitsList = new List<Fruit>();
  }



}