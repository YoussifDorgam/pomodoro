import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/appstate.dart';
import 'package:pomodoro/sharedprefrance/cash_helper.dart';


class PomodoroCubit extends Cubit<AppInitialState> {
  PomodoroCubit() : super(PomodoroInitialStatus());

  static PomodoroCubit get(context) => BlocProvider.of(context);

  final CountDownController clockController = CountDownController();// Initial value
  bool isClockStarted = false;
  double slider = 1.0;



   int? stars  ;
   void starsShared({int? formShared})
   {
     if(formShared != null)
     {
       stars = formShared  ;
      emit(onchangeappmodee());
     }else
     {
       stars = (stars!+ 1);
       cachHelper.SaveData(key: 'star', value: stars).then((value)
       {
         emit(onchangeappmodee());
       });
    }
  }
  int uid = cachHelper.getData('star');



}
