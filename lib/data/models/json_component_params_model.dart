import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_component_params_model.g.dart';

@immutable
@JsonSerializable(createToJson: false)
final class JsonComponentParamsModel {
  final int? size;
  final String? color;
  final String? text;
  final int? paddingV;
  final int? paddingH;
  final String? inputName;

  const JsonComponentParamsModel(
    this.size,
    this.color,
    this.text,
    this.paddingV,
    this.paddingH,
    this.inputName,
  );

  factory JsonComponentParamsModel.fromJson(Map<String, dynamic> json) {
    return _$JsonComponentParamsModelFromJson(json);
  }
}
