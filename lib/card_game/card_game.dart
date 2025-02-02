
 import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'compnents/foundation.dart';
import 'compnents/pile.dart';
import 'compnents/stock_components.dart';
import 'compnents/waste.dart';
import 'constants/constants.dart';

class CardGame extends FlameGame {

  @override
  Future<void> onLoad() async {
    await Flame.images.load('klondike-sprites.png');

    final stock = Stock()
      ..size = cardSize
      ..position = Vector2(cardGap, cardGap);


    final waste = Waste()
      ..size = cardSize
      ..position = Vector2(cardWidth + 2 * cardGap, cardGap);


    final foundations = List.generate(
      4,
          (i) => Foundation()
        ..size = cardSize
        ..position =
        Vector2((i + 3) * (cardWidth + cardGap) + cardGap, cardGap),
    );


    final piles = List.generate(
      7,
          (i) => Pile()
        ..size = cardSize
        ..position = Vector2(
          cardGap + i * (cardWidth + cardGap),
          cardHeight + 2 * cardGap,
        ),
    );




    add(stock);
    add(waste);
    addAll(foundations);
    addAll(piles);


    camera.viewfinder.visibleGameSize =
        Vector2(cardWidth * 7 + cardGap * 8, 4 * cardHeight + 3 * cardGap);
    camera.viewfinder.position = Vector2(cardWidth * 3.5 + cardGap * 4, 0);
    camera.viewfinder.anchor = Anchor.topCenter;

  }
}