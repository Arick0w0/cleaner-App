import 'package:equatable/equatable.dart';

class StartJobState extends Equatable {
  final bool isLoading;
  final Map<String, dynamic>? startJobDetail;
  final String? errorMessage;
  final bool statusProcessSubmitted;

  const StartJobState({
    this.isLoading = false,
    this.startJobDetail,
    this.errorMessage,
    this.statusProcessSubmitted = false,
  });

  StartJobState copyWith({
    bool? isLoading,
    Map<String, dynamic>? startJobDetail,
    String? errorMessage,
    bool? statusProcessSubmitted,
  }) {
    return StartJobState(
      isLoading: isLoading ?? this.isLoading,
      startJobDetail: startJobDetail ?? this.startJobDetail,
      errorMessage: errorMessage ?? this.errorMessage,
      statusProcessSubmitted:
          statusProcessSubmitted ?? this.statusProcessSubmitted,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, startJobDetail, errorMessage, statusProcessSubmitted];
}
