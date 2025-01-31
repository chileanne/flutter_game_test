import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_test/components/bullet.dart';
import 'package:flutter_game_test/space_shooter.dart';

// class Player extends PositionComponent {
//   static final _paint = Paint()..color = Colors.white;
//
//   @override
//   void render(Canvas canvas) {
//     canvas.drawRect(size.toRect(), _paint);
//   }
//
//   void move(Vector2 delta) {
//     position.add(delta);
//   }
// }

///Sprite Component
// class Player extends SpriteComponent with HasGameRef<SpaceShooterGame>{
//
//    Player():super(
//      size: Vector2(200, 200),
//      anchor: Anchor.center,
//    );
//
//    @override
//    Future<void> onLoad() async {
//      await super.onLoad();
//
//      sprite = await gameRef.loadSprite('ship.png');
//
//      position = gameRef.size / 2;
//
//
//    }
//
//
//   void move(Vector2 delta) {
//     position.add(delta);
//   }
// }

///SpriteANimation Component
// class Player extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame>{
//
//   Player():super(
//     size: Vector2(200, 200),
//     anchor: Anchor.center,
//   );
//
//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//
//
//
//
//     // animation = await game.loadSpriteAnimation(
//     //   'ship.png',
//     //   SpriteAnimationData.sequenced(
//     //     amount: 4, //defines how many frames
//     //     stepTime: .2, //time in seconds for each frame to render
//     //     textureSize: Vector2(32, 48), //the size in pixels which defines each frame of the image.
//     //   ),
//     // );
//
//     position = game.size / 2;
//
//
//   }
//
//
//   void move(Vector2 delta) {
//     position.add(delta);
//   }
// }



///
class Player extends SpriteComponent with HasGameReference<SpaceShooterGame>{
  late final SpawnComponent _bulletSpawner;

   Player():super(
     size: Vector2(100, 100),
     anchor: Anchor.center,
   );

   @override
   Future<void> onLoad() async {
     await super.onLoad();

     sprite = await game.loadSprite('ship.png');

     position = game.size / 2;


     _bulletSpawner = SpawnComponent(
       period: .2,
       selfPositioning: true,
       factory: (index) {
         return Bullet(
           position: position + Vector2(0, -height / 2,),
         );

       },
       autoStart: false,
     );

     game.add(_bulletSpawner);


   }


  void move(Vector2 delta) {
    position.add(delta);
  }


   void startShooting() {
     _bulletSpawner.timer.start();
   }

   void stopShooting() {
     _bulletSpawner.timer.stop();
   }
}