import 'package:flutter/material.dart';
import 'package:gambling/app/provider/abstract/betting_abstract.dart';
import 'package:gambling/app/provider/model/betting.dart';
import 'package:gambling/app/provider/model/user.dart';

class BettingProvider extends ChangeNotifier implements BettingAbstract {
  var bettingList = <Betting>[];
  var bettingDefault = 100;

  @override
  void betting({required int id, required int money, bool? allIn}) {
    findData(id: id, function: (index) {
      bettingList[index].moneyChange(money: bettingList[index].bettingMoney + money);
      if(allIn ?? false){
        bettingList[index].allInCheck();
      }
    });
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

  @override
  void bettingDefaultChange({required int bettingCost}) {
    bettingDefault = bettingCost;
    debugPrint(bettingDefault.toString());
    notifyListeners();
  }

  @override
  void die({required int id}) {
    findData(id: id, function: (index) => bettingList[index].dieCheck());
    notifyListeners();
  }

  @override
  void findData({required int id, required Function(int) function}) {
    for (var index = 0; index < bettingList.length; index++) {
      if (bettingList[index].id == id) {
        function(index);
        break;
      }
    }
  }

}
