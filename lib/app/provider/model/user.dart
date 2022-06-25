class User {
  late int _id;
  late String _userName;
  late int _money;

  User({required int id,required String userName, required int money}) {
    _id = id;
    _userName = userName;
    _money = money;
  }

  int getId(){
    return _id;
  }

  int getMoney(){
    return _money;
  }

  String getName(){
    return _userName;
  }

  void moneyChange({required int money}) {
    _money = money;
  }

  void nameChange({required String name}) {
    _userName = name;
  }
}