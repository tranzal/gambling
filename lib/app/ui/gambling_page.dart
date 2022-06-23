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
  @override
  Widget build(BuildContext context) {
    _participant = Provider.of<ParticipantProvider>(context);
    _betting = Provider.of<BettingProvider>(context);

    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: <Widget>[
              const Expanded(
                child: Text('유저'),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                      ElevatedButton(
                          onPressed: () {

                          },
                          child: const Text('콜')
                      ),
                    ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('하프')
                    ),
                    ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('쿼터')
                    ),
                    ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('따당')
                    ),
                    ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('체크')
                    ),
                    ElevatedButton(
                        onPressed: () {

                        },
                        child: const Text('다이')
                    ),
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
