//User Model
class ProjectModel {
  final String id;
  final String projectLocation;
  final String projectName;
  final String userId;

  factory ProjectModel.fromMap(Map data) {
    return ProjectModel(
      id: data['id'],
      projectLocation: data['projectLocation'] ?? '',
      projectName: data['projectName'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  ProjectModel({
    required this.id,
    required this.projectLocation,
    required this.projectName,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectLocation": projectLocation,
        "projectName": projectName,
        "userId": userId,
      };
}
