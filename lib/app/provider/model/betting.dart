class Betting{
  late int id;
  late int bettingMoney;
  bool allIn = false;
  bool die = false;


  Betting({required this.id, required this.bettingMoney});

  void allInCheck() {
    allIn = true;
  }
  void dieCheck(){
    die = true;
  }
  void moneyChange({required int money}) {
    bettingMoney = money;
  }
}