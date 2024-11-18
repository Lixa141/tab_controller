import 'package:appverse/domain/entities/json_component.dart';

final class Json{
  final String backgroundColor;
  final List<JsonComponent> components;

  const Json({
    required this.backgroundColor,
    required this.components,
  });
}
