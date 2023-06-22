import 'package:freezed_annotation/freezed_annotation.dart';

part 'tile_model.freezed.dart';

enum TileType { none, water, ship }

@freezed
class TileModel with _$TileModel {
  const factory TileModel({
    required final TileType initial,
    required final bool revealed,
    required final TileType current,
  }) = _TileModel;
}
