import 'package:cloud_firestore/cloud_firestore.dart';

class WorkModel {
  String id;
  String idTypeWork;
  String typeWork;
  String idProject;
  String workName;
  String userId;
  String workLocation;
  Timestamp workDate;
  String startTime;
  String endTime;
  double durationTime;
  int totalWorker;
  double workResult;
  double workProductivity;
  String note;
  int effective;
  int contributory;
  int ineffective;
  double productivityResult;
  String weather;
  Timestamp createdAt;

  WorkModel(
      {required this.id,
      required this.workName,
      required this.workLocation,
      required this.workDate,
      required this.startTime,
      required this.endTime,
      required this.durationTime,
      required this.totalWorker,
      required this.workResult,
      required this.workProductivity,
      required this.note,
      required this.idProject,
      required this.idTypeWork,
      required this.effective,
      required this.contributory,
      required this.ineffective,
      required this.productivityResult,
      required this.weather,
      required this.createdAt,
      required this.userId,
      required this.typeWork})
      : super();

  factory WorkModel.fromMap(Map data) {
    return WorkModel(
      id: data['id'],
      workName: data['workName'],
      workLocation: data['workLocation'],
      workDate: data['workDate'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      durationTime: data['durationTime'],
      totalWorker: data['totalWorker'],
      workResult: data['workResult'],
      workProductivity: data['workProductivity'],
      note: data['note'],
      idProject: data['idProject'],
      idTypeWork: data['idTypeWork'],
      effective: data['effective'],
      contributory: data['contributory'],
      ineffective: data['ineffective'],
      productivityResult: data['productivityResult'],
      weather: data['weather'],
      createdAt: data['createdAt'],
      userId: data['userId'],
      typeWork: data['typeWork'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workName'] = this.workName;
    data['workLocation'] = this.workLocation;
    data['workDate'] = this.workDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['durationTime'] = this.durationTime;
    data['totalWorker'] = this.totalWorker;
    data['workResult'] = this.workResult;
    data['workProductivity'] = this.workProductivity;
    data['note'] = this.note;
    data['idProject'] = this.idProject;
    data['idTypeWork'] = this.idTypeWork;
    data['effective'] = this.effective;
    data['contributory'] = this.contributory;
    data['ineffective'] = this.ineffective;
    data['productivityResult'] = this.productivityResult;
    data['weather'] = this.weather;
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    data['typeWork'] = this.typeWork;
    return data;
  }
}
