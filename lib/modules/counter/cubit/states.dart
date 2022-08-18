abstract class CounterStates {}

class CounterIntialState extends CounterStates{}

class CounterPlusState extends CounterStates{
   int counter;
  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterStates{
   int counter;
  CounterMinusState(this.counter);

}

