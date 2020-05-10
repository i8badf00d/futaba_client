// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'thread_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$ThreadDetailStateTearOff {
  const _$ThreadDetailStateTearOff();

  _ThreadDetailState call(
      {String title, List<ThreadDetailRow> rows, DateTime expiresDateTime}) {
    return _ThreadDetailState(
      title: title,
      rows: rows,
      expiresDateTime: expiresDateTime,
    );
  }
}

// ignore: unused_element
const $ThreadDetailState = _$ThreadDetailStateTearOff();

mixin _$ThreadDetailState {
  String get title;
  List<ThreadDetailRow> get rows;
  DateTime get expiresDateTime;

  $ThreadDetailStateCopyWith<ThreadDetailState> get copyWith;
}

abstract class $ThreadDetailStateCopyWith<$Res> {
  factory $ThreadDetailStateCopyWith(
          ThreadDetailState value, $Res Function(ThreadDetailState) then) =
      _$ThreadDetailStateCopyWithImpl<$Res>;
  $Res call(
      {String title, List<ThreadDetailRow> rows, DateTime expiresDateTime});
}

class _$ThreadDetailStateCopyWithImpl<$Res>
    implements $ThreadDetailStateCopyWith<$Res> {
  _$ThreadDetailStateCopyWithImpl(this._value, this._then);

  final ThreadDetailState _value;
  // ignore: unused_field
  final $Res Function(ThreadDetailState) _then;

  @override
  $Res call({
    Object title = freezed,
    Object rows = freezed,
    Object expiresDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      rows: rows == freezed ? _value.rows : rows as List<ThreadDetailRow>,
      expiresDateTime: expiresDateTime == freezed
          ? _value.expiresDateTime
          : expiresDateTime as DateTime,
    ));
  }
}

abstract class _$ThreadDetailStateCopyWith<$Res>
    implements $ThreadDetailStateCopyWith<$Res> {
  factory _$ThreadDetailStateCopyWith(
          _ThreadDetailState value, $Res Function(_ThreadDetailState) then) =
      __$ThreadDetailStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title, List<ThreadDetailRow> rows, DateTime expiresDateTime});
}

class __$ThreadDetailStateCopyWithImpl<$Res>
    extends _$ThreadDetailStateCopyWithImpl<$Res>
    implements _$ThreadDetailStateCopyWith<$Res> {
  __$ThreadDetailStateCopyWithImpl(
      _ThreadDetailState _value, $Res Function(_ThreadDetailState) _then)
      : super(_value, (v) => _then(v as _ThreadDetailState));

  @override
  _ThreadDetailState get _value => super._value as _ThreadDetailState;

  @override
  $Res call({
    Object title = freezed,
    Object rows = freezed,
    Object expiresDateTime = freezed,
  }) {
    return _then(_ThreadDetailState(
      title: title == freezed ? _value.title : title as String,
      rows: rows == freezed ? _value.rows : rows as List<ThreadDetailRow>,
      expiresDateTime: expiresDateTime == freezed
          ? _value.expiresDateTime
          : expiresDateTime as DateTime,
    ));
  }
}

class _$_ThreadDetailState implements _ThreadDetailState {
  _$_ThreadDetailState({this.title, this.rows, this.expiresDateTime});

  @override
  final String title;
  @override
  final List<ThreadDetailRow> rows;
  @override
  final DateTime expiresDateTime;

  @override
  String toString() {
    return 'ThreadDetailState(title: $title, rows: $rows, expiresDateTime: $expiresDateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ThreadDetailState &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.rows, rows) ||
                const DeepCollectionEquality().equals(other.rows, rows)) &&
            (identical(other.expiresDateTime, expiresDateTime) ||
                const DeepCollectionEquality()
                    .equals(other.expiresDateTime, expiresDateTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(rows) ^
      const DeepCollectionEquality().hash(expiresDateTime);

  @override
  _$ThreadDetailStateCopyWith<_ThreadDetailState> get copyWith =>
      __$ThreadDetailStateCopyWithImpl<_ThreadDetailState>(this, _$identity);
}

abstract class _ThreadDetailState implements ThreadDetailState {
  factory _ThreadDetailState(
      {String title,
      List<ThreadDetailRow> rows,
      DateTime expiresDateTime}) = _$_ThreadDetailState;

  @override
  String get title;
  @override
  List<ThreadDetailRow> get rows;
  @override
  DateTime get expiresDateTime;
  @override
  _$ThreadDetailStateCopyWith<_ThreadDetailState> get copyWith;
}
