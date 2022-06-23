import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gambling/app/provider/participant.dart';
import 'package:provider/provider.dart';

class ParticipantPage extends StatefulWidget {
  const ParticipantPage({Key? key}) : super(key: key);

  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  late ParticipantProvider _participant;
  final nameFieldText = TextEditingController();
  final moneyFieldText = TextEditingController();
  var name = '';
  var money = 0;
  var id = 0;

  void clearText() {
    nameFieldText.clear();
    moneyFieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    _participant = Provider.of<ParticipantProvider>(context);
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: ListView.builder(
            itemCount: _participant.userList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  name = _participant.userList[index].userName;
                  money = _participant.userList[index].money;
                  id = _participant.userList[index].id;
                  nameFieldText.text = _participant.userList[index].userName;
                  moneyFieldText.text = _participant.userList[index].money.toString();
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Colors.black, width: 1, style: BorderStyle.solid)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_participant.userList[index].userName),
                    Text('금액 : ${_participant.userList[index].money}'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: const InputDecoration(
                          hintText: '이름',
                        ),
                        onChanged: (name) {
                          setState(() {
                            this.name = name;
                          });
                        },
                        controller: nameFieldText,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          hintText: '금액',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (money) {
                          setState(() {
                            this.money = int.parse(money.isEmpty ? '0' : money);
                          });
                        },
                        controller: moneyFieldText,
                      )
                    ],
                  )
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        if(name.isNotEmpty && money != 0) {
                          _participant.add(
                              id: _participant.getLastIndex() + 1,
                              userName: name,
                              money: money);
                          setState(() {
                            name = '';
                            money = 0;
                          });
                          clearText();
                        }
                      },
                      child: const Text('추가')),
                  ElevatedButton(
                      onPressed: () {
                          _participant.remove(id: id);
                          setState(() {
                            name = '';
                            money = 0;
                            id = 0;
                          });
                          clearText();
                      },
                      child: const Text('제거')
                  ),
                ],
              )),
            ],
          ),
        )
      ],
    );
  }
}
