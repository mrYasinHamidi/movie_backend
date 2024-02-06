// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      password: json['password'] as String,
      id: const ObjectIdConvertor().fromJson(json['_id'] as ObjectId),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': const ObjectIdConvertor().toJson(instance.id),
      'email': instance.email,
      'password': instance.password,
    };
