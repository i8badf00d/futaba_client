import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_row.dart';

part 'thread_detail_state.freezed.dart';

@freezed
abstract class ThreadDetailState with _$ThreadDetailState {
  factory ThreadDetailState({
    String title,
    List<ThreadDetailRow> rows,
    DateTime expiresDateTime,
  }) = _ThreadDetailState;
}
