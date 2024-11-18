import 'package:appverse/domain/entities/json_component_params.dart';

enum WidgetType {
  text('textView'),
  margin('margin'),
  input('input'),
  button('nextButton'),
  unidentified('');

  const WidgetType(this.value);

  final String value;

  factory WidgetType.from(String? name) {
    return WidgetType.values.firstWhere(
      (e) => e.value == name,
      orElse: () => WidgetType.unidentified,
    );
  }
}

class JsonComponent {
  final WidgetType type;
  final JsonComponentParams params;

  const JsonComponent({
    required this.type,
    required this.params,
  });
}
