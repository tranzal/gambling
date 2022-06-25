import 'package:flutter/material.dart';
import 'package:gambling/app/provider/betting_provider.dart';
import 'package:gambling/app/provider/participant_provider.dart';
import 'package:gambling/app/provider/start_provider.dart';
import 'package:provider/provider.dart';

class GamblingPage extends StatefulWidget {
  const GamblingPage({Key? key}) : super(key: key);

  @override
  State<GamblingPage> createState() => _GamblingPageState();
}

class _GamblingPageState extends State<GamblingPage> {
  late ParticipantProvider _participant;
  late BettingProvider _betting;
  late StartProvider _start;
  var id = 0;
  var money = 0;
  var userName = '';

  @override
  Widget build(BuildContext context) {
    _participant = Provider.of<ParticipantProvider>(context);
    _betting = Provider.of<BettingProvider>(context);
    _start = Provider.of<StartProvider>(context);

    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('이름 : $userName'),
              Expanded(
                  child: Column(
                children: <Widget>[
                  if (_start.start)
                    Container(
                      alignment: Alignment.center,
                      child:
                          Text('전체 금액 : ${_betting.totalBetting().toString()}'),
                    ),
                  gameButton(),
                  if (_start.start)
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                          '배팅 : ${_betting.getBettingAmount().toString()}'),
                    ),
                ],
              )),
              if (_betting.bettingCheck())
                ElevatedButton(
                    onPressed: () {
                      _betting.next();
                      stateReset();
                    },
                    child: const Text('다음'))
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _start.start
                    ? ListView.builder(
                        itemCount: _participant.userList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (!_betting.bettingList[index].getDie() &&
                                  !_betting.bettingList[index].getAllIn() &&
                                  !_betting.bettingList[index].getBetting()) {
                                setState(() {
                                  id = _participant.userList[index].getId();
                                  money =
                                      _participant.userList[index].getMoney();
                                  userName =
                                      _participant.userList[index].getName();
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: userListColorCheck(index),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_participant.userList[index].getName()),
                                  Text(
                                      '금액 : ${_participant.userList[index].getMoney()}'),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Text('시작해 주세요'),
              ),
              bettingButton()
            ],
          ),
        ),
      ],
    );
  }

  Color userListColorCheck(int index) {
    if (_betting.bettingList[index].getDie()) {
      return Colors.grey;
    }

    if (_betting.bettingList[index].getAllIn()) {
      return Colors.red;
    }

    if (_participant.userList[index].getId() == id) {
      return Colors.yellow;
    }

    if (_betting.bettingList[index].getBetting()) {
      return Colors.blue;
    }
    return Colors.white;
  }

  Widget gameButton() {
    if (!_start.start) {
      return ElevatedButton(
        onPressed: () {
          _betting.init(userList: _participant.userList);
          _start.changeStart();
        },
        child: const Text('시작'),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              if (id == 0) {
                return;
              }
              _betting.winner(userList: _participant.userList, id: id);
              _start.changeStart();
              setState(() {
                id = 0;
                money = 0;
                userName = '';
              });
            },
            child: const Text('승리'),
          ),
          ElevatedButton(
            onPressed: () {
              _betting.stop(userList: _participant.userList);
              _start.changeStart();
              setState(() {
                id = 0;
                money = 0;
                userName = '';
              });
            },
            child: const Text('중지'),
          )
        ],
      );
    }
  }

  Widget bettingButton() {
    if ((_betting.getBettingAmount() >= _participant.getMoney(id: id)) &&
        id != 0 &&
        !_betting.moreBettingCheck()) {
      return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            ElevatedButton(
                onPressed: () {
                  _betting.allIn(id: id, userList: _participant.userList);
                  stateReset();
                },
                child: const Text('올인')),
            ElevatedButton(
                onPressed: () {
                  _betting.die(id: id);
                  stateReset();
                },
                child: const Text('다이')),
          ],
        ),
      );
    }

    if(_betting.getBettingAmount() >= _participant.getMoney(id: id)){

    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          bettingButtonUtil('콜', _betting.moreBettingCheck() ? Colors.grey : Colors.blue, () {
            if (_participant.getMoney(id: id) == 0) {
              return;
            }
            if (_betting.moreBettingCheck()) {
              return;
            }
            _betting.call(id: id, userList: _participant.userList);
            stateReset();
          }),
          bettingButtonUtil('하프', Colors.blue, () {
            if (_participant.getMoney(id: id) == 0) {
              return;
            }
            _betting.half(id: id, userList: _participant.userList);
            stateReset();
          }),
          bettingButtonUtil('쿼터', Colors.blue, () {
            if (_participant.getMoney(id: id) == 0) {
              return;
            }
            _betting.quarter(id: id, userList: _participant.userList);
            stateReset();
          }),
          bettingButtonUtil('따당', Colors.blue, () {
            if (_participant.getMoney(id: id) == 0) {
              return;
            }
            _betting.double(id: id, userList: _participant.userList);
            stateReset();
          }),
          bettingButtonUtil('체크', !_betting.moreBettingCheck() ? Colors.grey : Colors.blue, () {
            if (!_betting.moreBettingCheck()) {
              return;
            }
            _betting.check(id: id, userList: _participant.userList);
            stateReset();
          }),
          bettingButtonUtil('다이', Colors.blue, () {
            _betting.die(id: id);
            stateReset();
          })
        ],
      ),
    );
  }

  Widget bettingButtonUtil(String text, Color? color, Function function) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
        onPressed: () {
          function();
        },
        child: Text(text));
  }

  void stateReset() {
    setState(() {
      id = 0;
      money = 0;
      userName = '';
    });
  }
}
