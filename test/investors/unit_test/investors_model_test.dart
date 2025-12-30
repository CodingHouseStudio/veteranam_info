import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../test_dependency.dart';

// import 'package:veteranam/shared/models/models.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  setupFirebaseAuthMocks();

  setUpAll(setUpGlobal);

  tearDownAll(GetIt.I.reset);
//   group('${KScreenBlocName.investors} ${KGroupText.model} ', () {
//     final fullJson = {
//       FundModelJsonField.id: KTestVariables.fundItems.last.id,
//       FundModelJsonField.title: KTestVariables.fundItems.last.title,
//       FundModelJsonField.description: KTestVariables.fundItems.last.
// description,
//       FundModelJsonField.titleEN: KTestVariables.fundItems.last.titleEN,
//       FundModelJsonField.descriptionEN: KTestVariables.fundItems.last.
// descriptionEN,
//       FundModelJsonField.link: KTestVariables.fundItems.last.link,
//       FundModelJsonField.image: KTestVariables.fundItems.last.image,
//       // FundModelJsonField.comments: KTestVariables.fundItems.last.comments,
//       // FundModelJsonField.domain: KTestVariables.fundItems.last.domain,
//       // FundModelJsonField.email: KTestVariables.fundItems.last.email,
//       // FundModelJsonField.phoneNumber: KTestVariables.fundItems.last.phoneNumber,
//       FundModelJsonField.projectsLink: KTestVariables.fundItems.last.
// projectsLink,
//       // FundModelJsonField.registered: KTestVariables.fundItems.last.registered,
//       // FundModelJsonField.size: KTestVariables.fundItems.last.size,
//       // FundModelJsonField.teamPartnersLink:
//       //     KTestVariables.fundItems.last.teamPartnersLink,
//     };
//     final nullableJson = {
//       FundModelJsonField.id: KTestVariables.fundItems.last.id,
//       FundModelJsonField.title: KTestVariables.fundItems.last.title,
//       FundModelJsonField.description: KTestVariables.fundItems.last.
// description,
//       FundModelJsonField.link: KTestVariables.fundItems.last.link,
//       FundModelJsonField.titleEN: KTestVariables.fundItems.last.titleEN,
//       FundModelJsonField.descriptionEN: KTestVariables.fundItems.last
// .descriptionEN,
//       FundModelJsonField.image: null,
//       // FundModelJsonField.comments: null,
//       // FundModelJsonField.domain: KTestVariables.fundItems.last.domain,
//       // FundModelJsonField.email: null,
//       // FundModelJsonField.phoneNumber: null,
//       FundModelJsonField.projectsLink: null,
//       // FundModelJsonField.registered: null,
//       // FundModelJsonField.size: null,
//       // FundModelJsonField.teamPartnersLink: null,
//     };
//     group('${KGroupText.modelJson} ', () {
//       test('${KGroupText.full} ', () {
//         final fundModel = FundModel.fromJson(fullJson);

//         expect(fundModel.id, KTestVariables.fundItems.last.id);
//         expect(
//           fundModel.title,
//           KTestVariables.fundItems.last.title,
//         );
//         expect(
//           fundModel.description,
//           KTestVariables.fundItems.last.description,
//         );
//         expect(
//           fundModel.link,
//           KTestVariables.fundItems.last.link,
//         );
//         expect(
//           fundModel.image,
//           KTestVariables.fundItems.last.image,
//         );
//         expect(
//           fundModel.titleEN,
//           KTestVariables.fundItems.last.titleEN,
//         );
//         expect(
//           fundModel.descriptionEN,
//           KTestVariables.fundItems.last.descriptionEN,
//         );
//         // expect(
//         //   fundModel.comments,
//         //   KTestVariables.fundItems.last.comments,
//         // );
//         // expect(
//         //   fundModel.domain,
//         //   KTestVariables.fundItems.last.domain,
//         // );
//         // expect(
//         //   fundModel.email,
//         //   KTestVariables.fundItems.last.email,
//         // );
//         // expect(
//         //   fundModel.phoneNumber,
//         //   KTestVariables.fundItems.last.phoneNumber,
//         // );
//         expect(
//           fundModel.projectsLink,
//           KTestVariables.fundItems.last.projectsLink,
//         );
//         // expect(
//         //   fundModel.registered,
//         //   KTestVariables.fundItems.last.registered,
//         // );
//         // expect(
//         //   fundModel.size,
//         //   KTestVariables.fundItems.last.size,
//         // );
//         // expect(
//         //   fundModel.teamPartnersLink,
//         //   KTestVariables.fundItems.last.teamPartnersLink,
//         // );
//       });

//       test('${KGroupText.nullable} ', () {
//         final fundModel = FundModel.fromJson(nullableJson);

//         expect(fundModel.id, KTestVariables.fundItems.last.id);
//         expect(
//           fundModel.title,
//           KTestVariables.fundItems.last.title,
//         );
//         expect(
//           fundModel.description,
//           KTestVariables.fundItems.last.description,
//         );
//         expect(
//           fundModel.titleEN,
//           KTestVariables.fundItems.last.titleEN,
//         );
//         expect(
//           fundModel.descriptionEN,
//           KTestVariables.fundItems.last.descriptionEN,
//         );
//         expect(
//           fundModel.link,
//           KTestVariables.fundItems.last.link,
//         );
//         expect(
//           fundModel.image,
//           null,
//         );
//         // expect(
//         //   fundModel.comments,
//         //   null,
//         // );
//         // expect(
//         //   fundModel.domain,
//         //   KTestVariables.fundItems.last.domain,
//         // );
//         // expect(
//         //   fundModel.email,
//         //   null,
//         // );
//         // expect(
//         //   fundModel.phoneNumber,
//         //   null,
//         // );
//         expect(
//           fundModel.projectsLink,
//           null,
//         );
//         // expect(
//         //   fundModel.registered,
//         //   null,
//         // );
//         // expect(
//         //   fundModel.size,
//         //   null,
//         // );
//         // expect(
//         //   fundModel.teamPartnersLink,
//         //   null,
//         // );
//       });

//       test('${KGroupText.failure} ', () {
//         final json = {
//           FundModelJsonField.id: KTestVariables.fundItems.last.id,
//           // title is missing
//           FundModelJsonField.description: KTestVariables.fundItems
// .last.description,
//           FundModelJsonField.link: KTestVariables.fundItems.last.link,
//           FundModelJsonField.image: KTestVariables.fundItems.last.image,
//           FundModelJsonField.titleEN: KTestVariables.fundItems.last.titleEN,
//           FundModelJsonField.descriptionEN:
//               KTestVariables.fundItems.last.descriptionEN,
//           // FundModelJsonField.comments: KTestVariables.fundItems.last.comments,
//           // FundModelJsonField.domain: KTestVariables.fundItems.last.domain,
//           // FundModelJsonField.email: KTestVariables.fundItems.last.email,
//           // FundModelJsonField.phoneNumber: KTestVariables.fundItems.last.
//           // phoneNumber,
//           FundModelJsonField.projectsLink:
//               KTestVariables.fundItems.last.projectsLink,
//           // FundModelJsonField.registered: KTestVariables.fundItems.last.registered,
//           // FundModelJsonField.size: KTestVariables.fundItems.last.size,
//           // FundModelJsonField.teamPartnersLink:
//           //     KTestVariables.fundItems.last.teamPartnersLink,
//         };

//         expect(
//           () => FundModel.fromJson(json),
//           throwsA(isA<TypeError>()),
//         );
//       });
//     });
//     group('${KGroupText.jsonModel} ', () {
//       test('${KGroupText.full} ', () {
//         final fundModelJson = KTestVariables.fundItems.last.toJson();

//         expect(fundModelJson, fullJson);
//       });

//       test('${KGroupText.nullable} ', () {
//         final fundModelJson = KTestVariables.fundItems.last
//             .copyWith(
//               projectsLink: null,
//               image: null,
//             )
//             .toJson();

//         expect(fundModelJson, nullableJson);
//       });
//     });
//   });
}
