import 'package:flutter/material.dart';

class RecoverWallet extends StatefulWidget {
  const RecoverWallet({super.key});

  @override
  State<RecoverWallet> createState() => _RecoverWalletState();
}

class _RecoverWalletState extends State<RecoverWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Recover wallet'));
  }
}
