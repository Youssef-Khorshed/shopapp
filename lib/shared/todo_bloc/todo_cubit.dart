import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/network/local/preferences.dart';
import 'package:shopapp/shared/todo_bloc/todo_status.dart';

class Todo_cubit extends Cubit<Todo_status>
{
  Todo_cubit() : super (Todo_intial_state());
  static Todo_cubit get(context) => BlocProvider.of(context);

  bool id = true;
  void switch_dark_light_mode({bool? getid}) {
    if(getid != null) {id =getid;}
    else {
      print(id);
      id = !id;
      Preference.put(key: 'id', value: id).then((value) {});

    }
    emit(News_Screenmode());
  }

}