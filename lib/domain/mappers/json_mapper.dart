import 'package:appverse/data/models/json_component_model.dart';
import 'package:appverse/data/models/json_component_params_model.dart';
import 'package:appverse/data/models/json_model.dart';
import 'package:appverse/domain/entities/json.dart';
import 'package:appverse/domain/entities/json_component.dart';
import 'package:appverse/domain/entities/json_component_params.dart';

extension JsonMapper on JsonModel {
  Json get toEntity {
    return Json(
      backgroundColor: backgroundColor,
      components: components.toEntities,
    );
  }
}

extension PositionsOrderMapper on List<JsonComponentModel> {
  List<JsonComponent> get toEntities {
    return map((e) => e.toEntity).toList();
  }
}

extension JsonComponentMapper on JsonComponentModel {
  JsonComponent get toEntity {
    return JsonComponent(
      type: WidgetType.from(type),
      params: params.toEntity,
    );
  }
}

extension JsonComponentParamsMapper on JsonComponentParamsModel {
  JsonComponentParams get toEntity {
    return JsonComponentParams(
      size?.toDouble(),
      color,
      text,
      paddingV?.toDouble(),
      paddingH?.toDouble(),
      inputName,
    );
  }
}
