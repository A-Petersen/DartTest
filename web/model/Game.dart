import 'Figure.dart';
import 'FruitObject/AbstractUFO.dart';
import 'FruitObject/Bomb.dart';
import 'FruitObject/Fruit.dart';
import 'FruitObject/Smoothie.dart';
import 'FruitObject/UFOFactory.dart';
import 'Level.dart';
import 'Tutorial.dart';
import 'dart:math';

/**
 * Die Game-Klasse sorgt für den Spielablauf und ist die Schnittstelle für den Controller auf das Model.
 * Game erstellt alle notwendigen Model-Instanzen und/oder bekommt diese von dem Controller, ausgelesen aus einer JSON-Datei (allLevels und tutorial).
 */
class Game {

  List<AbstractUFO> ufoList = new List<AbstractUFO>(); //Liste für alle UFOs, die aktiv im Spiel sind
  List<Level> allLevels = new List<Level>(); //Alle Level des Spieles
  int fixedFieldWidth = 640; //Spielfeldbreite, festgelegt auf 640
  int fixedFieldHeight = 360; //Spielfeldhöhe, festgelegt auf 360
  UFOFactory ufoFactory;  //Factory zum erstellen von UFOs
  Figure figure; //Spielfigur
  int score = 0; //Aktueller Score, ist am Anfang immer 0
  Level actualLevel; //Aktuelles Level
  int highscore; //Der Highscore des Spieles
  int attempts = 5; //Anzahl an Leben, sind am Anfang immer 5

  Tutorial tutorial; //Tutorial ausgelagert auf seperate Klasse.

  //Anzahl an Objekten
  int fruits = 0;
  int bombs = 0;
  int smoothies = 0;
  int hearts = 0;
  int ufos = 0;

  int gametime = 0; //Die Spielzeit in Millisekunden

  bool gameover = false;

  //Funktionen, die von dem Ersteller übergeben werden müssen. Dienen als notifies.
  Function updateUFOs; //Folgezustände der UFOs wurden berechnet und können aktualisiert werden
  Function removeUFOView; //UFO existiert nicht mehr im Model und kann entfernt werden.
  Function newUFOView; //UFO wurde erstellt im Model und kann hinzugefügt werden.
  Function gameTutorial; //Ein Tutorial wurde getriggert im Model.

  /**
   * Der Konstruktor. Erwartet einen Highscore und die vier notify-Funktionen.
   * Spielfigur unf UFOFactory wird erstellt.
   */
  Game(this.highscore, this.updateUFOs, this.removeUFOView, this.newUFOView, this.gameTutorial) {
    this.figure = new Figure(0.0, 360.0, 100.0, 100.0, fixedFieldWidth, fixedFieldHeight, 15.0);
    ufoFactory = new UFOFactory(fixedFieldWidth, fixedFieldHeight);
  }

  /**
   * Funktion zum berechnen der Folgezustände.
   * Erwartet ein Integer-Wert als Zeitwert, der die gametime erhöht.
   */
  void checkUFOState(int time) {
    if (!tutorial.movement) { //Prüfen, ob die Steuerung bereits erklärt wurde.
      gameTutorial("Movement", tutorial.getMovementText()); //Controller benachrichtigen
      tutorial.movement = true;
    }
    gametime+= time;
    AbstractUFO ufo; //Der Lesbarkeitshalber wird ein AbstractUFO hier angelegt für die folgende Schleife.
    for (int i = 0 ; i < ufos ; i++) { //Alle UFOs in der ufoList durchgehen.
      ufo = ufoList[i];

      switch(ufo.getClassName()) {  //Switch-Case für die verschiedene UFOs
        case ('Fruit'):
          if (ufo.moving) {  //Bewegt sich das UFO noch?
            ufo.move();
            updateUFOs(ufo);
            if (ufo.hitGround()) { //UFO auf dem Boden gefallen?
              ufo.moving = false;
              if (--attempts <= 0) {
                checkHighscore();
                gameover = true;
                return;
              }
            }
            if (ufo.onDrum(figure)) { //UFO auf der Trommel?
              ufo.goingUp = true;
            }
            if (ufo.landedInBasket()) { //UFO im Korb?
              ufo.moving = false;
              score++;
              checkLevel();
            }
          } else {
            removeUFO(ufoList[i--]);
          }
          break;
        case ('Bomb'):
          if (ufo.moving) { //Bewegt sich das UFO noch?
            ufo.move();
            updateUFOs(ufo); //Controller benachrichtigen
            if (ufo.hitGround()) { //UFO auf dem Boden gefallen?
              ufo.moving = false;
            }
            if (ufo.onDrum(figure)) { //UFO auf der Trommel?
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
          //Cast notwendig, damit auf die Funktionen und Attribute von Smoothie zugegriffen werden kann
          Smoothie smoothie = ufo;
          if (ufo.moving) { //Bewegt sich das UFO noch?
            ufo.move();
            updateUFOs(ufo);
            if (ufo.hitGround()) { //UFO auf dem Boden gefallen?
              removeUFO(ufoList[i--]);
            }
            if (ufo.onDrum(figure)) { //UFO auf der Trommel?
              ufo.moving = false;
              removeUFOView(ufo);
              if (!smoothie.getDope()) { //Prüfen, ob der Effekt der Trommel bereits anhält
                smoothie.drinkSmoothie(10000, gametime, figure);
              } else {
                ufoList.remove(ufo);
                ufos--;
              }
            }
          } else {
            if (smoothie.checkCounter(gametime, figure)) { //Prüfen, ob der Effekt stoppen soll
              ufoList.remove(ufo);
              ufos--;
            }
          }
          break;
        case ('Heart'):
          if (ufo.moving) { //Bewegt sich das UFO noch?
            ufo.move();
            updateUFOs(ufo);
            if (ufo.hitGround()) { //UFO auf dem Boden gefallen?
              ufo.moving = false;
            }
            if (ufo.onDrum(figure)) { //UFO auf der Trommel?
              ufo.moving = false;
              if (attempts < 10) attempts++;
            }
          } else {
            removeUFO(ufoList[i--]);
          }
          break;

      }


    }
  }

  /**
   * Funktion zum Überprüfen, ob neue UFOs geworfen werden müssen/können.
   */
  void checkUFOs() {
    if (actualLevel == null) return; //Wenn es noch kein aktuelles Level gibt, dann soll nichts hier passieren.
    //Prüfen, ob es weniger Früchte gibt, als das Level erlaubt.
    if (fruits < actualLevel.maxFruits) {
      //Die Art der Früchte werden zufällig generiert. possibleFruits gibt an, welche Arten dran kommen dürfen.
      int type = actualLevel.possibleFruits == 1 ? 1 :  new Random().nextInt(actualLevel.possibleFruits)+1;
      //Die Art der Bewegungen werden zufällig generiert. possibleMovements gibt an, welche Arten dran kommen dürfen.
      int movement = actualLevel.possibleMovments == 0 ?  0 : new Random().nextInt(actualLevel.possibleMovments);
      newUFO(ufoFactory.newFruit(type, movement)); //Die Factory soll eine neue Frucht erstellen und zurückgeben.
      fruits++;
      if (fruits == 1 && !tutorial.fruit) { //Prüfen, ob eine Frucht schon erklärt wurde.
        gameTutorial("Banane", tutorial.getBananeText());
        tutorial.fruit = true;
      }
    }
    //Mit Hilfe von chance, kann berechnet werden, ob eine Bombe kommen muss.
    if (chance(actualLevel.bombChance)) { //bombChance ist eine Wahrscheinlichkeit von 0 - 100 %
      newUFO(ufoFactory.newBomb(1, 0, figure.x));
      bombs++;
      if (bombs == 1 && !tutorial.bomb) {
        gameTutorial("Bomb", tutorial.getBombText());
        tutorial.bomb = true;
      }
    }
    //Mit Hilfe von chance, kann berechnet werden, ob ein Smoothie kommen muss.
    if (chance(actualLevel.smoothieChance) && smoothies == 0) {
      newUFO(ufoFactory.newSmoothie(1, 0));
      smoothies++;
      if (smoothies == 1 && !tutorial.smoothie) {
        gameTutorial("Smoothie", tutorial.getSmootheText());
        tutorial.smoothie = true;
      }
    }
    //Mit Hilfe von chance, kann berechnet werden, ob ein Herz kommen muss.
    if (chance(actualLevel.heartChance) && attempts < 10) {
      newUFO(ufoFactory.newHearth(1, 0));
      hearts++;
      if (hearts == 1 && !tutorial.heart) {
        gameTutorial("Heart", tutorial.getHeartText());
        tutorial.heart = true;
      }
    }
  }

  /**
   * Funktion zum Überprüfen des Level und ggf. eine Anpassung des Levels.
   */
  int checkLevel() {
    for (int i = 0 ; i < allLevels.length ; i++) {
      if (allLevels[i].requiredScore == score) {
        actualLevel = allLevels[i];
        break;
      }
    }
    return actualLevel.level;

  }

  /**
   * Hilfs-Funktion zum erstellen eine neues UFOs.
   * Erwartet ein AbstractUFO.
   */
  void newUFO(AbstractUFO ufo) {
    ufoList.add(ufo);
    ufos++;
    newUFOView(ufo); //Controller benachrichtigen
  }

  /**
   * Hilfs-Funktion zum entfernen eines UFOs.
   * Erwartet ein AbstractUFO.
   */
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
      case ("Smoothie") :
        smoothies--;
        break;
      case("Heart") :
        hearts--;
        break;
    }
    //if(fruits+smoothies+hearts+bombs != ufos) print("LOLFEHLER");
    removeUFOView(ufo); //Controller benachrichtigen
  }

  /**
   * Funktion um das Spiel zurückzusetzen.
   */
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


  void checkHighscore() {
    if (score > highscore) {
      highscore = score;
    }
  }

  /**
   * Hilfsfunktion, um ein Ereignis zu via Wahrscheinlichkeit zu triggern.
   * Erwartet einen Wert zwischen 0 und 100 (0-100%)
   */
  bool chance(int percent) {
    return new Random().nextInt(101) < percent;
  }

  void setTutorial(Tutorial t) {
    tutorial = t;
  }

  void setLevels(List<Level> levels) {
    this.allLevels = levels;
  }

}