import 'Controller.dart';
import 'dart:async';


void main() {

  Controller controller = new Controller();

  Timer timer = new Timer.periodic(new Duration(milliseconds: 5000), (Timer t) => controller.newFruit(0.0, 295.0, 10.0));
  //controller.start(50, 100.0, -200.0, controller.newFruit(0.0, 295.0, 10.0));

}



