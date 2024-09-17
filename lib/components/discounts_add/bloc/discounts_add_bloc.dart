import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

part 'discounts_add_event.dart';
part 'discounts_add_state.dart';
part 'discounts_add_bloc.freezed.dart';

@Injectable(env: [Config.business])
class DiscountsAddBloc extends Bloc<DiscountsAddEvent, DiscountsAddState> {
  DiscountsAddBloc({
    required IDiscountRepository discountRepository,
  })  : _discountRepository = discountRepository,
        super(
          const _Initial(
            cityList: [],
            categoryList: [],
            category: MessageFieldModel.pure(),
            city: CitiesFieldModel.pure(),
            period: MessageFieldModel.pure(),
            title: MessageFieldModel.pure(),
            discounts: DiscountsFieldModel.pure(),
            link: LinkFieldModel.pure(),
            description: MessageFieldModel.pure(),
            exclusions: MessageFieldModel.pure(),
          ),
        ) {
    on<_Started>(_onStarted);
  }
  final IDiscountRepository _discountRepository;

  Future<void> _onStarted(
    _Started event,
    Emitter<DiscountsAddState> emit,
  ) async {
    final discounts = await _discountRepository.getDiscountItems().first;

    final uniqueCategories =
        discounts.expand((discount) => discount.category).toSet().toList();

    final uniqueLocations = discounts
        .expand((discount) => discount.location ?? <String>[])
        .toSet()
        .toList();

    emit(
      _Initial(
        cityList: uniqueLocations,
        categoryList: uniqueCategories,
        category: const MessageFieldModel.pure(),
        city: const CitiesFieldModel.pure(),
        period: const MessageFieldModel.pure(),
        title: const MessageFieldModel.pure(),
        discounts: const DiscountsFieldModel.pure(),
        link: const LinkFieldModel.pure(),
        description: const MessageFieldModel.pure(),
        exclusions: const MessageFieldModel.pure(),
      ),
    );
  }
}
