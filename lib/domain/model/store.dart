import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart'; // toJson 불필요시 삭제

part 'store.freezed.dart';

part 'store.g.dart';

@freezed
class Store with _$Store {
  const factory Store({
    required double lat,
    required double lng,
    required String name,
    @JsonKey(name: 'addr')
    required String address,
    @JsonKey(name: 'remain_stat')
    required String remainStat,
    required double? distance,
  }) = _Store;

  factory Store.fromJson(Map<String, Object?> json) => _$StoreFromJson(json);
}
