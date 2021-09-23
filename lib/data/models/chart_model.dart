class ChartModel {
  double productivity;
  double count;

  ChartModel({required this.productivity, required this.count});

  factory ChartModel.fromMap(Map data) {
    return ChartModel(
      productivity: data['productivity'],
      count: data['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productivity'] = this.productivity;
    data['count'] = this.count;
    return data;
  }
}
