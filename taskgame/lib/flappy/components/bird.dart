import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:taskgame/flappy/components/ground.dart';
import 'package:taskgame/flappy/constants.dart';
import 'package:taskgame/flappy/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  Bird() : super(position: Vector2(birdX, birdY), size: Vector2(birdSizeWidth, birdSizeHieght));

  // Physical properties
  double velocity = 0;

  // Sprites for different heights
  late Sprite normalSprite;
  late Sprite highSprite;

  // Threshold heights for sprite changes
  final double highHeightThreshold = 200; // Adjust as needed
  final double lowHeightThreshold = 200; // Adjust as needed

  @override
  FutureOr<void> onLoad() async {
    normalSprite = await Sprite.load('redball.png'); // Normal bird image
    highSprite = await Sprite.load('greenball.jpg'); // Bird image for high altitude
    sprite = normalSprite; // Start with the normal sprite

    add(RectangleHitbox());
  }

  // Bird jump
  void flap() {
    velocity = jumpStrength;
  }

  // Update every frame
  @override
  void update(double dt) {
    velocity += gravity;

    position.y += velocity * dt;

    // Change sprite based on height
    if (position.y < highHeightThreshold && sprite != highSprite) {
      sprite = highSprite;
    } else if (position.y >= lowHeightThreshold && sprite != normalSprite) {
      sprite = normalSprite;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ground) {
      (parent as FlappyBird).gameOver();
    }
  }
}
