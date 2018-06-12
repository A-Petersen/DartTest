import '../controller/Controller.dart';
import 'Figure.dart';
import 'FruitObject/AbstractUFO.dart';
import 'FruitObject/Bomb.dart';
import 'FruitObject/Fruit.dart';
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

  bool gameover = false;

  Game(this.controller, this.fieldWidth, this.fieldHeight, this.highscore) {
    this.figure = new Figure(0.0, fieldHeight.toDouble(), fieldWidth * 0.156, fieldHeight * 0.278, fieldWidth, fieldHeight, 10.0);
    ufoFactory = new UFOFactory(fieldWidth, fieldHeight);
  }

  void checkUFOState() {
    AbstractUFO ufo;
    for (int i = 0 ; i < ufos ; i++) {
      ufo = ufoList[i];

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
          print(attempts);
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

  void newUFO(AbstractUFO ufo) {
    ufoList.add(ufo);
    ufos++;
    controller.newUFOView(ufo);
  }

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