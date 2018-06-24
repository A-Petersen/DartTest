class Tutorial {

  bool movement = false;
  bool fruit = false;

  String getBananeText() {
    return "Das ist eine Frucht. In diesem Spiel gibt es verschiedne Früchte und\n" +
           "jede Frucht wird von links geworfen und muss in den Korb an der\n" +
           "rechten Spielfeldseite mit Hilfe von Franks Trommel gebracht werden\n." +
           "Pro erfolgreich transportiere Frucht gibt es 1 Punkt. Fällt eine Frucht auf den Boden,\n" +
           "dann verlierst du ein Leben. Hast du alle Leben verloren, ist das Spiel vorbei.";
  }

  String getMovementText() {
    return "Das ist der gute Frank. Frank will die Früchte die von dem Baum\n" +
        "fallen in seinen Korb rechts an dem rechten Baum bringen. Dazu hat\n" +
        "er seine Trommel, mit der er die Früchte auf die andere Seiten transportieren\n." +
        "kann. Bewegen kann Frank sich durch das tippen auf die linke Seite für eine\n" +
        "Bewegung nach links und und auf das tippen auf die rechte Seite nach rechts.";
  }

  String getBombText() {
    return "Das ist eine Bombe. Wenn Frank von dieser Bombe getroffen wird,\n" +
        "dann verliert ihr ein Leben!";
  }

  String getSmootheText() {
    return "Das ist ein Super-Smoothe. Wenn Frank diesen fängt und trinkt\n" +
        "dann wird Frank schneller!";
  }

  String getHeartText() {
    return "Das ist eine Herz. Wenn Frank dieses Herz einsammelt, dann\n" +
        "bekommt ihr ein Leben dazu. Achtung, es gibt ein Limit von 10 Leben,\n" +
        "die man gleichzeitig besitzen kann";
  }


}