import 'Controller.dart';
import 'dart:async';


void main() {
  print('help');
  Controller controller = new Controller();
  controller.newFruit(0.0, 0.0, 10.0);
  controller.newFruit(0.0, 0.0, 10.0, 5.0, 0.5);
  controller.newFruit(0.0, 0.0, 10.0, 20.0, 2.0);
  //Timer timer = new Timer.periodic(new Duration(milliseconds: 500000), (Timer t) => controller.newFruit(0.0, 295.0, 10.0));
  //controller.start(50, 100.0, -200.0, controller.newFruit(0.0, 295.0, 10.0));

}



