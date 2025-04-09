import 'package:flutter/material.dart';

class NewWallet extends StatefulWidget {
  const NewWallet({super.key});

  @override
  State<NewWallet> createState() => NewWalletState();
}

class NewWalletState extends State<NewWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('New wallet'),
    );
  }
}
