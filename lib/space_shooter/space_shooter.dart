





import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flame/experimental.dart';
import 'package:flutter_game_test/space_shooter/components/enemy.dart';
import 'package:flutter_game_test/space_shooter/components/player.dart';


///A hitbox is nothing more than a defined part of the component’s area that can hit other objects.
/// Usually it is smart to mark hitboxes from components that will have a higher number of instances as passive, so they will be taken into account for collision, but they themselves will not check their own collisions,
/// drastically reducing the number of checking, giving a better performance to the game!
/// And since in this game we anticipate that there will be more bullets than enemies, we set the bullets to have a passive collision type!


class SpaceShooterGame extends FlameGame  with PanDetector,  HasCollisionDetection {
  late Player player;


   @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
     await super.onLoad();

     player =Player();

     add(player);



     ///add enemy
     add(
       SpawnComponent(
         factory: (index) {
           return Enemy();
         },
         period: 1,
         area:Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),

       ),
     );





  }


   @override
  void onPanUpdate(DragUpdateInfo info) {
    // TODO: implement onPanUpdate
    super.onPanUpdate(info);
    
    player.move(info.delta.global);
    // print(info.delta.global);
    // print(info.eventPosition);
  }


  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }

}
