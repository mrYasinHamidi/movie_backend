import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'user.g.dart';

/// user model
@JsonSerializable()
class UserModel extends Equatable {
  /// user constructor
  const UserModel({
    required this.email,
    required this.password,
    required this.id,
  });

  /// from json
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// to json
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  ///id
  @JsonKey(name: '_id')
  @ObjectIdConvertor()
  final ObjectId id;

  ///email of user
  final String email;

  ///password user account
  final String password;

  @override
  List<Object?> get props => [
        id,
        email,
        password,
      ];
}

///converter
class ObjectIdConvertor implements JsonConverter<ObjectId, ObjectId> {
  ///constructor
  const ObjectIdConvertor();

  @override
  ObjectId fromJson(ObjectId json) {
    return json;
  }

  @override
  ObjectId toJson(ObjectId object) {
    return object;
  }
}
