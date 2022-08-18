import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
   Color background = Colors.blue,
  double radius = 0.0,
  required Function()function,  //sound null safety
  required String text,
}) => Container(
  width: width,
  decoration:BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background ,
  ) ,
  child: MaterialButton(
    onPressed:function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  Function()? onTapped,
  required  FormFieldValidator<String>validator,
  Function()? suffixPressed ,
}) => TextFormField(
  validator: validator,
  onFieldSubmitted:onSubmit,
  onChanged:onChange,
  onTap:onTapped,
  controller: controller,
  keyboardType:type ,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: IconButton(
      icon:Icon(suffix),
      onPressed: suffixPressed,
    ),
    border: const OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model , context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteDate(id:model['id']);
  },
  child:Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style:const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style:const  TextStyle(
                    color: Colors.grey
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20.0,),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateDate(status: 'done', id:model['id'],);
            },
            icon:const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
        ),
        IconButton(
          onPressed: (){
            AppCubit.get(context).updateDate(status: 'archieved', id:model['id'],);
          },
          icon:const Icon(
            Icons.archive,
            color: Colors.black45,
          ),
        ),
      ],
    ),
  ),
);

Widget tasksBuilder({required List<Map> tasks})=>ConditionalBuilder(
  condition:tasks.isNotEmpty ,
  builder: (context)=> ListView.separated(
      itemBuilder: (context,index) => buildTaskItem(tasks[index],context),
      separatorBuilder: (context,index) => Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
      itemCount:tasks.length
  ),
  fallback: (context)=> Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:const [
        Icon(
          Icons.menu,
          color: Colors.grey,
          size: 100.0,
        ),
        Text(
          'No tasks yet , please add some tasks',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);