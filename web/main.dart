import 'controller/Controller.dart';
import 'dart:async';
import 'dart:html';

Controller controller = new Controller();

void main() {
  print('help');
  int ms = 5000;
  Duration duration = new Duration(milliseconds: ms);
  //Timer timer = new Timer.periodic(duration, (Timer t) => danielVersuchtSichAnEinemLevelKonzept());
  controller.newFruit(0.0, 0.0, 10.0, 1);
  //controller.newFruit(0.0, 0.0, 10.0, 2, 5.0, 0.5);
  //controller.newFruit(0.0, 0.0, 10.0, 3, 20.0, 2.0);
  //Timer timer = new Timer.periodic(new Duration(milliseconds: 500000), (Timer t) => controller.newFruit(0.0, 295.0, 10.0));
  //controller.start(50, 100.0, -200.0, controller.newFruit(0.0, 295.0, 10.0));
}

void danielVersuchtSichAnEinemLevelKonzept() {

  if (controller.game.score < 5) {
    controller.newFruit(0.0, 0.0, 10.0, 1);
  }
  if (controller.game.score < 10) {
    controller.newFruit(0.0, 0.0, 10.0, 2, 5.0, 0.5);
  }
  if (controller.game.score < 15) {
    controller.newFruit(0.0, 0.0, 10.0, 3, 20.0, 2.0);
  }

}



