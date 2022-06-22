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
  var name = '';
  var money = 0;

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
                          debugPrint(this.money.toString());
                        },
                      )
                    ],
                  )
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        _participant.add(
                            id: _participant.getLastIndex() + 1,
                            userName: 'dddd',
                            money: 0);
                        setState(() {
                          name = '';
                          money = 0;
                        });
                      },
                      child: const Text('추가')),
                  ElevatedButton(
                      onPressed: () {

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
