import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:taskgame/flappy/components/background.dart';
import 'package:taskgame/flappy/components/bird.dart';
import 'package:taskgame/flappy/components/ground.dart';
import 'package:taskgame/flappy/constants.dart';

class FlappyBird extends FlameGame with TapDetector , HasCollisionDetection{


  late Bird bird;
  late Background background;
  late Ground ground;


  // load every thing in the beginning

@override
  FutureOr<void> onLoad() {


    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);

    ground = Ground();
    add(ground);
  }


  @override
  void onTap() {
    bird.flap();
  }

  // game over

bool isGameOver = false;


void gameOver(){
  if(isGameOver)return;
  isGameOver=true;
  pauseEngine();


  showDialog(context: buildContext!, builder: (context){
    return AlertDialog(
      title: Text('Game Over'),
      actions: [
        TextButton(onPressed: (){

          Navigator.pop(context);
          resetGame();
        }, child: Text('Restart'))
      ],
    );
  });
}

void resetGame(){
  bird.position = Vector2(birdX, birdY);
  bird.velocity = 0;
  isGameOver = false;

  resumeEngine();
}


}