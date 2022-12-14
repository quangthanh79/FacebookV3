// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'no_thing.g.dart';

@JsonSerializable()
class NoThing {
  final dynamic nothing;
  NoThing({
    this.nothing,
  });
  factory NoThing.fromJson(Map<String, dynamic> json) =>
      _$NoThingFromJson(json);
  Map<String, dynamic> toJson() => _$NoThingToJson(this);
}
