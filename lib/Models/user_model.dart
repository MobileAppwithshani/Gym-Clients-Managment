class UserModel {
  final int? id;
  final String name;
  final String gender;
  final String joining;
  final String closing;
  final int phone;
  final int age;
  final int weight;
  final int height;
  final int fee;

  UserModel({
    this.id,
    required this.name,
    required this.gender,
    required this.joining,
    required this.closing,
    required this.phone,
    required this.age,
    required this.weight,
    required this.height,
    required this.fee,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'joining': joining,
      'closing': closing,
      'phone': phone,
      'age': age,
      'weight': weight,
      'height': height,
      'fee': fee,
    };
  }
}
