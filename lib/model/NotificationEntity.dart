class NotificationEntity {
  int id;
  DateTime createdAt;
  bool isSeen;
  String topic;
  String content;
  int userId;

  NotificationEntity(
      {required this.id,
        required this.createdAt,
        required this.isSeen,
        required this.topic,
        required this.content,
        required this.userId,
        });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt']),
        isSeen: json['seen'],
        topic: json['topic'],
        content: json['content'],
        userId: json['userId']
    );
  }
}
