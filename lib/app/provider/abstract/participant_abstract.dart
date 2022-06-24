abstract class ParticipantAbstract {
  void add({required int id, required String userName, required int money});
  void remove({required int id});
  void changeMoney({required int id, required int money});
  void findData({required int id, required Function(int) function});
  int getLastIndex();
  int getMoney({required int id});
}