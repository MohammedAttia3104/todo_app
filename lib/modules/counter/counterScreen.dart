// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/counter/cubit/cubit.dart';
import 'package:todo_app/modules/counter/cubit/states.dart';

class counterScreen extends StatelessWidget {
  const counterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                title:const Text(
                  'Counter Screen',
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center ,
                  children: [
                    TextButton(
                      onPressed: ()
                      {
                        CounterCubit.get(context).Minus();
                      },
                      child:const Text(
                        'Minus',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        '${CounterCubit.get(context).counter}',
                        style:const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: ()
                      {
                        CounterCubit.get(context).Plus();
                      },
                      child:const Text(
                        'Plus',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context,state){
            // TEST TYPE
            if(state is CounterPlusState) print('plus state ${state.counter}');
            if(state is CounterMinusState) print('minus state${state.counter}');
          },
      ),

    );
  }
}
