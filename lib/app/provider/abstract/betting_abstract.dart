import 'package:gambling/app/provider/model/betting.dart';
import 'package:gambling/app/provider/model/user.dart';

abstract class BettingAbstract {

  void betting({required int id, required int money, bool? allIn});
  void init({required List<User> userList});
  void clear();
  void bettingDefaultChange({required int bettingCost});
  void die({required int id});
  void findData({required int id, required Function(int) function});
}