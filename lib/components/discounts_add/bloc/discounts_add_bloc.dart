import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:veteranam/shared/shared.dart';

part 'discounts_add_event.dart';
part 'discounts_add_state.dart';
part 'discounts_add_bloc.freezed.dart';

class DiscountsAddBloc extends Bloc<DiscountsAddEvent, DiscountsAddState> {
  DiscountsAddBloc()
      : super(const _Initial(
            // discountModel: discountModel,
            cityList: [],
            categoryList: [])) {
    on<DiscountsAddEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
