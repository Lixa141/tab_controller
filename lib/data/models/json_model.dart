import 'package:appverse/data/models/json_component_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_model.g.dart';

@JsonSerializable(createToJson: false)
final class JsonModel {
  @JsonKey(name: 'background_color')
  final String backgroundColor;
  final List<JsonComponentModel> components;

  const JsonModel({
    required this.backgroundColor,
    required this.components,
  });

  factory JsonModel.fromJson(Map<String, dynamic> json) {
    return _$JsonModelFromJson(json);
  }
}
