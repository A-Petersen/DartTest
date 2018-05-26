import '../AbstractFruit.dart';

abstract class FruitDecorator extends AbstractFruit{

  AbstractFruit fruit;

  FruitDecorator(this.fruit);
}