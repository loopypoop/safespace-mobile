class Indicator {
  int id;
  int userId;
  double temperature;
  int heartRate;
  int upperBloodPressure;
  int lowerBloodPressure;
  double bloodOxygen;
  int checkTime;
  bool isLast;

  Indicator(
      {required this.id,
      required this.userId,
      required this.temperature,
      required this.heartRate,
      required this.upperBloodPressure,
      required this.lowerBloodPressure,
      required this.bloodOxygen,
      required this.checkTime,
      required this.isLast});

  factory Indicator.fromJson(Map<String, dynamic> json) {
    return Indicator(
        id: json['id'],
        userId: json['userId'],
        temperature: json['temperature'],
        heartRate: json['heartRate'],
        upperBloodPressure: json['upperBloodPressure'],
        lowerBloodPressure: json['lowerBloodPressure'],
        bloodOxygen: json['bloodOxygen'],
        checkTime: json['checkTime'],
        isLast: json['isLast']);
  }
}
