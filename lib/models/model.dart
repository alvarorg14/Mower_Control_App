class Model {
  final String modelId;
  final String name;

  Model({
    required this.modelId,
    required this.name,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      modelId: json['modelId'],
      name: json['name'],
    );
  }
}
