class Betting{
  late int _id;
  late int _bettingMoney;
  bool _allIn = false;
  bool _die = false;
  bool _betting = false;
  int _bettingTime = 0;

  Betting({required int id, required int bettingMoney}) {
    _id = id;
    _bettingMoney = bettingMoney;
  }

  void allInCheck() {
    _allIn = true;
  }
  void dieCheck(){
    _die = true;
  }
  void moneyChange({required int money}) {
    _bettingMoney += money;
  }

  void bettingCheckChange({required bool check}) {
    _betting = check;
  }

  bool getAllIn() {
    return _allIn;
  }

  bool getDie() {
    return _die;
  }

  int getMoney() {
    return _bettingMoney;
  }

  bool getBetting(){
    return _betting;
  }

  int getId() {
    return _id;
  }

  int getBettingTime(){
    return _bettingTime;
  }
  void bettingTimeAdd({required int time}) {
    _bettingTime = time;
  }
  void bettingTimeClear() {
    _bettingTime = 0;
  }
}