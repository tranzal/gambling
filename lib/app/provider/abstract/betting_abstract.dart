import 'package:gambling/app/provider/model/betting.dart';
import 'package:gambling/app/provider/model/user.dart';

abstract class BettingAbstract {

  void call({required int id, required List<User> userList});
  void half({required int id, required List<User> userList});
  void quarter({required int id, required List<User> userList});
  void double({required int id, required List<User> userList});
  void check({required int id, required List<User> userList});
  void same({required int id, required List<User> userList});
  void init({required List<User> userList});
  void clear();
  void bettingDefaultChange({required int bettingCost});
  void die({required int id});
  int totalBetting();
  void stop({required List<User> userList});
  void winner({required List<User> userList, required int id});
  void next();
  void allIn({required int id, required List<User> userList});
  bool bettingCheck();
  bool moreBettingCheck();
}