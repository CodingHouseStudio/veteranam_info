import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'consent_dialog_event.dart';
part 'consent_dialog_state.dart';

@injectable
class ConsentDialogBloc extends Bloc<_ConsentDialogEvent, ConsentDialogState> {
  ConsentDialogBloc({
    required FirebaseAnalyticsService firebaseAnalyticsService,
  })  : _firebaseAnalyticsService = firebaseAnalyticsService,
        super(
          const ConsentDialogState(
            sent: false,
          ),
        ) {
    on<SubmittedConsentEvent>(_onSubmittedConsentEvent);
  }

  final FirebaseAnalyticsService _firebaseAnalyticsService;

  void _onSubmittedConsentEvent(
    SubmittedConsentEvent event,
    Emitter<ConsentDialogState> emit,
  ) {
    _firebaseAnalyticsService.setConsent(state: !event.onlyNecessary);

    emit(
      const ConsentDialogState(
        sent: true,
      ),
    );
  }
}
