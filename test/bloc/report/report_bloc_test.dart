import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
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
        (realInvocation) async => Left(
          SomeFailure.serverError(
            error: null,
          ),
        ),
      );
      when(
        mockReportRepository.sendReport(
          KTestText.reportModel.copyWith(
            reasonComplaint: ReasonComplaint.other,
            message: KTestText.fieldEmpty,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockReportRepository.sendReport(
          KTestText.reportModel.copyWith(
            reasonComplaint: ReasonComplaint.other,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockReportRepository.sendReport(
          KTestText.reportModel.copyWith(
            reasonComplaint: ReasonComplaint.fraudOrSpam,
            message: null,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestText.user,
      );
      when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
        (realInvocation) => true,
      );
      reportBloc = ReportBloc(
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
      );
    });

    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when reasonComplaint(other) and'
      ' message are changed and not valid',
      build: () => reportBloc,
      act: (bloc) => bloc
        ..add(const ReportEvent.started(KTestText.id))
        ..add(const ReportEvent.send(CardEnum.funds))
        ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
        // ..add(
        //   const ReportEvent.emailUpdated(KTestText.userEmail),
        // )
        ..add(const ReportEvent.messageUpdated(KTestText.fieldEmpty))
        ..add(const ReportEvent.send(CardEnum.funds)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.initial,
          reasonComplaint: null,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        const ReportState(
          formState: ReportEnum.invalidData,
          reasonComplaint: null,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.other,
        //   // email: EmailFieldModel.dirty(KTestText.userEmail),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestText.id,
        // ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          // email: EmailFieldModel.dirty(KTestText.userEmail),
          message: ReportFieldModel.dirty(),
          failure: null,
          cardId: KTestText.id,
        ),
        const ReportState(
          formState: ReportEnum.nextInvalidData,
          reasonComplaint: ReasonComplaint.other,
          // email: EmailFieldModel.dirty(KTestText.userEmail),
          message: ReportFieldModel.dirty(),
          failure: null,
          cardId: KTestText.id,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when reasonComplaint(fraudOrSpam),'
      ' are changed and send',
      build: () => reportBloc,
      act: (bloc) => bloc
        ..add(const ReportEvent.started(KTestText.id))
        ..add(
          const ReportEvent.reasonComplaintUpdated(ReasonComplaint.fraudOrSpam),
        )
        // ..add(
        //   const ReportEvent.emailUpdated(KTestText.userEmailIncorrect),
        // )
        // ..add(const ReportEvent.messageUpdated(KTestText.field))
        ..add(const ReportEvent.send(CardEnum.funds)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.initial,
          reasonComplaint: null,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.fraudOrSpam,
        //   // email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestText.id,
        // ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.fraudOrSpam,
        //   // email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
        //   message: ReportFieldModel.dirty(KTestText.field),
        //   failure: null,
        //   cardId: KTestText.id,
        // ),
        const ReportState(
          formState: ReportEnum.success,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          // email: EmailFieldModel.dirty(KTestText.userEmailIncorrect),
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when valid data is submitted'
      ' with correct credentials',
      build: () => reportBloc,
      act: (bloc) async => bloc
        ..add(const ReportEvent.started(KTestText.id))
        ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
        // ..add(const ReportEvent.emailUpdated(KTestText.userEmail))
        ..add(ReportEvent.messageUpdated(KTestText.reportItems.first.message!))
        ..add(const ReportEvent.send(CardEnum.funds)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.initial,
          reasonComplaint: null,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.other,
        //   // email: EmailFieldModel.dirty(KTestText.userEmail),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestText.id,
        // ),
        ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          // email: EmailFieldModel.dirty(KTestText.userEmail),
          message: ReportFieldModel.dirty(KTestText.reportItems.first.message!),
          failure: null,
          cardId: KTestText.id,
        ),
        ReportState(
          reasonComplaint: ReasonComplaint.other,
          // email: EmailFieldModel.dirty(KTestText.userEmail),
          message: ReportFieldModel.dirty(KTestText.reportItems.first.message!),
          formState: ReportEnum.success,
          failure: null,
          cardId: KTestText.id,
        ),
      ],
    );
    // blocTest<ReportBloc, ReportState>(
    //   'emits [ReportState] when valid data is submitted'
    //   ' with correct credentials and user login',
    //   build: () => reportBloc,
    //   act: (bloc) async {
    //     when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    //       (realInvocation) => KTestText.user,
    //     );
    //     when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
    //       (realInvocation) => false,
    //     );
    //     bloc
    //       ..add(const ReportEvent.started(KTestText.id))
    //       ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.
    // other))
    //       ..add(const ReportEvent.messageUpdated(KTestText.field))
    //       ..add(const ReportEvent.send(CardEnum.funds));
    //   },
    //   expect: () => [
    //     const ReportState(
    //       formState: ReportEnum.initial,
    //       reasonComplaint: null,
    //       // email: null,
    //       message: ReportFieldModel.pure(),
    //       failure: null,
    //       cardId: KTestText.id,
    //     ),
    //     const ReportState(
    //       formState: ReportEnum.inProgress,
    //       reasonComplaint: ReasonComplaint.other,
    //       // email: null,
    //       message: ReportFieldModel.pure(),
    //       failure: null,
    //       cardId: KTestText.id,
    //     ),
    //     const ReportState(
    //       formState: ReportEnum.nextInProgress,
    //       reasonComplaint: ReasonComplaint.other,
    //       // email: null,
    //       message: ReportFieldModel.dirty(KTestText.field),
    //       failure: null,
    //       cardId: KTestText.id,
    //     ),
    //     const ReportState(
    //       reasonComplaint: ReasonComplaint.other,
    //       // email: null,
    //       message: ReportFieldModel.dirty(KTestText.field),
    //       formState: ReportEnum.success,
    //       failure: null,
    //       cardId: KTestText.id,
    //     ),
    //   ],
    // );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when valid data is submitted '
      'with incorrect credentials',
      build: () => reportBloc,
      act: (bloc) async => bloc
        ..add(const ReportEvent.started(KTestText.id))
        ..add(
          const ReportEvent.reasonComplaintUpdated(
            ReasonComplaint.fraudOrSpam,
          ),
        )
        // ..add(const ReportEvent.emailUpdated(KTestText.userEmail))
        ..add(const ReportEvent.messageUpdated(KTestText.field))
        ..add(const ReportEvent.send(CardEnum.discount)),
      expect: () => [
        const ReportState(
          formState: ReportEnum.initial,
          reasonComplaint: null,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          // email: null,
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestText.id,
        ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.fraudOrSpam,
        //   // email: EmailFieldModel.dirty(KTestText.userEmail),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestText.id,
        // ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          // email: EmailFieldModel.dirty(KTestText.userEmail),
          message: ReportFieldModel.dirty(KTestText.field),
          failure: null,
          cardId: KTestText.id,
        ),
        const ReportState(
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          // email: EmailFieldModel.dirty(KTestText.userEmail),
          message: ReportFieldModel.dirty(KTestText.field),
          formState: ReportEnum.success,
          failure: null,
          cardId: KTestText.id,
        ),
      ],
    );
  });
}
