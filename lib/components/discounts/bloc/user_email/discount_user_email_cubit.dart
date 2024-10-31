// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:freezed_annotation/freezed_annotation.dart' show visibleForTesting;
// import 'package:injectable/injectable.dart';
// import 'package:veteranam/shared/shared.dart';

// @Injectable()
// class DiscountUserEmailCubit extends Cubit<DiscountUserEmailState> {
//   DiscountUserEmailCubit({
//     required IDiscountRepository discountRepository,
//     required IAppAuthenticationRepository appAuthenticationRepository,
//   })  : _discountRepository = discountRepository,
//         _appAuthenticationRepository = appAuthenticationRepository,
//         super(
//           const DiscountUserEmailState(UserEmailEnum.initial),
//         );
//   final IDiscountRepository _discountRepository;
//   final IAppAuthenticationRepository _appAuthenticationRepository;

//   @visibleForTesting
//   static const emailScrollKey = '__email_scroll_count_key__';

//   Future<void> started() async {
//     final result = await _discountRepository
//         .userCanSendUserEmail(_appAuthenticationRepository.currentUser.id);
//     late DiscountUserEmailState userEmailPropery;
//     result.fold(
//       (l) => userEmailPropery =
//           const DiscountUserEmailState(UserEmailEnum.discountEmailNotShow),
//       (r) => userEmailPropery =
//           DiscountUserEmailState(UserEmailEnum.get(r), count: r),
//     );

//     emit(
//       userEmailPropery,
//     );
//   }
// }

// enum UserEmailEnum {
//   initial(),
//   discountEmailNotShow(),
//   discountEmailAbandon(text: 'discount_email_abandon'),
//   discountEmailAbandonSecondary(text: 'discount_email_abandon_secondary'),
//   discountEmailAbandonRepeat(text: 'discount_email_abandon_repeat');

//   const UserEmailEnum({this.text});

//   final String? text;

//   static UserEmailEnum get(int count) {
//     if (count < 0) {
//       return UserEmailEnum.discountEmailNotShow;
//     }
//     switch (count) {
//       case 0:
//         return UserEmailEnum.discountEmailAbandon;
//       case 1:
//         return UserEmailEnum.discountEmailAbandonSecondary;
//       default:
//         return UserEmailEnum.discountEmailAbandonRepeat;
//     }
//   }

//   bool get show =>
//       this != UserEmailEnum.initial &&
//       this != UserEmailEnum.discountEmailNotShow;

//   bool get closeEnable => show && this == UserEmailEnum.discountEmailAbandon;
// }

// class DiscountUserEmailState extends Equatable {
//   const DiscountUserEmailState(this.value, {this.count});

//   final UserEmailEnum value;
//   final int? count;

//   @override
//   List<Object?> get props => [value, count];
// }
