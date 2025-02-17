import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';

final class DecimalJsonConverter implements JsonConverter<Decimal, double> {
  const DecimalJsonConverter();

  @override
  Decimal fromJson(double json) {
    return Decimal.fromJson(json.toString());
  }

  @override
  double toJson(Decimal object) {
    return double.parse(object.toString());
  }
}
