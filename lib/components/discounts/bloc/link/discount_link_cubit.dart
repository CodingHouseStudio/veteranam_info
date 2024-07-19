import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared.dart';

@Injectable()
class DiscountLinkCubit extends Cubit<LinkFieldModel> {
  DiscountLinkCubit({
    required IDiscountRepository discountRepository,
  })  : _discountRepository = discountRepository,
        super(const LinkFieldModel.pure());
  final IDiscountRepository _discountRepository;
  void updateLink(String link) {
    final linkFieldModel = LinkFieldModel.dirty(link);
    emit(linkFieldModel);
  }
  Future<void> sendLink() async{
    _discountRepository.
  }
}
