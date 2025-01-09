abstract class BallMotionState {}

/// Represents the ball's initial idle state.
class BallIdle extends BallMotionState {}

/// Represents the state when the ball is moving upward.
class BallMovingUp extends BallMotionState {
  final double position;

  BallMovingUp({required this.position});
}

/// Represents the state when the ball is at the peak.
class BallAtPeak extends BallMotionState {
  final double position;

  BallAtPeak({required this.position});
}

/// Represents the state when the ball is moving downward.
class BallMovingDown extends BallMotionState {
  final double position;

  BallMovingDown({required this.position});
}

/// Represents the state when the ball is at the bottom.
class BallAtBottom extends BallMotionState {
  final double position;

  BallAtBottom({required this.position});
}

/// Represents a completed repetition.
class BallRepetitionCompleted extends BallMotionState {
  final int completedRepetitions;

  BallRepetitionCompleted({required this.completedRepetitions});
}
