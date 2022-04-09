class UserDetail {
  int id;
  String firstName;
  String lastName;
  String position;
  String riskStatus;
  String covidStatus;
  String phoneNumber;
  int dateOfBirth;
  String email;
  int userId;
  int? departmentId;

  UserDetail({
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.position,
      required this.riskStatus,
      required this.covidStatus,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.email,
      required this.userId,
      this.departmentId
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: json['id'],
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      position: json['position'],
      riskStatus: json['riskStatus'],
      covidStatus: json['covidStatus'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      departmentId: json['departmentId'],
      dateOfBirth: json['dateOfBirth'],
    );
  }
}
