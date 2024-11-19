class ExpenseModel {
  final int id;
  final String name;
  final double amount;

  ExpenseModel({required this.id, required this.name, required this.amount});

  // Convert ExpenseModel to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }

  // Convert Map to ExpenseModel
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
    );
  }
}
