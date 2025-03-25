class Profile {
  final String id;
  final String name;
  final String password;
  final String content;

  Profile({
    required this.id,
    required this.name,
    required this.password,
    required this.content,
  });

  factory Profile.fromMap(Map<String, dynamic> data) {
    return Profile(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      password: data['password'] ?? '',
      content: data['content'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'content': content,
    };
  }

  factory Profile.empty() {
    return Profile(
      id: '',
      name: '',
      password: '',
      content: '',
    );
  }
}
