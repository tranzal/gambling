import 'package:flutter/material.dart';
import 'package:gambling/app/provider/abstract/betting_abstract.dart';
import 'package:gambling/app/provider/model/betting.dart';
import 'package:gambling/app/provider/model/user.dart';

class BettingProvider extends ChangeNotifier implements BettingAbstract {
  var bettingList = <Betting>[];
  var bettingDefault = 100;


  @override
  void init({required List<User> userList}) {
    for (var user in userList) {
      bettingList.add(Betting(id: user.id, bettingMoney: bettingDefault));
      user.money -= bettingDefault;
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
    notifyListeners();
  }

  @override
  void die({required int id}) {
    _findData(id: id, function: (index) => bettingList[index].dieCheck());
    notifyListeners();
  }

  void _findData({required int id, required Function(int) function}) {
    for (var index = 0; index < bettingList.length; index++) {
      if (bettingList[index].id == id) {
        function(index);
        break;
      }
    }
  }

  @override
  int totalBetting() {
    var total = 0;
    for (var element in bettingList) {
      total += element.bettingMoney;
    }
    return total;
  }

  @override
  void stop({required List<User> userList}) {
    for (var index = 0 ; index < bettingList.length ; index ++) {
      userList[index].money += bettingList[index].bettingMoney;
    }
    clear();
    notifyListeners();
  }

  @override
  void winner({required List<User> userList, required int id}) {
    _findData(id: id, function: (index) {
      userList[index].money += totalBetting();
    });
    clear();
    notifyListeners();
  }

  @override
  void call({required int id, required List<User> userList}) {
    _findData(id: id, function: (index) {
      bettingList[index].moneyChange(money: bettingDefault);
      userList[index].money -= bettingDefault;
    });
    notifyListeners();
  }

  @override
  void double({required int id, required List<User> userList}) {
    _findData(id: id, function: (index) {
      var double = bettingDefault * 2;
      bettingList[index].moneyChange(money: double);
      userList[index].money -= double;
    });
    notifyListeners();
  }

  @override
  void half({required int id, required List<User> userList}) {
    _findData(id: id, function: (index) {
      var half = bettingDefault ~/ 2 + bettingDefault;
      bettingList[index].moneyChange(money: half);
      userList[index].money -= half;
    });
    notifyListeners();
  }

  @override
  void quarter({required int id, required List<User> userList}) {
    _findData(id: id, function: (index) {
      var quarter = bettingDefault ~/ 4 + bettingDefault;
      bettingList[index].moneyChange(money: quarter);
      userList[index].money -= quarter;
    });
    notifyListeners();
  }

}
