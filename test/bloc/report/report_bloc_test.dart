import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared.dart';

import '../../text_dependency.dart';

void main() {
  group('${KScreenBlocName.report} ${KGroupText.bloc} ', () {
    late ReportBloc reportBloc;
    late IReportRepository mockReportRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestText.dateTime;
      ExtendedDateTime.id = KTestText.reportModel.id;
      mockReportRepository = MockIReportRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(
        mockReportRepository.sendReport(
          KTestText.reportModel.copyWith(card: CardEnum.discount),
        ),
      ).thenAnswer(
        (realInvocation) async => const Left(SomeFailure.serverError()),
      );
      when(
        mockReportRepository.sendReport(
          KTestText.reportModel
              .copyWith(reasonComplaint: ReasonComplaint.other),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );
      when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
        (realInvocation) => true,
      );
      reportBloc = ReportBloc(
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when reasonComplaint(other), email and'
      ' message are changed and not valid',
      build: () => reportBloc,
      act: (bloc) => bloc
        ..add(const ReportEvent.send(CardEnum.funds))
        ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
        ..add(
          const ReportEvent.emailUpdated(KTestText.userEmail),
        )
        ..add(const ReportEvent.messageUpdated(KTestText.fieldEmpty))
        ..add(const ReportEvent.send(CardEnum.funds)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.invalidData,
          reasonComplaint: null,
          email: null,
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          email: null,
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(),
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInvalidData,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(),
          failure: null,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when reasonComplaint(fraudOrSpam), email and'
      ' message are changed and not valid',
      build: () => reportBloc,
      act: (bloc) => bloc
        ..add(
          const ReportEvent.reasonComplaintUpdated(ReasonComplaint.fraudOrSpam),
        )
        ..add(
          const ReportEvent.emailUpdated(KTestText.userEmailIncorrect),
        )
        ..add(const ReportEvent.messageUpdated(KTestText.field))
        ..add(const ReportEvent.send(CardEnum.funds)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: null,
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInvalidData,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: null,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when valid data is submitted'
      ' with correct credentials',
      build: () => reportBloc,
      act: (bloc) async => bloc
        ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
        ..add(const ReportEvent.emailUpdated(KTestText.userEmail))
        ..add(const ReportEvent.messageUpdated(KTestText.field))
        ..add(const ReportEvent.send(CardEnum.funds)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          email: null,
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: null,
        ),
        const ReportState(
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          formState: ReportEnum.success,
          failure: null,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when valid data is submitted'
      ' with correct credentials and user login',
      build: () => reportBloc,
      act: (bloc) async {
        when(mockAppAuthenticationRepository.currentUser).thenAnswer(
          (realInvocation) => KTestText.user,
        );
        when(mockAppAuthenticationRepository.isAnonymously()).thenAnswer(
          (realInvocation) => false,
        );
        bloc
          ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
          ..add(const ReportEvent.messageUpdated(KTestText.field))
          ..add(const ReportEvent.send(CardEnum.funds));
      },
      expect: () => [
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          email: null,
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          email: null,
          message: MessageFieldModel.dirty(KTestText.field),
          failure: null,
        ),
        const ReportState(
          reasonComplaint: ReasonComplaint.other,
          email: null,
          message: MessageFieldModel.dirty(KTestText.field),
          formState: ReportEnum.success,
          failure: null,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when valid data is submitted '
      'with incorrect credentials',
      build: () => reportBloc,
      act: (bloc) async => bloc
        ..add(
          const ReportEvent.reasonComplaintUpdated(
            ReasonComplaint.fraudOrSpam,
          ),
        )
        ..add(const ReportEvent.emailUpdated(KTestText.userEmail))
        ..add(const ReportEvent.messageUpdated(KTestText.field))
        ..add(const ReportEvent.send(CardEnum.discount)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: null,
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: null,
          failure: null,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          failure: null,
        ),
        const ReportState(
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestText.userEmail),
          message: MessageFieldModel.dirty(KTestText.field),
          formState: ReportEnum.initial,
          failure: ReportFailure.error,
        ),
      ],
    );
  });
}
