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
              if(_start.start) Container(
                alignment: Alignment.center,
                child: Text('전체 금액 : ${_betting.totalBetting().toString()}'),
              ),
              gameButton(),
              if(_start.start) Container(
                alignment: Alignment.center,
                child: Text('배팅 : ${_betting.getBettingAmount().toString()}'),
              )
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _start.start ? ListView.builder(
                  itemCount: _participant.userList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if(!_betting.bettingList[index].getDie() && !_betting.bettingList[index].getAllIn()) {
                          setState(() {
                            id = _participant.userList[index].getId();
                            money = _participant.userList[index].getMoney();
                            userName = _participant.userList[index].getName();
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: userListColorCheck(index),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.black, width: 1, style: BorderStyle.solid)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(_participant.userList[index].getName()),
                            Text('금액 : ${_participant.userList[index].getMoney()}'),
                          ],
                        ),
                      ),
                    );
                  },
                ) : const Text('시작해 주세요'),
              ) ,
              bettingButton()
            ],
          ),
        ),
      ],
    );
  }

  Color userListColorCheck(int index){

    if(_betting.bettingList[index].getDie()) {
      return Colors.grey;
    }

    if(_betting.bettingList[index].getAllIn()) {
      return Colors.red;
    }

    if(_participant.userList[index].getId() == id) {
      return Colors.yellow;
    }

    if(_betting.bettingList[index].getBetting()) {
      return Colors.blue;
    }
    return Colors.white;
  }

  Widget gameButton(){
    if(!_start.start){
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
              if(id == 0){
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

  Widget bettingButton(){
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          ElevatedButton(onPressed: () {
            if(_participant.getMoney(id: id) == 0){
              return;
            }
            _betting.call(id: id, userList: _participant.userList);

          }, child: const Text('콜')),
          ElevatedButton(onPressed: () {
            if(_participant.getMoney(id: id) == 0){
              return;
            }
            _betting.half(id: id, userList: _participant.userList);
          }, child: const Text('하프')),
          ElevatedButton(onPressed: () {
            if(_participant.getMoney(id: id) == 0){
              return;
            }
            _betting.quarter(id: id, userList: _participant.userList);
          }, child: const Text('쿼터')),
          ElevatedButton(onPressed: () {
            if(_participant.getMoney(id: id) == 0){
              return;
            }
            _betting.double(id: id, userList: _participant.userList);
          }, child: const Text('따당')),
          ElevatedButton(onPressed: () {

          }, child: const Text('체크')),
          ElevatedButton(onPressed: () {
            _betting.die(id: id);
          }, child: const Text('다이')),
        ],
      ),
    );
  }

}


