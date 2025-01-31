


import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_test/space_shooter.dart';

class Bullet extends SpriteComponent with HasGameReference<SpaceShooterGame> {
  Bullet({
    super.position,
  }) : super(
    size: Vector2(25, 50),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite("bullet.png");

    ///A hitbox is nothing more than a defined part of the component’s area that can hit other objects.
    /// Usually it is smart to mark hitboxes from components that will have a
    /// higher number of instances as passive, so they will be taken into account for collision,
    /// but they themselves will not check their own collisions,
    /// drastically reducing the number of checking, giving a better performance to the game!
    /// And since in this game we anticipate that there will be more bullets than enemies,
    /// we set the bullets to have a passive collision type!


    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );

    // animation = await game.loadSpriteAnimation(
    //   'bullet.png',
    //   SpriteAnimationData.sequenced(
    //     amount: 4,
    //     stepTime: .2,
    //     textureSize: Vector2(8, 16),
    //   ),
    // );
  }


  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -500;

    print("position of y ====> ${position.y}");

    if (position.y < -height) {
      removeFromParent();
    }
  }
}