import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';
import 'package:veteranam/shared/shared_dart.dart';

import '../test_dependency.dart';

void main() {
  setUp(configureFailureDependenciesTest);

  tearDown(GetIt.I.reset);
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
        //   (_) => KTestText.filePickerItem.bytes,
        // );
        // when(
        //   mockPlatformFile.path,
        // ).thenAnswer(
        //   (_) => KTestText.filePickerItem.ref,
        // );
        when(
          mockXFile.readAsBytes(),
        ).thenAnswer(
          (_) async => KTestText.filePickerItem.bytes,
        );
        when(
          mockXFile.path,
        ).thenAnswer(
          (_) => KTestText.filePickerItem.ref!,
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
          (_) => KTestText.filePickerItem.name!,
        );
        final file = await dataPickerRepository.getImage;
        expect(
          file,
          isNotNull,
        );
        if (file == null) return;
        expect(
          file.bytes,
          KTestText.filePickerItem.bytes,
        );
        expect(
          file.name,
          KTestText.filePickerItem.name,
        );
        expect(
          file.ref,
          KTestText.filePickerItem.ref,
        );
        expect(
          file.extension,
          KTestText.filePickerItem.extension,
        );
      });

      // test('Get File without extension', () async {
      //   when(
      //     mockPlatformFile.name,
      //   ).thenAnswer(
      //     (_) => KTestText.filePickerItem.name!,
      //   );
      //   final file = await dataPickerRepository.getFile;
      //   expect(
      //     file,
      //     isNotNull,
      //   );
      //   if (file == null) return;
      //   expect(
      //     file.bytes,
      //     KTestText.filePickerItem.bytes,
      //   );
      //   expect(
      //     file.name,
      //     KTestText.filePickerItem.name,
      //   );
      //   expect(
      //     file.ref,
      //     KTestText.filePickerItem.ref,
      //   );
      //   expect(
      //     file.extension,
      //     KTestText.filePickerItem.extension,
      //   );
      // });

      test('Get Image', () async {
        when(
          mockXFile.name,
        ).thenAnswer(
          (_) => KTestText.filePickerPathItem.name!,
        );
        final file = await dataPickerRepository.getImage;
        expect(
          file,
          isNotNull,
        );
        if (file == null) return;
        expect(
          file.bytes,
          KTestText.filePickerItem.bytes,
        );
        expect(
          file.name,
          KTestText.filePickerPathItem.name,
        );
        expect(
          file.ref,
          KTestText.filePickerPathItem.ref,
        );
        expect(
          file.extension,
          KTestText.filePickerPathItem.extension,
        );
      });

      // test('Get File', () async {
      //   when(
      //     mockPlatformFile.name,
      //   ).thenAnswer(
      //     (_) => KTestText.filePickerPathItem.name!,
      //   );
      //   final file = await dataPickerRepository.getFile;
      //   expect(
      //     file,
      //     isNotNull,
      //   );
      //   if (file == null) return;
      //   expect(
      //     file.bytes,
      //     KTestText.filePickerItem.bytes,
      //   );
      //   expect(
      //     file.name,
      //     KTestText.filePickerPathItem.name,
      //   );
      //   expect(
      //     file.ref,
      //     KTestText.filePickerPathItem.ref,
      //   );
      //   expect(
      //     file.extension,
      //     KTestText.filePickerPathItem.extension,
      //   );
      // });

      // test('Get File with bytes NULL', () async {
      //   when(
      //     mockPlatformFile.name,
      //   ).thenAnswer(
      //     (_) => KTestText.filePickerPathItem.name!,
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
            KTestText.filePickerItem.image(KTestText.downloadURL);

        expect(imageMdeol.downloadURL, KTestText.downloadURL);

        expect(imageMdeol.name, KTestText.filePickerItem.name);

        expect(imageMdeol.ref, KTestText.filePickerItem.ref);

        expect(imageMdeol.type, KTestText.filePickerItem.extension);
      });

      test('Get Resume Model', () {
        final imageMdeol =
            KTestText.filePickerItem.resume(KTestText.downloadURL);

        expect(imageMdeol.downloadURL, KTestText.downloadURL);

        expect(imageMdeol.name, KTestText.filePickerItem.name);

        expect(imageMdeol.ref, KTestText.filePickerItem.ref);

        expect(imageMdeol.type, KTestText.filePickerItem.extension);
      });
    });
  });
}
