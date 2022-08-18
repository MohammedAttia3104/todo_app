import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/archieved/ArchievedTasksScreen.dart';
import '../../modules/done/DoneTaskScreen.dart';
import '../../modules/newTasks/NewTaskScreen.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInsertDatabaseState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late Database database;
  List<Widget> screens =
  [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchievedTaskScreen(),

  ];
  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<Map> newTasks =[];
  List<Map> doneTasks =[];
  List<Map> archivedTasks =[];

  void changeIndex(index)
  {
    currentIndex = index;
    emit(AppChaneBottomNavBarState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheet({required bool isShown ,required IconData icon })
  {
    isBottomSheetShown = isShown;
    fabIcon = icon;
    emit(AppChaneBottomSheetState());
  }
  void createDatabase(){
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  })
  async {
    await database.transaction((txn) =>
        txn.rawInsert('INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")').then((value) {
          print(" $value inserted successfully");
          emit(AppInsertDatabaseState());
          getDataFromDatabase(database);

        }).catchError((error) {
          print('error in insertion is ${error.toString()}');
        }),
    );
  }
  void getDataFromDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element){
        if(element['status']=='new') {
          newTasks.add(element);
        }
        else if(element['status']=='done'){
          doneTasks.add(element);
        }
        else{
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateDate({required String status, required int id})async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status , id]
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseLoadingState());
    });
  }

  void deleteDate({required int id})async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseLoadingState());
    });
  }

}