import 'package:flutter/material.dart';
import 'package:gambling/app/provider/abstract/betting_abstract.dart';
import 'package:gambling/app/provider/model/betting.dart';
import 'package:gambling/app/provider/model/user.dart';

class BettingProvider extends ChangeNotifier implements BettingAbstract {
 var bettingList = <Betting>[];

  @override
  void betting({required Betting betting}) {
    for (var index = 0 ; index < bettingList.length ; index ++) {
      if(bettingList[index].id == betting.id){
        bettingList[index].bettingMoney = bettingList[index].bettingMoney + betting.bettingMoney;
        break;
      }
    }

    notifyListeners();
  }

  @override
  void init({required List<User> userList}) {
    for (var user in userList) {
      bettingList.add(Betting(id: user.id, bettingMoney: 0));
    }
    notifyListeners();
  }

  @override
  void clear() {
    bettingList.clear();
    notifyListeners();
  }

}