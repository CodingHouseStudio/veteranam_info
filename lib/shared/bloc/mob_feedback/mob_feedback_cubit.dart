import 'package:bloc/bloc.dart';
import 'package:feedback/feedback.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@injectable
class MobFeedbackBloc extends Cubit<dynamic> {
  MobFeedbackBloc({required IFeedbackRepository feedbackRepository})
      : _feedbackRepository = feedbackRepository,
        super(1);
  final IFeedbackRepository _feedbackRepository;
  Future<void> send(UserFeedback feedback) async {
    // final value = await event.value;
    // debugPrint(value.toString());
  }
}
