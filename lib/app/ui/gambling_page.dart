import 'package:flutter/material.dart';
import 'package:gambling/app/provider/betting_provider.dart';
import 'package:gambling/app/provider/participant_provider.dart';
import 'package:provider/provider.dart';

class GamblingPage extends StatefulWidget {
  const GamblingPage({Key? key}) : super(key: key);

  @override
  State<GamblingPage> createState() => _GamblingPageState();
}

class _GamblingPageState extends State<GamblingPage> {
  late ParticipantProvider _participant;
  late BettingProvider _betting;
  var id = 0;
  var money = 0;
  var userName = '';

  @override
  Widget build(BuildContext context) {
    _participant = Provider.of<ParticipantProvider>(context);
    _betting = Provider.of<BettingProvider>(context);

    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(

          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: _participant.userList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          id = _participant.userList[index].id;
                          money = _participant.userList[index].money;
                          userName = _participant.userList[index].userName;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _participant.userList[index].id == id ? Colors.yellow : Colors.white,
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
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    // ElevatedButton(onPressed: () {}, child: const Text('콜')),
                    // ElevatedButton(onPressed: () {}, child: const Text('하프')),
                    // ElevatedButton(onPressed: () {}, child: const Text('쿼터')),
                    // ElevatedButton(onPressed: () {}, child: const Text('따당')),
                    // ElevatedButton(onPressed: () {}, child: const Text('체크')),
                    // ElevatedButton(onPressed: () {}, child: const Text('다이')),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
