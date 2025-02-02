
import 'package:flame/components.dart';
import 'package:flame/flame.dart';


/// helper function to extract a sprite from the common sprite sheet:
Sprite klondikeSprite(double x, double y, double width, double height) {
  return Sprite(
    Flame.images.fromCache('klondike-sprites.png'),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}