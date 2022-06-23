import 'package:flutter/material.dart';
import 'package:gambling/app/provider/model/user.dart';

class ParticipantProvider extends ChangeNotifier {
  var userList = <User>[];

  add({required int id, required String userName, required int money}){
    userList.add(User(id: id,userName: userName, money: money));
    notifyListeners();
  }
  remove({required int id}){
    for (var index = 0 ; index < userList.length ; index ++) {
      if(userList[index].id == id){
        userList.removeAt(index);
        break;
      }
    }
    findData(id: id, function: (index) => userList.removeAt(index));

    notifyListeners();
  }

  changeMoney({required int id, required int money}){
    findData(id: id, function: (index) => userList[index].money = money);
    notifyListeners();
  }

  findData({required int id, required Function(int) function}) {
    for (var index = 0 ; index < userList.length ; index ++) {
      if(userList[index].id == id){
        function(index);
        break;
      }
    }
  }

  int getLastIndex() {
    if(userList.isNotEmpty){
      return  userList[userList.length - 1].id;
    }
    return 0;
  }
}
