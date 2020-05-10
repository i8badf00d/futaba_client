// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'catalog_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$CatalogStateTearOff {
  const _$CatalogStateTearOff();

  _CatalogState call(
      {CatalogSortType sortType, int columnCount, List<Thread> threads}) {
    return _CatalogState(
      sortType: sortType,
      columnCount: columnCount,
      threads: threads,
    );
  }
}

// ignore: unused_element
const $CatalogState = _$CatalogStateTearOff();

mixin _$CatalogState {
  CatalogSortType get sortType;
  int get columnCount;
  List<Thread> get threads;

  $CatalogStateCopyWith<CatalogState> get copyWith;
}

abstract class $CatalogStateCopyWith<$Res> {
  factory $CatalogStateCopyWith(
          CatalogState value, $Res Function(CatalogState) then) =
      _$CatalogStateCopyWithImpl<$Res>;
  $Res call({CatalogSortType sortType, int columnCount, List<Thread> threads});
}

class _$CatalogStateCopyWithImpl<$Res> implements $CatalogStateCopyWith<$Res> {
  _$CatalogStateCopyWithImpl(this._value, this._then);

  final CatalogState _value;
  // ignore: unused_field
  final $Res Function(CatalogState) _then;

  @override
  $Res call({
    Object sortType = freezed,
    Object columnCount = freezed,
    Object threads = freezed,
  }) {
    return _then(_value.copyWith(
      sortType:
          sortType == freezed ? _value.sortType : sortType as CatalogSortType,
      columnCount:
          columnCount == freezed ? _value.columnCount : columnCount as int,
      threads: threads == freezed ? _value.threads : threads as List<Thread>,
    ));
  }
}

abstract class _$CatalogStateCopyWith<$Res>
    implements $CatalogStateCopyWith<$Res> {
  factory _$CatalogStateCopyWith(
          _CatalogState value, $Res Function(_CatalogState) then) =
      __$CatalogStateCopyWithImpl<$Res>;
  @override
  $Res call({CatalogSortType sortType, int columnCount, List<Thread> threads});
}

class __$CatalogStateCopyWithImpl<$Res> extends _$CatalogStateCopyWithImpl<$Res>
    implements _$CatalogStateCopyWith<$Res> {
  __$CatalogStateCopyWithImpl(
      _CatalogState _value, $Res Function(_CatalogState) _then)
      : super(_value, (v) => _then(v as _CatalogState));

  @override
  _CatalogState get _value => super._value as _CatalogState;

  @override
  $Res call({
    Object sortType = freezed,
    Object columnCount = freezed,
    Object threads = freezed,
  }) {
    return _then(_CatalogState(
      sortType:
          sortType == freezed ? _value.sortType : sortType as CatalogSortType,
      columnCount:
          columnCount == freezed ? _value.columnCount : columnCount as int,
      threads: threads == freezed ? _value.threads : threads as List<Thread>,
    ));
  }
}

class _$_CatalogState implements _CatalogState {
  _$_CatalogState({this.sortType, this.columnCount, this.threads});

  @override
  final CatalogSortType sortType;
  @override
  final int columnCount;
  @override
  final List<Thread> threads;

  @override
  String toString() {
    return 'CatalogState(sortType: $sortType, columnCount: $columnCount, threads: $threads)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CatalogState &&
            (identical(other.sortType, sortType) ||
                const DeepCollectionEquality()
                    .equals(other.sortType, sortType)) &&
            (identical(other.columnCount, columnCount) ||
                const DeepCollectionEquality()
                    .equals(other.columnCount, columnCount)) &&
            (identical(other.threads, threads) ||
                const DeepCollectionEquality().equals(other.threads, threads)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sortType) ^
      const DeepCollectionEquality().hash(columnCount) ^
      const DeepCollectionEquality().hash(threads);

  @override
  _$CatalogStateCopyWith<_CatalogState> get copyWith =>
      __$CatalogStateCopyWithImpl<_CatalogState>(this, _$identity);
}

abstract class _CatalogState implements CatalogState {
  factory _CatalogState(
      {CatalogSortType sortType,
      int columnCount,
      List<Thread> threads}) = _$_CatalogState;

  @override
  CatalogSortType get sortType;
  @override
  int get columnCount;
  @override
  List<Thread> get threads;
  @override
  _$CatalogStateCopyWith<_CatalogState> get copyWith;
}
