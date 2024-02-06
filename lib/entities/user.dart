import 'package:json_annotation/json_annotation.dart';
import 'package:movie_backend/models/user.dart';

part 'user.g.dart';

/// user model
@JsonSerializable()
class UserEntity {
  /// user constructor
  const UserEntity({
    required this.email,
    required this.id,
  });

  ///create UserEntity from UserModel
  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      email: model.email,
      id: model.id.oid,
    );
  }

  /// from json
  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  ///id
  final String id;

  ///email of user
  final String email;
}
