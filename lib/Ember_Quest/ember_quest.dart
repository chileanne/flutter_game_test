import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

import 'components/ember_player.dart';
import 'components/water_enemy.dart';
import 'managers/segment_manager.dart';
import 'objects/ground_block.dart';
import 'objects/platform_block.dart';
import 'objects/star.dart';


class EmberQuestGame extends FlameGame {
  late EmberPlayer _ember;
  double objectSpeed = 0.0;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    initializeGame();





  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  void initializeGame() {
    // Assume that size.x < 3200
    print("====> size => ${size.x}==>${(size.x / 640).ceil()}");
    final segmentsToLoad = (size.x / 640).ceil();
    print("-ccc--> ${segmentsToLoad}");
    segmentsToLoad.clamp(0, segments.length);

    print("---> ${segmentsToLoad}");

    for (var i = 0; i <= segmentsToLoad; i++) {
      print("<===$i===>");
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ember = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_ember);
  }


  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      print("block type ==> ${block.blockType}");
      switch (block.blockType) {
        case GroundBlock:
        case PlatformBlock:
        add(PlatformBlock(
          gridPosition: block.gridPosition,
          xOffset: xPositionOffset,
        ));
        case Star:
          world.add(
            Star(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
        case WaterEnemy:
      }
    }
  }
}