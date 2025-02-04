import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/shared_dart.dart';

@Singleton(
  as: ICompanyCacheRepository,
  env: [Config.business],
)
class CompanyCacheRepository implements ICompanyCacheRepository {
  CompanyCacheRepository({
    required SharedPrefencesRepository sharedPrefencesRepository,
  }) : _sharedPrefencesRepository = sharedPrefencesRepository;
  final SharedPrefencesRepository _sharedPrefencesRepository;

  static const companyCacheId = '__compnay_cache_id__';

  @visibleForTesting
  static const userEmailsCacheKey = '__user_company_user_emails_cache_key__';
  @visibleForTesting
  static const nameCacheKey = '__user_company_name_cache_key__';
  @visibleForTesting
  static const publicNameCacheKey = '__user_company_public_name_cache_key__';
  @visibleForTesting
  static const codeCacheKey = '__user_company_code_cache_key__';
  @visibleForTesting
  static const linkCacheKey = '__user_company_link_cache_key__';

  @override
  CompanyModel get getFromCache {
    final cacheUserEmails =
        _sharedPrefencesRepository.getStringList(userEmailsCacheKey);
    final companyName = _sharedPrefencesRepository.getString(nameCacheKey);
    final publicName = _sharedPrefencesRepository.getString(publicNameCacheKey);
    final code = _sharedPrefencesRepository.getString(codeCacheKey);
    final link = _sharedPrefencesRepository.getString(linkCacheKey);
    return CompanyModel(
      id: companyCacheId,
      userEmails: cacheUserEmails ?? const [],
      companyName: companyName,
      publicName: publicName,
      code: code,
      link: link,
    );
  }

  @override
  void saveToCache({
    required CompanyModel company,
    required CompanyModel previousCompany,
  }) {
    if (company.userEmails != previousCompany.userEmails) {
      _sharedPrefencesRepository.setStringList(
        key: userEmailsCacheKey,
        value: company.userEmails,
      );
    }
    if (company.companyName != null &&
        company.companyName != previousCompany.companyName) {
      _sharedPrefencesRepository.setString(
        key: nameCacheKey,
        value: company.companyName!,
      );
    }
    if (company.code != null && company.code != previousCompany.code) {
      _sharedPrefencesRepository.setString(
        key: codeCacheKey,
        value: company.code!,
      );
    }
    if (company.publicName != null &&
        company.publicName != previousCompany.publicName) {
      _sharedPrefencesRepository.setString(
        key: publicNameCacheKey,
        value: company.publicName!,
      );
    }
    if (company.link != null && company.link != previousCompany.link) {
      _sharedPrefencesRepository.setString(
        key: linkCacheKey,
        value: company.link!,
      );
    }
  }

  @override
  void cleanCache() {
    _sharedPrefencesRepository
      ..remove(userEmailsCacheKey)
      ..remove(nameCacheKey)
      ..remove(codeCacheKey)
      ..remove(publicNameCacheKey)
      ..remove(linkCacheKey);
  }
}
