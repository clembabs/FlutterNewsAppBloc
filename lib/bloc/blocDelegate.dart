import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

@override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }
  
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}