import 'package:flutter/material.dart';
import 'package:gambling/app/provider/betting_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var bettingDefault = TextEditingController();
  late BettingProvider _betting;

  @override
  Widget build(BuildContext context) {
    _betting = Provider.of<BettingProvider>(context);
    bettingDefault.text = _betting.bettingDefault.toString();
    return Column(
      children: <Widget>[
        Row(
          children: [
            const Text('최소 배팅액'),
            Flexible(
                child: TextField(
                  controller: bettingDefault,
                  onSubmitted: (changeBettingDefault) {
                    _betting.bettingDefaultChange(bettingCost: int.parse(changeBettingDefault));
                    FocusScope.of(context).unfocus();
                  },
                  keyboardType: TextInputType.number,
                )
            )
          ],
        ),

      ],
    );
  }
}
