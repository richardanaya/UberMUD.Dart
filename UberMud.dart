#import('dart:html');
#import("dart:json");

class World {
  Room startingRoom = null;
  List<Room> rooms = null;
  List<Player> players = null;
  World() {
    rooms = new List<Room>();
    players = new List<Player>();
  }
  
  addPlayerToWorld(Player p) {
    players.add(p);
    p.room = startingRoom;
  }
  
  processCommand(String command) {
    window.alert(command);
  }
}

class Room {
  String description = "This is a room";
  Room north = null;
  Room south = null;
  Room east = null;
  Room west = null;
  Room(this.description);
  Room.fromJson(json) {
    LinkedHashMap obj = JSON.parse(json);
    description = obj['description'];
  }
}

class Player {
  String name = "";
  Room room = null;
  Player(this.name);
}


class UberMud {
  Player player = null;
  World world = null;
  
  UberMud() {
    world = new World();
    Room room = new Room.fromJson('{"description":"blah"}');
    world.startingRoom = room;
    world.rooms.add(room);
    
    player = new Player("Richard");
    world.addPlayerToWorld(player);
  }

  void run() {
    write(player.room.description);
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#textArea').innerHTML = message;
    var context = this;
    document.query('#inputArea').on.keyDown.add((e) => context.handleKeyDown(e));
  }
  
  void handleKeyDown(KeyboardEvent e) {
    if(e.keyCode == 13) {
      window.alert(document.query('#inputArea').value);
    }
  }
}

void main() {
  new UberMud().run();
}
