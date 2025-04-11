class Transaction {
  final String address;
  final String amount;
  final DateTime timestamp;

  Transaction({required this.address, required this.amount})
      : timestamp = DateTime.now();
}
