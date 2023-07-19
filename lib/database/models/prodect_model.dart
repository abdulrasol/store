class ProdectModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final String sellUnit;
  final double quantity;
  final String image;
  final String note;
  final double increaseAmount;
  final bool availability;
  final double priority;

  ProdectModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.sellUnit,
    required this.quantity,
    required this.image,
    required this.note,
    required this.increaseAmount,
    required this.availability,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'sellUnit': sellUnit,
      'quantity': quantity,
      'image': image,
      'description': note,
      'increaseAmount': increaseAmount,
      'availability': availability,
      'priority': priority,
    };
  }

  static ProdectModel fromMap(Map<String, dynamic> map) {
    return ProdectModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      category: map['category'],
      sellUnit: map['sellUnit'],
      quantity: map['quantity'],
      image: map['image'],
      note: map['note'],
      increaseAmount: map['increaseAmount'],
      availability: map['availability'],
      priority: map['priority'],
    );
  }
}
