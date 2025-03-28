class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final String icon;
  final PaymentType type;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.type,
  });
}

enum PaymentType { card, eWallet, momo }
