import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/ball_motion_cubit.dart';
import '../logic/ball_motion_state.dart';

class BallOnCurveGame extends FlameGame {
  final List<Offset> roadPoints;
  final BallMotionCubit ballMotionCubit;
  final int repetitions;

  double ballPosition = 0.0; // Initial position on the curve
  int currentRep = 0;
  Color ballColor = Colors.red;
  late double timeElapsed;

  BallOnCurveGame({
    required this.roadPoints,
    required this.ballMotionCubit,
    this.repetitions = 3,
  });

  @override
  Future<void> onLoad() async {
    timeElapsed = 0.0;
    ballMotionCubit.emit(BallIdle()); // Set initial state
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeElapsed += dt;

    ballMotionCubit.stream.listen((state) {
      if (state is BallIdle) {
        // Start moving only after 2 reps
        if (currentRep >= 2) {
          ballMotionCubit.moveUp(position: ballPosition);
        }
      } else if (state is BallMovingUp) {
        ballPosition += dt * 50; // Simulated upward motion
        // Ensure ballPosition stays within bounds
        if (ballPosition >= roadPoints.length) {
          ballPosition = roadPoints.length - 1; // Clamp to the last valid index
        }
        if (ballPosition >= roadPoints.length / 2) {
          ballMotionCubit.peak(position: ballPosition);
        }
      } else if (state is BallAtPeak) {
        ballColor = Colors.green;
        Future.delayed(Duration(seconds: 1), () {
          ballMotionCubit.moveDown(position: state.position);
        });
      } else if (state is BallMovingDown) {
        ballPosition -= dt * 50; // Simulated downward motion
        // Ensure ballPosition stays within bounds
        if (ballPosition < 0) {
          ballPosition = 0; // Clamp to the first index
        }
        if (ballPosition <= 0) {
          ballMotionCubit.bottom(position: ballPosition);
        }
      } else if (state is BallAtBottom) {
        ballColor = Colors.red;
        if (currentRep < repetitions) {
          currentRep++;
          ballMotionCubit.moveUp(position: ballPosition);
        } else {
          ballMotionCubit.repetitionCompleted(completedRepetitions: currentRep);
        }
      }
    });
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paintRoad = Paint()..color = Colors.grey; // Road color
    final paintBall = Paint()..color = ballColor;

    final width = size.x;
    final height = size.y;

    // Calculate the offset to center the road
    final offsetX = (width - roadPoints.length * 10.0) / 2;
    final offsetY = (height - roadPoints.map((point) => point.dy).reduce((a, b) => a > b ? a : b)) / 2;

    // Draw the road as a smooth curve (Bezier curve for smoothness)
    final path = Path();
    for (int i = 0; i < roadPoints.length - 1; i++) {
      final p0 = roadPoints[i];
      final p1 = roadPoints[i + 1];

      if (i == 0) {
        path.moveTo(p0.dx + offsetX, p0.dy + offsetY); // Starting point
      } else {
        // Create a quadratic bezier curve for smooth transitions
        path.quadraticBezierTo(
            p0.dx + offsetX, p0.dy + offsetY,   // Control point (p0)
            p1.dx + offsetX, p1.dy + offsetY    // End point (p1)
        );
      }
    }

    canvas.drawPath(path, paintRoad);

    // Clamp ballPosition to be within bounds of roadPoints
    final clampedBallPosition = ballPosition.toInt() % roadPoints.length; // Ensure within range

    // Draw the ball at the new center position
    final ballX = roadPoints[clampedBallPosition].dx + offsetX;
    final ballY = roadPoints[clampedBallPosition].dy + offsetY;
    canvas.drawCircle(Offset(ballX, ballY), 10.0, paintBall);
  }



}


