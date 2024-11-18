import 'package:appverse/data/models/json_component_params_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_component_model.g.dart';

@immutable
@JsonSerializable(createToJson: false)
final class JsonComponentModel {
  final String type;
  final JsonComponentParamsModel params;

  const JsonComponentModel({
    required this.type,
    required this.params,
  });

  factory JsonComponentModel.fromJson(Map<String, dynamic> json) {
    return _$JsonComponentModelFromJson(json);
  }
}
