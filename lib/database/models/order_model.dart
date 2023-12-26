class OrderModel {
  final String id;
  final List items;
  final String timestamp;
  final double price;
  final double discount;
  final String state;
  final Map address;

  OrderModel({
    required this.id,
    required this.items,
    required this.timestamp,
    required this.price,
    required this.discount,
    required this.state,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items,
      'timestamp': timestamp,
      'price': price,
      'state': state,
      'address': address,
      'discount': discount,
    };
  }

  static OrderModel fromMap(Map<String, dynamic> map) {
    return OrderModel(
        id: map['id'],
        items: map['items'],
        timestamp: map['timestamp'],
        discount: map['discount'],
        price: map['price'],
        state: map['state'],
        address: map['address']);
  }
}
