

 import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_game_test/space_shooter/components/bullet.dart';
import 'package:flutter_game_test/space_shooter/components/explosion.dart';

import 'package:flutter_game_test/space_shooter/space_shooter.dart';

class Enemy extends SpriteComponent with HasGameReference<SpaceShooterGame>,CollisionCallbacks {
  static const enemySize = 50.0;

  Enemy({
    super.position,
  }) : super(
    size: Vector2.all(enemySize),
    anchor: Anchor.bottomRight,
  );


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite("enemy.png");

    add(RectangleHitbox());


    // animation = await game.loadSpriteAnimation(
    //   'enemy.png',
    //   SpriteAnimationData.sequenced(
    //     amount: 4,
    //     stepTime: .2,
    //     textureSize: Vector2.all(16),
    //   ),
    // );

  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * 250;

    if (position.y > game.size.y) {
      removeFromParent();
    }
  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other,) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();

      ///add explosion to game
      game.add(Explosion(position: position));
    }
  }

 }