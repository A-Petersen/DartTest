import '../controller/Controller.dart';
import 'Figure.dart';
import 'FruitObject/AbstractUFO.dart';
import 'FruitObject/Bomb.dart';
import 'FruitObject/Fruit.dart';
import 'FruitObject/UFOFactory.dart';
import 'Level.dart';
import 'dart:math';

class Game {
  
//  List<Fruit> fruitsList = new List<Fruit>();
//  List<Bomb> bombList = new List<Bomb>();
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

  bool gameover = false;

  Game(this.controller, this.fieldWidth, this.fieldHeight, this.highscore) {
    this.figure = new Figure(0.0, fieldHeight.toDouble(), fieldWidth * 0.156, fieldHeight * 0.278, fieldWidth, fieldHeight, 10.0);
    ufoFactory = new UFOFactory(fieldWidth, fieldHeight);
  }

//  void movement(Fruit fruit) {
//    fruit.move();
//    controller.field.updateFruit(fruit);
//  }

//  void checkFruitState() {
//    Fruit fruit;
//    for (int i = 0 ; i < fruits ; i++) {
//      fruit = fruitsList[i];
//      if (fruit.moving) {
//        fruit.move();
//        controller.field.updateFruit(fruit);
//        if (fruit.ground >= fieldHeight-5) { //-5 weil der Ground der Frucht nicht == der Grund des Feldes.
//          fruit.moving = false;
//          if (--attempts <= 0) {
//            if (score > highscore) {
//              highscore = score;
//            }
//              gameover = true;
//              return;
//          }
//        }
//        if (fruit.y > fieldHeight - (figure.b * 0.75) && figure.onDrum(fruit)) {
//          fruit.goingUp = true;
//        }
//
//        if (fruit.x >= (fieldWidth-(fieldWidth*0.13)) && fruit.y >= (fieldHeight-(fieldHeight*0.13))) {
//          fruit.moving = false;
//          score++;
//        }
//      } else {
//        removeFruit(fruitsList[i--]);
//      }
//    }
//  }

//  void checkBombState() {
//    Bomb bomb;
//    for (int i = 0 ; i < fruits ; i++) {
//      bomb = bombList[i];
//      if (bomb.moving) {
//        bomb.move();
//        controller.field.updateBombs(bomb);
//        if (bomb.ground >= fieldHeight-5) { //-5 weil der Ground der Frucht nicht == der Grund des Feldes.
//          bomb.moving = false;
//          if (--attempts <= 0) {
//            if (score > highscore) {
//              highscore = score;
//            }
//            gameover = true;
//            return;
//          }
//        }
//        if (bomb.y > fieldHeight - (figure.b * 0.75) && figure.onDrum(bomb)) {
//          bomb.goingUp = true;
//        }
//
//        if (bomb.x >= (fieldWidth-(fieldWidth*0.13)) && bomb.y >= (fieldHeight-(fieldHeight*0.13))) {
//          bomb.moving = false;
//          score++;
//        }
//      } else {
//        removeBomb(bombList[i--]);
//      }
//    }
//  }

  void checkUFOState() {
    AbstractUFO ufo;
    for (int i = 0 ; i < ufos ; i++) {
      ufo = ufoList[i];

//      print(ufo.getClassName());
      switch(ufo.getClassName()) {
        case ('Fruit'):
          print("I'm a Fruit!!!");
          break;
        case ('Bomb'):
          print("I'm a Bomb!!!");
          break;
      }

      if (ufo.moving) {
        ufo.move();
        controller.field.updateUFOs(ufo);
        if (ufo.ground >= fieldHeight-5) { //-5 weil der Ground der Frucht nicht == der Grund des Feldes.
          ufo.moving = false;
          if (--attempts <= 0) {
            if (score > highscore) {
              highscore = score;
            }
            gameover = true;
            return;
          }
        }
        if (ufo.y > fieldHeight - (figure.b * 0.75) && figure.onDrum(ufo)) {
          ufo.goingUp = true;
        }

        if (ufo.x >= (fieldWidth-(fieldWidth*0.13)) && ufo.y >= (fieldHeight-(fieldHeight*0.13))) {
          ufo.moving = false;
          score++;
        }
      } else {
        removeUFO(ufoList[i--]);
      }
    }
  }


//  void checkFruits() {
//    if (fruits < level.maxFruits) {
//      int type = level.possibleFruits == 1 ? 1 :  new Random().nextInt(level.possibleFruits)+1;
//      int movement = level.possibleMovments == 0 ?  0 : new Random().nextInt(level.possibleFruits);
//      newFruit(ufoFactory.newFruit(type, movement));
//    }
//  }

  void checkUFOs() {
    // TODO if schleife für bomben etc implementieren ?
    if (actualLevel == null) return;
    if (fruits < actualLevel.maxFruits) {
      int type = actualLevel.possibleFruits == 1 ? 1 :  new Random().nextInt(actualLevel.possibleFruits)+1;
      int movement = actualLevel.possibleMovments == 0 ?  0 : new Random().nextInt(actualLevel.possibleFruits);
      newUFO(ufoFactory.newFruit(type, movement));
    }

    if (bombs < actualLevel.maxBombs) {
      int type = actualLevel.possibleBombs == 1 ? 1 :  new Random().nextInt(actualLevel.possibleBombs)+1;
      int movement = actualLevel.possibleMovments == 0 ?  0 : new Random().nextInt(actualLevel.possibleBombs);
      newUFO(ufoFactory.newBomb(type, movement));
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

//  void newFruit(Fruit f) {
//    fruitsList.add(f);
//    fruits++;
//    controller.newFruitView(f);
//  }
//
//  void newBomb(Bomb b) {
//    bombList.add(b);
//    bombs++;
////    controller.newBombView(b);
//  }

  void newUFO(AbstractUFO ufo) {
    ufoList.add(ufo);
    ufos++;
    controller.newUFOView(ufo);
  }

//  void removeFruit(Fruit f) {
//    fruitsList.remove(f);
//    fruits--;
//    controller.removeFruitView(f);
//  }
//
//  void removeBomb(Bomb b) {
//    bombList.remove(b);
//    bombs--;
////    controller.removeBombView(b);
//  }

  void removeUFO(AbstractUFO ufo) {
    ufoList.remove(ufo);
    ufos--;
    controller.removeUFOView(ufo);
  }

  void reset() {
    actualLevel.reset();
    fruits = 0;
    bombs = 0;
    ufos = fruits + bombs;
    score = 0;
    attempts = 3;
    figure.x = 0.0;
    ufoList = new List<Fruit>();
  }

  void setLevel(List<Level> levels) {
    this.allLevels = levels;
  }



}