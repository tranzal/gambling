import 'package:flutter/material.dart';
import 'package:gambling/app/provider/abstract/participant_abstract.dart';
import 'package:gambling/app/provider/model/user.dart';

class ParticipantProvider extends ChangeNotifier implements ParticipantAbstract {
  var userList = <User>[];

  @override
  void add({required int id, required String userName, required int money}){
    userList.add(User(id: id,userName: userName, money: money));
    notifyListeners();
  }

  @override
  void remove({required int id}){
    findData(id: id, function: (index) => userList.removeAt(index));
    notifyListeners();
  }

  @override
  void changeMoney({required int id, required int money}){
    findData(id: id, function: (index) => userList[index].money = money);
    notifyListeners();
  }

  @override
  void findData({required int id, required Function(int) function}) {
    for (var index = 0 ; index < userList.length ; index ++) {
      if(userList[index].id == id){
        function(index);
        break;
      }
    }
  }

  @override
  int getLastIndex() {
    if(userList.isNotEmpty){
      return  userList[userList.length - 1].id;
    }
    return 0;
  }

  @override
  int getMoney({required int id}) {
    for (var index = 0 ; index < userList.length ; index ++) {
      if(userList[index].id == id){
        return userList[index].money;
      }
    }
    return 0;
  }
}

