class Cat {
  final int id;
  final String name;
  final String origin;
  final String temperament;
  final List<String> colors;
  final String description;
  final String image;

  Cat({
    required this.id,
    required this.name,
    required this.origin,
    required this.temperament,
    required this.colors,
    required this.description,
    required this.image,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      name: json['name'],
      origin: json['origin'],
      temperament: json['temperament'],
      colors: List<String>.from(json['colors']),
      description: json['description'],
      image: json['image'],
    );
  }
}