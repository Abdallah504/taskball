import 'package:bloc/bloc.dart';
import 'ball_motion_state.dart';

class BallMotionCubit extends Cubit<BallMotionState> {
  BallMotionCubit() : super(BallIdle());

  void moveUp({required double position}) {
    emit(BallMovingUp(position: position));
  }

  void peak({required double position}) {
    emit(BallAtPeak(position: position));
  }

  void moveDown({required double position}) {
    emit(BallMovingDown(position: position));
  }

  void bottom({required double position}) {
    emit(BallAtBottom(position: position));
  }

  void repetitionCompleted({required int completedRepetitions}) {
    emit(BallRepetitionCompleted(completedRepetitions: completedRepetitions));
  }
}
