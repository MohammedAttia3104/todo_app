
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterIntialState());

  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;

  void Minus()
  {
    counter--;
    emit(CounterMinusState(counter));
  }
  void Plus()
  {
    counter++;
    emit(CounterPlusState(counter));

  }


}