import 'package:json_annotation/json_annotation.dart';

part 'specialty_model.g.dart';
@JsonSerializable()
class SpecialtyModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  SpecialtyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialtyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialtyModelToJson(this);
}

/*
{
    "code": 0,
    "message": "string",
    "data": [
        {
            "id": "string",
            "name": "string",
            "description": "string",
            "imageUrl": "string"
        }
    ]
}
*/