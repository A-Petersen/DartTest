import '../controller/Controller.dart';
import '../view/Field.dart';
import 'Figure.dart';
import 'Fruit.dart';
import 'FruitFactory.dart';
import 'Level.dart';
import 'dart:math';
import 'dart:html';

class Game {

  List<Level> allLevels = new List();
  List<Fruit> fruitsList = new List<Fruit>();
  int fieldWidth;
  int fieldHeight;
  FruitFactory fruitFactory;
  Controller controller;
  Figure figure;
  int score = 0;
  Level actualLevel;
  int highscore;
  int attempts = 3;
  int fruits = 0;

  Game(this.controller, this.fieldWidth, this.fieldHeight, this.highscore) {
    this.figure = new Figure(0.0, fieldHeight.toDouble(), fieldWidth * 0.156, fieldHeight * 0.278, fieldWidth, fieldHeight);
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
        if ((fruitsList[i].ground >= fieldHeight-5)) { //-5 weil der Ground der Frucht nicht == der Grund des Feldes.
          fruitsList[i].moving = false;
          if (--attempts <= 0) {
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

        if (fruitsList[i].x >= (fieldWidth-(fieldWidth*0.13)) && fruitsList[i].y >= (fieldHeight-(fieldHeight*0.13))) {
          fruitsList[i].moving = false;
          controller.field.setScore(++score);
        }
      } else {
        removeFruit(fruitsList[i--]);
      }
    }
  }

  void checkFruits() {
    if (fruits < actualLevel.maxFruits) {
      int type = actualLevel.possibleFruits == 1 ? 1 :  new Random().nextInt(actualLevel.possibleFruits)+1;
      int movement = actualLevel.possibleMovments == 0 ?  0 : new Random().nextInt(actualLevel.possibleFruits);
      newFruit(fruitFactory.newFruit(type, movement));
    }
  }

  void checkLevel() {
    for (int i = 0 ; i < allLevels.length ; i++) {
      if (allLevels[i].requiredScore >= score) {
        actualLevel = allLevels[i];
        break;
      }
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
    actualLevel.reset();
    fruits = 0;
    score = 0;
    attempts = 3;
    figure.x = 0.0;
    fruitsList = new List<Fruit>();
  }

  void setLevel(List<Level> levels) {
    this.allLevels = levels;
  }



}