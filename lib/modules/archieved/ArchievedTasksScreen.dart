import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';

class ArchievedTaskScreen extends StatelessWidget {
  const ArchievedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder:(context , state){
        var tasks = AppCubit.get(context).archivedTasks;
        return tasksBuilder(tasks: tasks);
      },
      listener:(context , state){},
    );
  }
}
