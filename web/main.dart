import 'controller/Controller.dart';
import 'dart:html';
import 'package:pwa/client.dart' as pwa;

void main() {
  //new pwa.Client();
  int highscore = window.localStorage.containsKey("score") ? int.parse(window.localStorage["score"]) : 0;
  Controller controller = new Controller(highscore);


}




