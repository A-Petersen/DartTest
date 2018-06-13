import '../controller/Controller.dart';
import 'Figure.dart';
import 'FruitObject/AbstractUFO.dart';
import 'FruitObject/Bomb.dart';
import 'FruitObject/Fruit.dart';
import 'FruitObject/Smoothie.dart';
import 'FruitObject/UFOFactory.dart';
import 'Level.dart';
import 'dart:math';

class Game {
  List<AbstractUFO> ufoList = new List<AbstractUFO>();
  List<Level> allLevels = new List<Level>();
  int fieldWidth;
  int fieldHeight;
  UFOFactory ufoFactory;
  Controller controller;
  Figure figure;
  int score = 0;
  Level actualLevel;
  int highscore;
  int attempts = 3;

  int fruits = 0;
  int bombs = 0;
  int ufos = 0;

  int gametime = 0;

  bool gameover = false;

  Game(this.controller, this.fieldWidth, this.fieldHeight, this.highscore) {
    this.figure = new Figure(0.0, fieldHeight.toDouble(), fieldWidth * 0.156, fieldHeight * 0.278, fieldWidth, fieldHeight, 10.0);
    ufoFactory = new UFOFactory(fieldWidth, fieldHeight);
  }

  void checkUFOState(int time) {
    gametime+= time;
    AbstractUFO ufo;
    for (int i = 0 ; i < ufos ; i++) {
      ufo = ufoList[i];

      switch(ufo.getClassName()) {
        case ('Fruit'):
          if (ufo.moving) {
            ufo.move();
            controller.field.updateUFOs(ufo);
            if (ufo.hitGround()) { //Ufo auf dem Boden gefallen?
              ufo.moving = false;
              if (--attempts <= 0) {
                checkHighscore();
                gameover = true;
                return;
              }
            }
            if (ufo.onDrum(figure)) { //Ufo auf der Trommel?
              ufo.goingUp = true;
            }
            if (ufo.landedInBasket()) { //Ufo im Korb?
              ufo.moving = false;
              score++;
            }
          } else {
            removeUFO(ufoList[i--]);
          }
          break;
        case ('Bomb'):
          if (ufo.moving) {
            ufo.move();
            controller.field.updateUFOs(ufo);
            if (ufo.hitGround()) { //Ufo auf dem Boden gefallen?
              ufo.moving = false;
            }
            if (ufo.onDrum(figure)) { //Ufo auf der Trommel?
              ufo.moving = false;
              if (--attempts <= 0) {
                checkHighscore();
                gameover = true;
                return;
              }
            }
          } else {
            removeUFO(ufoList[i--]);
          }
          break;
        case ('Smoothie') :
          Smoothie cast = ufo;
          if (ufo.moving) {
            ufo.move();
            controller.field.updateUFOs(ufo);
            if (ufo.hitGround()) { //Ufo auf dem Boden gefallen?
              removeUFO(ufoList[i--]);
            }
            if (ufo.onDrum(figure)) { //Ufo auf der Trommel?
              ufo.moving = false;
              controller.removeUFOView(ufo);
              cast.drinkSmoothie(10000, time, figure);
            }
          } else {
            if (cast.checkCounter(time, figure)) {
              ufoList.remove(ufo);
              ufos--;
            }
          }
          break;

      }


    }
  }

  void checkUFOs() {
    // TODO if schleife für bomben etc implementieren ?
    if (actualLevel == null) return;
    if (fruits < actualLevel.maxFruits) {
      int type = actualLevel.possibleFruits == 1 ? 1 :  new Random().nextInt(actualLevel.possibleFruits)+1;
      int movement = actualLevel.possibleMovments == 0 ?  0 : new Random().nextInt(actualLevel.possibleFruits);
      newUFO(ufoFactory.newFruit(type, movement));
      fruits++;
    }

    if (chance(10)) {
      int type = actualLevel.possibleBombs == 1 ? 1 :  new Random().nextInt(actualLevel.possibleBombs)+1;
      int movement = actualLevel.possibleMovments == 0 ?  0 : new Random().nextInt(actualLevel.possibleBombs);
      newUFO(ufoFactory.newBomb(type, movement, figure.x));
      bombs++;
    }
    if (chance(30)) {
      newUFO(ufoFactory.newSmoothie(1, 0));
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

  void newUFO(AbstractUFO ufo) {
    ufoList.add(ufo);
    ufos++;
    controller.newUFOView(ufo);
  }

  void removeUFO(AbstractUFO ufo) {
    ufoList.remove(ufo);
    ufos--;
    switch (ufo.getClassName()) {
      case ("Fruit") :
        fruits--;
        break;
      case ("Bomb") :
        bombs--;
        break;
    }
    controller.removeUFOView(ufo);
  }

  void reset() {
    actualLevel.reset();
    gameover = false;
    fruits = 0;
    bombs = 0;
    ufos = 0;
    score = 0;
    attempts = 3;
    figure.x = 0.0;
    ufoList = new List<Fruit>();
  }

  void setLevel(List<Level> levels) {
    this.allLevels = levels;
  }

  void checkHighscore() {
    if (score > highscore) {
      highscore = score;
    }
  }

  bool chanche(int percent) {
    return new Random().nextInt(101) < percent;
  }

}