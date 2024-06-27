part of 'choose_cubit.dart';

class ChooseState extends Equatable {
  final List<dynamic> cleanerData;
  final bool isLoading;

  const ChooseState({required this.cleanerData, required this.isLoading});

  factory ChooseState.initial() {
    return ChooseState(cleanerData: [], isLoading: true);
  }

  ChooseState copyWith({List<dynamic>? cleanerData, bool? isLoading}) {
    return ChooseState(
      cleanerData: cleanerData ?? this.cleanerData,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [cleanerData, isLoading];
}
