
class User {
  final String idUser;
  final String name;
  final String urlAvatar;

  User({
    required this.idUser,
    required this.name,
    required this.urlAvatar,
  });
  User copyWith({
    required String idUser,
    required String name,
    required String urlAvatar,
    required DateTime lastMessageTime,
  }) =>
      User(idUser: idUser, name: name, urlAvatar: urlAvatar);

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['idUser'],
        name: json['name'],
        urlAvatar: json['urlAvatar'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'idUser': idUser,
        'urlAvatar': urlAvatar,
      };
}
