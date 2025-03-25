class ResponseFirestore {
  final bool success;
  final String message;
  final String userId;

  ResponseFirestore({
    required this.success,
    required this.message,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    print("$message $success $userId");
    return {
      'success': success,
      'message': message,
      'user': userId,
    };
  }
}
