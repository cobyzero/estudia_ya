import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    // Simulate a delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));
    
    // Here you would normally check for authentication status
    // For now, we'll just emit Loaded/Unauthenticated
    emit(SplashUnauthenticated());
  }
}
