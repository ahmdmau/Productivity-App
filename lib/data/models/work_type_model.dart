class WorkTypeModel {
  String id;
  String type;

  WorkTypeModel({
    required this.id,
    required this.type,
  });

  factory WorkTypeModel.fromMap(Map data) {
    return WorkTypeModel(
      id: data['id'],
      type: data['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
