import 'package:appverse/domain/entities/json_component.dart';
import 'package:appverse/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class JsonTab extends StatelessWidget {
  final String backgroundColor;
  final List<JsonComponent> components;

  const JsonTab({
    super.key,
    required this.backgroundColor,
    required this.components,
  });

  Color getColorFromHex(String color) => HexColor.fromHex('#$color');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorFromHex(backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: components.length,
          itemBuilder: (context, index) {
            final widget = components[index];
            final params = widget.params;
            return switch (widget.type) {
              WidgetType.text => Text(
                  params.text!,
                  style: TextStyle(
                    fontSize: params.size,
                    color: getColorFromHex(params.color!),
                  ),
                ),
              WidgetType.margin => SizedBox(
                  height: params.paddingH,
                  width: params.paddingV,
                ),
              WidgetType.input => TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: params.inputName),
                ),
              WidgetType.button => TextButton(
                  child: Text(
                    params.text!,
                    style: TextStyle(
                      color: getColorFromHex(params.color!),
                    ),
                  ),
                  onPressed: () {},
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
