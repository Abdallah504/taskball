import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:taskgame/flappy/game.dart';

import '../constants.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBird> , CollisionCallbacks{
  Ground():super();

  @override
  FutureOr<void> onLoad() async{
    size = Vector2(2*gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y-groundHeight);

    sprite = await Sprite.load('ground.png');

    add(RectangleHitbox());
  }


  @override
 void update(double dt){
    position.x -=groundScrollingSpeed *dt;
    if(position.x + size.x /2 <=0){
      position.x = 0;
    }
  }
}