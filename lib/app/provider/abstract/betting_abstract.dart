import 'package:gambling/app/provider/model/betting.dart';
import 'package:gambling/app/provider/model/user.dart';

abstract class BettingAbstract {

  void betting({required Betting betting});
  void init({required List<User> userList});
  void clear();
}