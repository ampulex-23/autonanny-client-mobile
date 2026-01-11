import 'package:nanny_core/nanny_core.dart';

class GetUsersData {
  GetUsersData({
    required this.users,
    required this.total,
  });

  final List<UserInfo> users;
  final int total;

  GetUsersData.fromJson(Map<String, dynamic> json)
      : users = List<UserInfo>.from(
          json["users"].map((x) => UserInfo.fromJson(x)),
        ),
        total = json["total"] ?? 0;

  GetUsersData copyWith({
    List<UserInfo>? users,
    int? total,
  }) {
    return GetUsersData(
      users: users ?? this.users,
      total: total ?? this.total,
    );
  }
}
