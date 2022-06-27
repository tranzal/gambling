import 'package:flutter/material.dart';
import 'package:gambling/app/provider/abstract/betting_abstract.dart';
import 'package:gambling/app/provider/model/betting.dart';
import 'package:gambling/app/provider/model/user.dart';

class BettingProvider extends ChangeNotifier implements BettingAbstract {
  var bettingList = <Betting>[];
  var _bettingDefault = 100;
  var _lastBetting = 0;
  var _beforeBetting = 0;
  var _bettingCheck = 0;
  var _raise = false;



  @override
  void init({required List<User> userList}) {
    for (var user in userList) {
      bettingList.add(Betting(id: user.getId(), bettingMoney: _bettingDefault));
      user.moneyChange(money: user.getMoney() - _bettingDefault);
    }
    _lastBetting = _bettingDefault;
    _bettingCheck = _bettingDefault;
    notifyListeners();
  }

  @override
  void clear() {
    bettingList.clear();
    _raise = false;
    _lastBetting = 0;
    _bettingCheck = 0;
    notifyListeners();
  }

  @override
  void bettingDefaultChange({required int bettingCost}) {
    _bettingDefault = bettingCost;
    notifyListeners();
  }

  @override
  void die({required int id}) {
    _findData(id: id, function: (index) => bettingList[index].dieCheck());
    notifyListeners();
  }

  void _findData({required int id, required Function(int) function}) {
    for (var index = 0; index < bettingList.length; index++) {
      if (bettingList[index].getId() == id) {
        function(index);
        break;
      }
    }
  }

  @override
  int totalBetting() {
    var total = 0;
    for (var element in bettingList) {
      total += element.getMoney();
    }
    return total;
  }

  @override
  void stop({required List<User> userList}) {
    for (var index = 0 ; index < bettingList.length ; index ++) {
      userList[index].moneyChange(money: userList[index].getMoney() + bettingList[index].getMoney());
    }
    clear();
    notifyListeners();
  }

  @override
  void winner({required List<User> userList, required int id}) {
    _findData(id: id, function: (index) {
      userList[index].moneyChange(money: userList[index].getMoney() + totalBetting());
    });
    clear();
    notifyListeners();
  }

  @override
  void call({required int id, required List<User> userList}){
    _findData(id: id, function: (index) {
    bettingList[index].moneyChange(money: _lastBetting);
    userList[index].moneyChange(money: userList[index].getMoney() - _lastBetting);
    bettingList[index].bettingCheckChange(check: true);
    });
    notifyListeners();
  }

  @override
  void same({required int id, required List<User> userList}){
    _findData(id: id, function: (index) {
      bettingList[index].moneyChange(money: _lastBetting);
      userList[index].moneyChange(money: userList[index].getMoney() - _lastBetting);
      bettingList[index].bettingCheckChange(check: true);
      _raise = true;
    });
    notifyListeners();
  }

  @override
  void double({required int id, required List<User> userList}) {
    _lastBetting *= 2;
    _bettingProcess(id: id, userList: userList);

    notifyListeners();
  }

  @override
  void half({required int id, required List<User> userList}) {
    _lastBetting = _lastBetting ~/ 2 + _lastBetting;
    _bettingProcess(id: id, userList: userList);
    notifyListeners();
  }

  @override
  void quarter({required int id, required List<User> userList}) {
    _lastBetting = _lastBetting ~/ 4 + _lastBetting;
    _bettingProcess(id: id, userList: userList);
    notifyListeners();
  }

  int getDefaultBetting() {
    return _bettingDefault;
  }

  int getBettingAmount() {
    return _lastBetting;
  }

  void _bettingProcess({required int id, required List<User> userList}){
    _findData(id: id, function: (index) {
      bettingList[index].moneyChange(money: _lastBetting);
      userList[index].moneyChange(money: userList[index].getMoney() - _lastBetting);
      bettingList[index].bettingCheckChange(check: true);
      _raise = true;
    });

    for(var index = 0 ; index < bettingList.length ; index ++) {
      if(bettingList[index].getId() != id){
        bettingList[index].bettingCheckChange(check: false);
      }
    }
  }

  @override
  void next(){
    _bettingCheck = _lastBetting;
    _raise = false;
    for(var betting in bettingList){
      betting.bettingCheckChange(check: false);
    }
  }

  @override
  void allIn({required int id, required List<User> userList}) {
    _findData(id: id, function: (index) {
      bettingList[index].moneyChange(money: userList[index].getMoney());
      userList[index].moneyChange(money: 0);
      bettingList[index].bettingCheckChange(check: true);
      bettingList[index].allInCheck();
    });
  }

  @override
  bool bettingCheck() {
    bool temp = true;
    for(var betting in bettingList) {
      if(!betting.getBetting()) {
       temp = false;
      }
    }
    return temp;
  }

  @override
  bool moreBettingCheck() {
    if(_lastBetting == _bettingCheck) {
      return true;
    }
    return false;
  }

  @override
  void check({required int id, required List<User> userList}) {
    _findData(id: id, function: (index) {
      bettingList[index].bettingCheckChange(check: true);
    });
  }
}
