import 'package:json_annotation/json_annotation.dart';

class EmptyStringDateTimeConverter extends JsonConverter<DateTime?, String?> {
  const EmptyStringDateTimeConverter();

  @override
  DateTime? fromJson(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }
    return DateTime.parse(jsonString);
  }

  @override
  String? toJson(DateTime? dateTime) => dateTime?.toIso8601String();
}
