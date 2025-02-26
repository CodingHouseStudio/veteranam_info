part of 'consent_dialog_bloc.dart';

class ConsentDialogState extends Equatable {
  const ConsentDialogState({
    required this.sent,
  });

  final bool sent;

  @override
  List<Object> get props => [sent];
}
