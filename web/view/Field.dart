import '../controller/Controller.dart';
import '../model/FruitObject/AbstractUFO.dart';
import '../model/FruitObject/Bomb.dart';
import 'dart:html';
import 'dart:math';
import '../model/FruitObject/Fruit.dart';
import '../model/Figure.dart';

class Field {
  /**
   * Controller wird zur Informationsübertragung benötigt
   */
  Controller controller;

  /**
   * Für die Div-Manipulation der Figur nötig
   */
  final figure = querySelector("#frank");
  /**
   * Für die Div-Manipulation der Score nötig
   */
  final score = querySelector("#score");
  /**
   * Für die Div-Manipulation des Levels nötig
   */
  final level = querySelector("#level");
  /**
   * Für die Div-Manipulation des Korbs nötig
   */
  final korb = querySelector("#korb");
  /**
   * Für die Div-Manipulation der Figur nötig
   */
  final attemps = querySelector("#attemps");
  /**
   * Für den Div-Listener des linken TouchFeldes nötig
   */
  final leftSite = querySelector("#leftSite");
  /**
   * Für den Div-Listener des rechten TouchFeldes nötig
   */
  final rightSite = querySelector("#rightSite");
  /**
   * Für die Div-Manipulation des Startbildschirms nötig
   */
  final startScreen = querySelector("#startScreen");
  /**
   * Für den Div-Listener des StartButton nötig
   */
  final startButtonStartScreen = querySelector("#startButtonStartScreen");
  /**
   * Für den Div-Listener des TutorialToggles nötig
   */
  final tutorialButtonStartScreen = querySelector("#tutorialButtonStartScreen");
  /**
   * Für die Div-Manipulation des Highscores auf dem Startbildschirm nötig
   */
  final highscoreStartScreen = querySelector("#highscoreStartScreen");
  /**
   * Für die Div-Manipulation des Handy Orientierungsoberfläche nötig
   */
  final orientationInfo = querySelector("#orientationInfo");
  /**
   * Für den Div-Listener des StartButton der Handy Orientierungsoberfläche nötig
   */
  final orientationInfoStartButton = querySelector("#startButton");
  /**
   * Für die Div-Manipulation des Tutorialbildschirms nötig
   */
  final tutorialWindow = querySelector("#tutorialWindow");
  /**
   * Für die Div-Manipulation des Highscores auf dem Startbildschirm nötig
   */
  final tutorialMessage = querySelector("#tutorialMessage");

  /**
   * Für den Div-Listener des TutorialButton nötig
   */
  final tutorialButton = querySelector("#tutorialButton");

  /**
   * Für die Div-Manipulation des Beispielbildes auf dem Tutorialbildschirm nötig
   */
  final tutorialPicture = querySelector("#tutorialPicture");
  /**
   * Für die Div-Manipulation des GameOverBildschirms nötig
   */
  final gameoverScreen = querySelector("#gameoverScreen");
  /**
   * Für die Div-Manipulation des Endscores nötig
   */
  final endscore = querySelector("#endscore");
  /**
   * Für die Div-Manipulation des Highscores nötig
   */
  final highscore = querySelector("#highscore");

  /**
   * Für den Div-Listener des ResetButton nötig
   */
  final resetButton = querySelector("#resetButton");
  /**
   * Für die Div-Manipulation des Field nötig
   */
  final fieldQuery = querySelector('#field');

  /**
   * Eine Map die das jeweilige UFO Objekt zu seinem Div-Element enthält
   */
  Map<AbstractUFO, DivElement> ufos = new Map();

  /**
   * Breite der gesamt View
   */
  int get width => window.innerWidth;

  /**
   * Höhe der gesamt View
   */
  int get height => window.innerHeight;

  /**
   * Hilfsvariable für die Bewegungsanimation der Figur
   */
  int figureLook = 0;

  /**
   * Konstruktor des Field
   */
  Field(this.controller) {
  }

  /**
   * Manipuliert die UFO-Elemente des DOM-Tree. Bringt die UFOs auf der View an die richtige Position, die von dem Model berechnet wurde.
   */
  void updateUFOs(AbstractUFO ufo) {
    ufo.update();

    var ufoStyle = querySelector("#" + ufos[ufo].id);

    ufoStyle.style.top = "${getViewPos(false, ufo.heaven)}px";
    ufoStyle.style.left = "${getViewPos(true, ufo.left)}px";
    if(ufo.type != 4) ufoStyle.style.transform = "rotate(${(getViewPos(true, ufo.x.floor()) * 2 + getViewPos(false, ufo.y.floor())) % 360}deg)";
  }

  /**
   * Manipuliert das Div-Element von der Figur auf dem DOM-Tree. Bringt die Figur an die richtige Position, die von dem Model berechnet wurde.
   */
  void updateFigure(Figure f) {
    f.update();

    this.figure.style.left = "${getViewPos(true, f.left)}px";

    if (controller.game.figure.moving == 2) {
      this.figure.style.transform = "scaleX(-1)";
    } else {
      this.figure.style.transform = "scaleX(1)";
    }
    if (controller.game.figure.moving != 0) {
      switch (figureLook) {
        case 10:
          this.figure.style.backgroundImage = "url('resources/frank_mid.png')";
          break;
        case 20:
          this.figure.style.backgroundImage = "url('resources/frank_late.png')";
          break;
        case 30:
          this.figure.style.backgroundImage = "url('resources/frank_mid.png')";
          break;
        case 40:
          this.figure.style.backgroundImage = "url('resources/frank.png')";
          figureLook = -1;
          break;
      }
      figureLook++;
    } else {
      this.figure.style.backgroundImage = "url('resources/frank.png')";
    }
    this.figure.style.backgroundImage = "url('resources/frank.png')";
  }

  /**
   * Erstellt ein neues DivElement und fügt diesen den DOM-Tree hinzu. Außerdem wird der in die Map ufos aufgenommen und gemappt mit dem AbstractUFO, das als Parameter in die Funktion hineingegeben wird
   */
  void createNewUFO(AbstractUFO ufo) {
    final round = "${min(this.width, this.height)}px";

    var ufoDiv = new DivElement();
    ufoDiv.id = 'ufo' + AbstractUFO.getID().toString();

    ufoDiv.style.width = "${getViewPos(true, ufo.width)}px";
    ufoDiv.style.height = "${getViewPos(false, ufo.height)}px";
    ufoDiv.style.borderRadius = round;

    switch (ufo.getClassName()) {
      case 'Fruit':
        {
          switch (ufo.type) {
            case 1:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/bananen.png")';
                ufoDiv.style.backgroundSize = '100% 100%';
                ufoDiv.style.zIndex = '1';
                break;
              }
            case 2:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/birne.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
            case 3:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/apfel.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
            case 4:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/blatt.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
          }
          break;
        }
      case 'Bomb':
        {
          ufoDiv.style.position = 'absolute';
          ufoDiv.style.backgroundImage = 'url("resources/bomb.png")';
          ufoDiv.style.zIndex = '1';
          ufoDiv.style.backgroundSize = '100% 100%';
          break;
        }
      case 'Smoothie':
        {
          ufoDiv.style.height = "${getViewPos(false, ufo.height) * 1.8}px";
          ufoDiv.style.position = 'absolute';
          ufoDiv.style.backgroundImage = 'url("resources/smoothie.png")';
          ufoDiv.style.zIndex = '1';
          ufoDiv.style.backgroundSize = "100% 96%";
          break;
        }
      case 'Heart':
        {
          ufoDiv.style.position = 'absolute';
          ufoDiv.style.backgroundImage = 'url("resources/herts.png")';
          ufoDiv.style.zIndex = '1';
          ufoDiv.style.backgroundSize = '100% 100%';
          break;
        }
    }
    fieldQuery.children.add(ufoDiv);
    ufos[ufo] = ufoDiv;
  }

  /**
   * Entfernt das UFO-DivElement wieder aus dem DOM-Tree
   */
  void removeUFO(AbstractUFO ufo) {
    ufos[ufo].remove();
    ufos.remove(ufo);
  }

  /**
   * Setter des Score Textes
   */
  void setScore(int s) {
    score.text = s.toString();
  }

  /**
   * Setter des Level Textes
   */
  void setLevel(int l) {
    if (l >= 10) level.text = "Level ∞"; else level.text = "Level " + l.toString();
  }

  /**
   * Setter der verbliebenen Versuche Visualisierung
   */
  void setAttempts(int a) {
    attemps.style.width = "${5 * a}%";
    attemps.style.backgroundSize = "${100 / a}% 100%";
  }

  /**
   * Visualisierung des GameOver Screens
   */
  void gameover() {
    attemps.style.visibility = "hidden";
    gameoverScreen.style.visibility = "visible";
    gameoverScreen.style.zIndex = "2";
    ufos.forEach((u, d) => d.remove());
    endscore.text = "Score: " + score.text;
    highscore.text = "Highscore: " + controller.getHighscore().toString();
  }

  /**
   * Reset setzt den DOM-Tree wieder zurück in den Anfangszustand
   */
  void reset() {
    orientationInfoStartButton.text = "Start";
    ufos = new Map();
    gameoverScreen.style.zIndex = "-2";
    gameoverScreen.style.visibility = "hidden";
    score.text = "0";
    attemps.style.visibility = "visible";
  }

  /**
   * Bringt das OrientationInfo-Element in den Vordergrund
   */
  void showOrientationInfo() {
    orientationInfo.style.visibility = "visible";
    orientationInfo.style.zIndex = "2";
  }

  /**
   * Entfernt das OrientationInfo-Element aus dem Vordergrund
   */
  void hideOrientationInfo() {
    orientationInfo.style.visibility = "hidden";
    orientationInfo.style.zIndex = "-2";
  }

  /**
   * Elemente initialisieren oder ändern, wenn das Spiel initialisiert wird.
   */
  void initField() {
    orientationInfoStartButton.text = "Fortfahren";
  }

  /**
   * StartScreen wird initialisiert
   */
  void initStartScreen() {
    highscoreStartScreen.text = "Highscore: " + controller.highscore.toString();
  }

  /**
   * Entfernt den StartScreen, damit das Spielfeld in Vordergrund kommen kann
   */
  void removeStartScreen() {
    startScreen.remove();
  }

  /**
   * Hilfsmethode zur Umrechnung der Position im Game (640x360) auf die Tatsächliche View [width] x [height]
   */
  double getViewPos(bool needXPos, int gamePos) {
    return needXPos
        ? (gamePos / controller.getGameSizeX()) * width
        : (gamePos / controller.getGameSizeY()) * height;
  }

  /**
   * Bringt das Tutorial-Fenster in Vordergrund. Erwartet ein [tutorial], der aussagt, welches Tutorial und eine [message], die die Erklärung für das Tutorial ist
   */
  void showTutorialView(String tutorial, message) {
    tutorialWindow.style.zIndex = "3";
    switch (tutorial) {
      case "Banane": {
        tutorialPicture.style.background = 'url("resources/fruitsTutorial.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Movement": {
        tutorialPicture.style.background = 'url("resources/frank.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Smoothie": {
        tutorialPicture.style.background = 'url("resources/smoothie.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Bomb": {
        tutorialPicture.style.background = 'url("resources/bomb.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Heart": {
        tutorialPicture.style.background = 'url("resources/herts.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
    }
    tutorialWindow.style.visibility = "visible";
    controller.running = false;
  }

  /**
   * – Entfernt das Tutorial-Fenster
   */
  void removeTutorialView() {
    tutorialWindow.style.zIndex = "-1";
    tutorialWindow.style.visibility = "hidden";
    controller.running = true;
  }
}
