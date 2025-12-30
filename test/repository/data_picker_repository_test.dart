import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

import 'package:veteranam/shared/shared_dart.dart';
import '../test_dependency.dart';

void main() {
  setUpAll(configureFailureDependenciesTest);

  setUp(resetTestVariables);

  tearDownAll(GetIt.I.reset);
  group('${KScreenBlocName.dataPicker} ${KGroupText.repository}', () {
    late IDataPickerRepository dataPickerRepository;
    late ImagePicker mockImagePicker;
    // late FilePicker mockFilePicker;
    late XFile mockXFile;
    // late FilePickerResult mockFilePickerResult;
    // late PlatformFile mockPlatformFile;
    setUp(() {
      mockImagePicker = MockImagePicker();
      mockXFile = MockXFile();
      // mockFilePicker = MockFilePicker();
      // mockFilePickerResult = MockFilePickerResult();
      // mockPlatformFile = MockPlatformFile();
    });
    group('${KGroupText.failureGet} ', () {
      setUp(() {
        when(
          mockImagePicker.pickImage(source: DataPickerRepository.imageSource),
        ).thenThrow(
          Exception(KGroupText.failureGet),
        );
        // when(
        //   mockFilePicker.pickFiles(
        //     type: FileType.custom,
        //     allowedExtensions: DataPickerRepository.fileAllowedExtensions,
        //   ),
        // ).thenThrow(
        //   Exception(KGroupText.failureGet),
        // );

        dataPickerRepository = DataPickerRepository(
          imagePciker: mockImagePicker,
        );
      });
      test('Get Image', () async {
        final file = await dataPickerRepository.getImage;
        expect(
          file,
          isNull,
        );
      });
      // test('Get File', () async {
      //   final file = await dataPickerRepository.getFile;
      //   expect(
      //     file,
      //     isNull,
      //   );
      // });
    });
    group('${KGroupText.successfulGet} ', () {
      setUp(() {
        when(
          mockXFile.mimeType,
        ).thenAnswer(
          (_) => 'image/png',
        );
        when(
          mockImagePicker.pickImage(source: DataPickerRepository.imageSource),
        ).thenAnswer(
          (_) async => mockXFile,
        );
        // when(
        //   mockFilePicker.pickFiles(
        //     type: DataPickerRepository.fileType,
        //     allowedExtensions: DataPickerRepository.fileAllowedExtensions,
        //   ),
        // ).thenAnswer(
        //   (_) async => mockFilePickerResult,
        // );
        // when(
        //   mockFilePickerResult.files,
        // ).thenAnswer(
        //   (_) => [mockPlatformFile],
        // );
        // when(
        //   mockPlatformFile.bytes,
        // ).thenAnswer(
        //   (_) => KTestVariables.filePickerItem.bytes,
        // );
        // when(
        //   mockPlatformFile.path,
        // ).thenAnswer(
        //   (_) => KTestVariables.filePickerItem.ref,
        // );
        when(
          mockXFile.readAsBytes(),
        ).thenAnswer(
          (_) async => KTestVariables.filePickerItem.bytes,
        );
        when(
          mockXFile.path,
        ).thenAnswer(
          (_) => KTestVariables.filePickerItem.ref!,
        );

        dataPickerRepository = DataPickerRepository(
          imagePciker: mockImagePicker,
          // filePicker: mockFilePicker,
        );
      });
      test('Get Image without extension', () async {
        when(
          mockXFile.name,
        ).thenAnswer(
          (_) => KTestVariables.filePickerItem.name!,
        );
        final file = await dataPickerRepository.getImage;
        expect(
          file,
          isNotNull,
        );
        if (file == null) return;
        expect(
          file.bytes,
          KTestVariables.filePickerItem.bytes,
        );
        expect(
          file.name,
          KTestVariables.filePickerItem.name,
        );
        expect(
          file.ref,
          KTestVariables.filePickerItem.ref,
        );
        expect(
          file.extension,
          KTestVariables.filePickerItem.extension,
        );
      });

      // test('Get File without extension', () async {
      //   when(
      //     mockPlatformFile.name,
      //   ).thenAnswer(
      //     (_) => KTestVariables.filePickerItem.name!,
      //   );
      //   final file = await dataPickerRepository.getFile;
      //   expect(
      //     file,
      //     isNotNull,
      //   );
      //   if (file == null) return;
      //   expect(
      //     file.bytes,
      //     KTestVariables.filePickerItem.bytes,
      //   );
      //   expect(
      //     file.name,
      //     KTestVariables.filePickerItem.name,
      //   );
      //   expect(
      //     file.ref,
      //     KTestVariables.filePickerItem.ref,
      //   );
      //   expect(
      //     file.extension,
      //     KTestVariables.filePickerItem.extension,
      //   );
      // });

      test('Get Image', () async {
        when(
          mockXFile.name,
        ).thenAnswer(
          (_) => KTestVariables.filePickerPathItem.name!,
        );
        final file = await dataPickerRepository.getImage;
        expect(
          file,
          isNotNull,
        );
        if (file == null) return;
        expect(
          file.bytes,
          KTestVariables.filePickerItem.bytes,
        );
        expect(
          file.name,
          KTestVariables.filePickerPathItem.name,
        );
        expect(
          file.ref,
          KTestVariables.filePickerPathItem.ref,
        );
        expect(
          file.extension,
          KTestVariables.filePickerPathItem.extension,
        );
      });

      // test('Get File', () async {
      //   when(
      //     mockPlatformFile.name,
      //   ).thenAnswer(
      //     (_) => KTestVariables.filePickerPathItem.name!,
      //   );
      //   final file = await dataPickerRepository.getFile;
      //   expect(
      //     file,
      //     isNotNull,
      //   );
      //   if (file == null) return;
      //   expect(
      //     file.bytes,
      //     KTestVariables.filePickerItem.bytes,
      //   );
      //   expect(
      //     file.name,
      //     KTestVariables.filePickerPathItem.name,
      //   );
      //   expect(
      //     file.ref,
      //     KTestVariables.filePickerPathItem.ref,
      //   );
      //   expect(
      //     file.extension,
      //     KTestVariables.filePickerPathItem.extension,
      //   );
      // });

      // test('Get File with bytes NULL', () async {
      //   when(
      //     mockPlatformFile.name,
      //   ).thenAnswer(
      //     (_) => KTestVariables.filePickerPathItem.name!,
      //   );
      //   when(
      //     mockPlatformFile.bytes,
      //   ).thenAnswer(
      //     (_) => null,
      //   );
      //   final file = await dataPickerRepository.getFile;
      //   expect(
      //     file,
      //     isNull,
      //   );
      // });
    });
    group('Get Model', () {
      test('Get Image Model', () {
        final imageMdeol =
            KTestVariables.filePickerItem.image(KTestVariables.downloadURL);

        expect(imageMdeol.downloadURL, KTestVariables.downloadURL);

        expect(imageMdeol.name, KTestVariables.filePickerItem.name);

        expect(imageMdeol.ref, KTestVariables.filePickerItem.ref);

        expect(imageMdeol.type, KTestVariables.filePickerItem.extension);
      });

      test('Get Resume Model', () {
        final imageMdeol =
            KTestVariables.filePickerItem.resume(KTestVariables.downloadURL);

        expect(imageMdeol.downloadURL, KTestVariables.downloadURL);

        expect(imageMdeol.name, KTestVariables.filePickerItem.name);

        expect(imageMdeol.ref, KTestVariables.filePickerItem.ref);

        expect(imageMdeol.type, KTestVariables.filePickerItem.extension);
      });
    });
  });
}
