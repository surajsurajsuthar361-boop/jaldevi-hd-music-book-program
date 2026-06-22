import 'package:cloud_firestore/cloud_firestore.dart';

class Package {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> includedEquipment;
  final List<String> includedStaff;

  Package({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.includedEquipment = const [],
    this.includedStaff = const [],
  });

  // Create a Package from a Firestore document.
  factory Package.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Package(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      includedEquipment: List<String>.from(data['includedEquipment'] ?? []),
      includedStaff: List<String>.from(data['includedStaff'] ?? []),
    );
  }

  // Empty package for initialization
  static Package empty = Package(
    id: '',
    name: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );

  // Copy with new values
  Package copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    List<String>? includedEquipment,
    List<String>? includedStaff,
  }) {
    return Package(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      includedEquipment: includedEquipment ?? this.includedEquipment,
      includedStaff: includedStaff ?? this.includedStaff,
    );
  }
}
