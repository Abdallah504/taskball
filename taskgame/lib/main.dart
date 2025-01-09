import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskgame/flappy/game.dart';
import 'ball/componenets/ball-on-curve.dart';
import 'ball/logic/ball_motion_cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BallMotionCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:GameWidget(game: FlappyBird())
      ),
    );
  }
}

class BallGameScreen extends StatefulWidget {
  const BallGameScreen({super.key});

  @override
  State<BallGameScreen> createState() => _BallGameScreenState();
}

class _BallGameScreenState extends State<BallGameScreen> {
  @override
  Widget build(BuildContext context) {
    final ballMotionCubit = context.read<BallMotionCubit>();

    // Updated curvePoints to List<double>
    final roadPoints = [
      Offset(0.0, 100.0),    // Starting point
      Offset(50.0, 150.0),   // Slight curve up
      Offset(100.0, 100.0),  // Curving back down
      Offset(150.0, 150.0),  // Another upward curve
      Offset(200.0, 100.0),  // Downward again
      // Offset(250.0, 150.0),  // Curve up
      // Offset(300.0, 100.0),  // Continue down
      // Offset(350.0, 150.0),  // Up
      // Offset(400.0, 100.0),  // Down
    ];

    const repetitions = 3;

    return Scaffold(
      appBar: AppBar(title: const Text("Ball on Curve")),
      body: Center(
        child: Stack(
          children: [
            // Wrap BallOnCurveGame with GameWidget
            GameWidget(

              game: BallOnCurveGame(
                roadPoints: roadPoints,
                ballMotionCubit: ballMotionCubit,
                repetitions: repetitions,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  ballMotionCubit.moveUp(position: 0.0); // Start with initial position
                },
                child: const Text("Start"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



