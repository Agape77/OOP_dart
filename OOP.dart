import 'dart:io';

//Interface for dart player
abstract class DartPlayer {
  void throwDart();
}

//Parent class for all players
abstract class Player {
  String name;
  Player(this.name);

  //Define throwDart as an abstract method
  void throwDart();
}

//Class for all human player
class HumanPlayer extends Player implements DartPlayer {
  HumanPlayer(String name) : super(name);

  @override 
  void throwDart() {
    print('$name throws the dart!');
  }
}

//Class for computer player
class ComputerPlayer extends Player implements DartPlayer {
  ComputerPlayer(String name) : super(name);

  @override 
  void throwDart() {
    print('$name throws the dart with precision!');
  }
}

//Class to read player data from file
class PlayerDataReader {
  List<Player> readPlayers(String filePath) {
    List<Player> players = [];
    try {
      File file = File(filePath);
      List<String> lines = file.readAsLinesSync();
      for (String line in lines) {
        List<String> parts = line.split(',');
        if (parts.length == 2) {
          String playerName = parts[0].trim();
          String playerType = parts[1].trim();
          if (playerType == 'human') {
            players.add(HumanPlayer(playerName));
          } else if (playerType == 'computer') {
            players.add(ComputerPlayer(playerName));
          }
        }
      }
    } catch (e) {
      print('Error reading file: $e');
    }
    return players;
  }
}

void main() {
  PlayerDataReader reader = PlayerDataReader();
  List<Player> players = reader.readPlayers('players.txt');

  //Demonstrates loop
  for (Player player in players) {
    player.throwDart();
  }
}