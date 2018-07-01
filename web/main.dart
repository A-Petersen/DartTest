import 'controller/Controller.dart';
import 'dart:html';

void main() {
  int highscore = window.localStorage.containsKey("score") ? int.parse(window.localStorage["score"]) : 0;
  Controller controller = new Controller(highscore);


}




