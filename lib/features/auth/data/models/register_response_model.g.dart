// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
  Map<String, dynamic> json,
) => RegisterResponseModel(
  token: json['token'] as String,
  user: User.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RegisterResponseModelToJson(
  RegisterResponseModel instance,
) => <String, dynamic>{'token': instance.token, 'user': instance.user};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  fullName: json['fullName'] as String?,
  email: json['email'] as String,
  role: json['role'] as String,
  isVerified: json['isVerified'] as bool,
  isCompletedProfile: json['isCompletedProfile'] as bool,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'email': instance.email,
  'role': instance.role,
  'isVerified': instance.isVerified,
  'isCompletedProfile': instance.isCompletedProfile,
};
