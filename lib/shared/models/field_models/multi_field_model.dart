// import 'package:formz/formz.dart';

// enum ListFieldModelValidationError { empty }

// class ListFieldModel
//     extends FormzInput<List<String>, ListFieldModelValidationError> {
//   const ListFieldModel.pure() : super.pure(const []);

//   const ListFieldModel.dirty([super.value = const []]) : super.dirty();

//   @override
//   ListFieldModelValidationError? validator(List<String>? value) {
//     if (value == null ||
//         value.isEmpty ||
//         value.every(
//           (element) => element.trim().isEmpty,
//         )) {
//       return ListFieldModelValidationError.empty;
//     }
//     return null;
//   }
// }
