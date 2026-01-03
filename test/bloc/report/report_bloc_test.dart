import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.report} ${KGroupText.bloc} ', () {
    // late ReportBloc reportBloc;
    late IReportRepository mockReportRepository;
    late IAppAuthenticationRepository mockAppAuthenticationRepository;
    setUp(() {
      ExtendedDateTime.current = KTestVariables.dateTime;
      ExtendedDateTime.id = KTestVariables.reportModel.id;
      mockReportRepository = MockIReportRepository();
      mockAppAuthenticationRepository = MockAppAuthenticationRepository();
      when(
        mockReportRepository.sendReport(
          KTestVariables.reportModel.copyWith(card: CardEnum.discount),
        ),
      ).thenAnswer(
        (realInvocation) async => const Left(
          SomeFailure.serverError,
        ),
      );
      when(
        mockReportRepository.sendReport(
          KTestVariables.reportModel.copyWith(
            reasonComplaint: ReasonComplaint.other,
            message: KTestVariables.fieldEmpty,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockReportRepository.sendReport(
          KTestVariables.reportModel.copyWith(
            reasonComplaint: ReasonComplaint.other,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(
        mockReportRepository.sendReport(
          KTestVariables.reportModel.copyWith(
            reasonComplaint: ReasonComplaint.fraudOrSpam,
            message: null,
          ),
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(true),
      );
      when(mockAppAuthenticationRepository.currentUser).thenAnswer(
        (realInvocation) => KTestVariables.user,
      );
      when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
        (realInvocation) => true,
      );
      // reportBloc = ReportBloc(
      //   reportRepository: mockReportRepository,
      //   appAuthenticationRepository: mockAppAuthenticationRepository,
      // );
    });

    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when reasonComplaint(other) and'
      ' message are changed and not valid',
      build: () => ReportBloc(
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        cardId: KTestVariables.id,
        card: CardEnum.funds,
      ),
      act: (bloc) => bloc
        ..add(const ReportEvent.send())
        ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
        // ..add(
        //   const ReportEvent.emailUpdated(KTestVariables.userEmail),
        // )
        ..add(const ReportEvent.messageUpdated(KTestVariables.fieldEmpty))
        ..add(const ReportEvent.send()),
      expect: () => [
        // ReportState(
        //   formState: ReportEnum.initial,
        //   reasonComplaint: null,
        //   email: EmailFieldModel.dirty(KTestVariables.user.email!),
        //   message: const ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestVariables.id,
        //   card: CardEnum.funds,
        // ),
        ReportState(
          formState: ReportEnum.invalidData,
          reasonComplaint: null,
          email: EmailFieldModel.dirty(KTestVariables.user.email!),
          message: const ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestVariables.user.email!),
          message: const ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.other,
        //    email: EmailFieldModel.dirty(KTestVariables.userEmail),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestVariables.id,
        // ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: ReportFieldModel.dirty(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.nextInvalidData,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: ReportFieldModel.dirty(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
      ],
    );

    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when reasonComplaint(other) and'
      ' message are changed without email not valid',
      build: () {
        when(mockAppAuthenticationRepository.currentUser).thenAnswer(
          (realInvocation) => User.empty,
        );
        return ReportBloc(
          reportRepository: mockReportRepository,
          appAuthenticationRepository: mockAppAuthenticationRepository,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        );
      },
      act: (bloc) => bloc
        ..add(const ReportEvent.send())
        ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
        ..add(const ReportEvent.send()),
      expect: () => [
        const ReportState(
          formState: ReportEnum.invalidData,
          reasonComplaint: null,
          email: EmailFieldModel.pure(),
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.pure(),
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.next,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.pure(),
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when reasonComplaint(fraudOrSpam),'
      ' are changed and send',
      build: () => ReportBloc(
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        cardId: KTestVariables.id,
        card: CardEnum.funds,
      ),
      act: (bloc) => bloc
        // ..add(const ReportEvent.started(KTestVariables.id))
        ..add(
          const ReportEvent.reasonComplaintUpdated(ReasonComplaint.fraudOrSpam),
        )
        ..add(
          const ReportEvent.emailUpdated(KTestVariables.userEmailIncorrect),
        )
        ..add(const ReportEvent.messageUpdated(KTestVariables.field))
        ..add(const ReportEvent.send())
        ..add(
          const ReportEvent.emailUpdated(''),
        )
        ..add(const ReportEvent.send())
        ..add(const ReportEvent.cancel())
        ..add(const ReportEvent.send())
        ..add(
          const ReportEvent.emailUpdated(KTestVariables.userEmail),
        )
        ..add(const ReportEvent.send()),
      expect: () => [
        // ReportState(
        //   formState: ReportEnum.initial,
        //   reasonComplaint: null,
        //   email: EmailFieldModel.dirty(KTestVariables.user.email!),
        //   message: const ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestVariables.id,
        //   card: CardEnum.funds,
        // ),
        ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.user.email!),
          message: const ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.nextInvalidData,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmailIncorrect),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.sumbittedWithoutEmail,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
          triedSentWithoutEmail: true,
        ),
        const ReportState(
          formState: ReportEnum.nextInvalidData,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
          triedSentWithoutEmail: true,
        ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
          triedSentWithoutEmail: true,
        ),
        const ReportState(
          formState: ReportEnum.success,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
          triedSentWithoutEmail: true,
        ),
      ],
    );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when valid data is submitted'
      ' with correct credentials',
      build: () => ReportBloc(
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        cardId: KTestVariables.id,
        card: CardEnum.funds,
      ),
      act: (bloc) async => bloc
        // ..add(const ReportEvent.started(KTestVariables.id))
        ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.other))
        // ..add(const ReportEvent.emailUpdated(KTestVariables.userEmail))
        ..add(
          ReportEvent.messageUpdated(
            KTestVariables.reportItems.first.message!,
          ),
        )
        ..add(const ReportEvent.send()),
      expect: () => [
        // ReportState(
        //   formState: ReportEnum.initial,
        //   reasonComplaint: null,
        //   email: EmailFieldModel.dirty(KTestVariables.user.email!),
        //   message: const ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestVariables.id,
        //   card: CardEnum.funds,
        // ),
        ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.other,
          email: EmailFieldModel.dirty(KTestVariables.user.email!),
          message: const ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.other,
        //    email: EmailFieldModel.dirty(KTestVariables.userEmail),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestVariables.id,
        // ),
        ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.other,
          email: const EmailFieldModel.dirty(KTestVariables.userEmail),
          message:
              ReportFieldModel.dirty(KTestVariables.reportItems.first.message!),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
        ReportState(
          reasonComplaint: ReasonComplaint.other,
          email: const EmailFieldModel.dirty(KTestVariables.userEmail),
          message:
              ReportFieldModel.dirty(KTestVariables.reportItems.first.message!),
          formState: ReportEnum.success,
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.funds,
        ),
      ],
    );
    // blocTest<ReportBloc, ReportState>(
    //   'emits [ReportState] when valid data is submitted'
    //   ' with correct credentials and user login',
    //   build: () => reportBloc,
    //   act: (bloc) async {
    //     when(mockAppAuthenticationRepository.currentUser).thenAnswer(
    //       (realInvocation) => KTestVariables.user,
    //     );
    //     when(mockAppAuthenticationRepository.isAnonymously).thenAnswer(
    //       (realInvocation) => false,
    //     );
    //     bloc
    //       ..add(const ReportEvent.started(KTestVariables.id))
    //       ..add(const ReportEvent.reasonComplaintUpdated(ReasonComplaint.
    // other))
    //       ..add(const ReportEvent.messageUpdated(KTestVariables.field))
    //       ..add(const ReportEvent.send(CardEnum.funds));
    //   },
    //   expect: () => [
    //     const ReportState(
    //       formState: ReportEnum.initial,
    //       reasonComplaint: null,
    //        email: EmailFieldModel.pure(),
    //       message: ReportFieldModel.pure(),
    //       failure: null,
    //       cardId: KTestVariables.id,
    //     ),
    //     const ReportState(
    //       formState: ReportEnum.inProgress,
    //       reasonComplaint: ReasonComplaint.other,
    //        email: EmailFieldModel.pure(),
    //       message: ReportFieldModel.pure(),
    //       failure: null,
    //       cardId: KTestVariables.id,
    //     ),
    //     const ReportState(
    //       formState: ReportEnum.nextInProgress,
    //       reasonComplaint: ReasonComplaint.other,
    //        email: EmailFieldModel.pure(),
    //       message: ReportFieldModel.dirty(KTestVariables.field),
    //       failure: null,
    //       cardId: KTestVariables.id,
    //     ),
    //     const ReportState(
    //       reasonComplaint: ReasonComplaint.other,
    //        email: EmailFieldModel.pure(),
    //       message: ReportFieldModel.dirty(KTestVariables.field),
    //       formState: ReportEnum.success,
    //       failure: null,
    //       cardId: KTestVariables.id,
    //     ),
    //   ],
    // );
    blocTest<ReportBloc, ReportState>(
      'emits [ReportState] when valid data is submitted '
      'with incorrect credentials',
      build: () => ReportBloc(
        reportRepository: mockReportRepository,
        appAuthenticationRepository: mockAppAuthenticationRepository,
        cardId: KTestVariables.id,
        card: CardEnum.discount,
      ),
      act: (bloc) async => bloc
        // ..add(const ReportEvent.started(KTestVariables.id))
        ..add(
          const ReportEvent.reasonComplaintUpdated(
            ReasonComplaint.fraudOrSpam,
          ),
        )
        // ..add(const ReportEvent.emailUpdated(KTestVariables.userEmail))
        ..add(const ReportEvent.messageUpdated(KTestVariables.field))
        ..add(const ReportEvent.send()),
      expect: () => [
        // const ReportState(
        //   formState: ReportEnum.initial,
        //   reasonComplaint: null,
        //   email: EmailFieldModel.pure(),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestVariables.id,
        //   card: CardEnum.discount,
        // ),
        const ReportState(
          formState: ReportEnum.inProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: ReportFieldModel.pure(),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.discount,
        ),
        // const ReportState(
        //   formState: ReportEnum.nextInProgress,
        //   reasonComplaint: ReasonComplaint.fraudOrSpam,
        //    email: EmailFieldModel.dirty(KTestVariables.userEmail),
        //   message: ReportFieldModel.pure(),
        //   failure: null,
        //   cardId: KTestVariables.id,
        // ),
        const ReportState(
          formState: ReportEnum.nextInProgress,
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: ReportFieldModel.dirty(KTestVariables.field),
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.discount,
        ),
        const ReportState(
          reasonComplaint: ReasonComplaint.fraudOrSpam,
          email: EmailFieldModel.dirty(KTestVariables.userEmail),
          message: ReportFieldModel.dirty(KTestVariables.field),
          formState: ReportEnum.success,
          failure: null,
          cardId: KTestVariables.id,
          card: CardEnum.discount,
        ),
      ],
    );
  });
}
