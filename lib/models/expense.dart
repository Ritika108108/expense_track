class Expense {
  int? id; // Optional field, can be null if not persisted yet
  String category;
  double amount;
  String comments;
  DateTime createdAt;
  DateTime updatedAt;

  Expense({
    this.id, // Nullable, will be set by the database or when editing
    required this.category,
    required this.amount,
    this.comments = '',
  })  : createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  // Convert an Expense object to a Map (used for saving to database)
  Map<String, dynamic> toMap() {
    return {
      'id': id, // This allows the database to assign a unique id if necessary
      'category': category,
      'amount': amount,
      'comments': comments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Convert a Map to an Expense object (used for loading from database)
  static Expense fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      category: map['category'],
      amount: map['amount'],
      comments: map['comments'] ?? '', // Handle null comments
    )
      ..createdAt = DateTime.parse(map['createdAt'])
      ..updatedAt = DateTime.parse(map['updatedAt']);
  }
}
