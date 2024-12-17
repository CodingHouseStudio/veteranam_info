// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_collection_literal

import 'package:veteranam/shared/constants/constants_dart.dart';
import 'package:veteranam/shared/extension/extension_constants.dart';
import 'package:veteranam/shared/models/models.dart';

/// COMMENT: Variables with mock text. It's temporary data we change it when add firebase for this elements
abstract class KMockText {
  static const dropDownList = [
    'Житомир',
    'Львів',
    'Київ',
    'Жовква',
    'Трускавець',
    'Стебник',
    'Дніпро',
    'Луцьк',
    'Миколаїв',
    'Суми',
    'Ужгород',
    'Чернігів',
  ];
  static const workCategory = 'Комплектувальник';
  static const facebook = 'Facebook';
  static const donateCardTitle = 'Благодійний фонд '
      '«ПОВЕРНИСЬ ЖИВИМ»';
  static const donateCardSubtitle =
      '«Повернись живим» — це благодійний фонд компетентної допомоги армії, а також громадська організація, яка займається аналітикою у секторі безпеки та оборони, реалізує проєкти з реабілітації ветеранів через спорт.';
  static const userName = 'Володимир Левандовський';
  static const nickname = '@veteran';
  static const email = 'example@gmail.com';
  static const tag = ['Пільги'];
  static const tags = <List<String>?>[
    ['Пільги'],
    ['Гарячі лінії'],
    ['Житло'],
    [],
  ];

  static const tagsDiscount = <List<String>?>[
    ['Медицина'],
    ['Послуги'],
    ['Житло'],
    [],
  ];

  static const workTitle = 'Комплектувальник товару в магазин';
  static const workPrice = '12000 грн +%';
  static const workCity = 'м.Одеса';
  static const workEmployer = 'ТОВ Сільпо';
  static const title = 'Заголовок дуже довгий';
  static const questionTitle =
      TranslateModel(uk: questionTitleUA, en: questionTitleEN);
  static const questionTitleUA =
      'Як мені знайти роботу за допомогою цього сайту?';
  static const questionTitleEN = 'How do I find a job using this site?';
  static const questionSubtitle =
      TranslateModel(uk: questionSubtitleUA, en: questionSubtitleEN);
  static const questionSubtitleUA =
      'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи, '
      'таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні '
      'ресурси. Виберіть свою область інтересів та регіон, і шукайте '
      'вакансії, які відповідають вашим критеріям.';
  static const questionSubtitleEN = 'Use specialized job search websites, '
      'such as Indeed, LinkedIn, Glassdoor, Monster, or regional '
      'resources. Select your area of interest and region, and search for '
      'jobs that match your criteria.';
  static const workDescription = '''
**Ми шукаємо відповідальну та організовану особу на посаду комплектувальника товару в наш магазин.** Це надзвичайно важлива роль, яка допоможе нам забезпечити ефективну роботу нашого магазину та задоволення потреб наших клієнтів.

**Обов'язки:**

* Комплектація товарів згідно замовлень клієнтів та внутрішніх потреб магазину.
* Прийом і перевірка поставок товарів з відповідних постачальників.
* Організація складського простору та зберігання товарів відповідно до внутрішніх стандартів.
* Ведення обліку та інвентаризації товарів.
* Забезпечення чистоти та порядку на складі та в робочому середовищі.

**Вимоги:**

* Досвід роботи у сфері роздрібної торгівлі або складської діяльності вітається, але не є обов'язковим.
* Вміння працювати в команді та ефективно спілкуватися з колегами.
* Відповідальність та уважність до деталей.
* Здатність працювати у швидкотемповому середовищі та дотримуватися встановлених термінів.
* Гнучкість щодо робочого графіку та готовність до виконання змінних годин роботи, включаючи вечірні та вихідні зміни.

**Ми пропонуємо конкурентну заробітну плату, можливості кар'єрного зростання та дружню атмосферу в колективі.**

**Якщо ви зацікавлені у цій позиції та готові приєднатися до нашої команди, будь ласка, надсилайте свої резюме за вказаним нижче адресою електронної пошти.**
''';

  static const cardData =
      'У тихому містечку затишно жив пан Джонс, ветеран війни, '
      'який пройшов через низку важких випробувань на службі. Після '
      'повернення додому він зіткнувся з труднощами в адаптації до '
      'цивільного життя, борючись з посттравматичним стресовим '
      'розладом та відсутністю підтримки.\n\n'
      'Але, незважаючи на всі труднощі, пан Джонс не втратив свою '
      'внутрішню силу та волю до життя. Він активно залучався до '
      'волонтерської діяльності в місцевій громаді, допомагаючи '
      'іншим ветеранам знаходити шлях до відновлення та адаптації.\n\n'
      'Поступово він став опорою для багатьох, поділяючи свої '
      'власні досвід та радіючи від їхніх успіхів. Його '
      'безпосереднього оптимізму та відданості прикладали усі '
      'зусилля для досягнення своєї мети, щоб знову стати '
      'активними членами суспільства.\n\n'
      'Історія пана Джонса стала великим натхненням для багатьох '
      'у містечку. Він показав, що, незважаючи на випробування, '
      'здатність до відновлення та допомога іншим може '
      'принести неймовірну силу та значення у житті.';
  static const discount = 'Знижка 10%';
  static const cityDiscount = 'м.Київ';
  static const serviceDiscount = 'Стоматологічні послуги';
  static const descriptionDiscount =
      'Клініка Happy dentist надає знижки 10% на '
      'всі види послуг для військових і ветеранів.';
  static const dateDiscount = 'Діє з 12.03.2024 по 12.10.2024';
  static const instructionDiscount = 'Записатися на прийом;'
      '\nПоказати документи, що підтверджують участь у бойових діях.';
  static const preInstructionDiscount = 'Щоб отримати потрібно:';

  static const image =
      'https://static.vecteezy.com/system/resources/thumbnails/008/492/251/small/back-to-school-illustration-cartoon-character-children-kid-png.png';

  static const questionModel = QuestionModel(
    id: '0',
    title: questionTitle,
    subtitle: questionSubtitle,
    // navigationLink: 'null',
  );
  static const category = TranslateModel(
    uk: 'Медицина',
    en: 'Medical',
  );

  static const filterItem = FilterItem(KMockText.category, number: 10);

  static final discountModel = DiscountModel(
    id: '',
    userId: '',
    company: const TranslateModel(uk: 'Ескулаб', en: 'Ecsculab'),
    link: 'https://veteranam.info/',
    discount: [10],
    title: const TranslateModel(
      uk: '20% знижки на аналізи для військових та людей, які внутрішньо переміщені.',
      en: '20% discount on tests for military personnel and internally displaced persons.',
    ),
    category: const [category],
    subcategory: const [TranslateModel(uk: 'Аналізи', en: 'Analyses')],
    // eligibility: 'Військовослужбовці та ВПО',
    description: const TranslateModel(
      uk: 'Пропозиція діє у всіх відділеннях[${KAppText.email}}(test) лабораторії.',
      en: 'The offer is valid in all branches of the laboratory.',
    ),
    requirements: const TranslateModel(
      uk: 'Військовим - наявність документу, що підтверджує  професійну',
      en: 'Military personnel - presence of a document confirming professional status',
    ),
    territory: const TranslateModel(
      uk: 'Всі відділення лабораторії.',
      en: 'All branches of the laboratory.',
    ),
    location: const [
      TranslateModel(
        uk: 'Київ',
        en: 'Kyiv',
      ),
    ],
    expiration: const TranslateModel(
      uk: 'До 24 жовтня 2026 р.',
      en: 'Up to October 24, 2026',
    ),
    exclusions: const TranslateModel(
      uk: '- при замовленні досліджень та оплаті їх онлайн на сайті Ескулаб;',
      en: '- when ordering tests and paying for them online on the Esculab website;',
    ),
    eligibility: const [EligibilityEnum.veterans],

    phoneNumber: '+380 800 503 680',
    directLink:
        'https://esculab.com/20-vidsotkiv-na-analizy-dlya-viyskovyh-ta-lyudey-yaki-vnutrishno-peremishcheni',
    dateVerified: ExtendedDateTime.current,
    userName: 'Anonymous',
    status: DiscountState.published,
  );
  static final informationModel = InformationModel(
    id: '',
    title: title,
    news: cardData,
    category: ['Medical'],
    categoryUA: ['Медицина'],
    topic: 'MEDICAL BENEFITS',
    topicUA: 'МЕДИЧНІ ПІЛЬГИ',
    status: 'Healthy',
    fetchDate: DateTime(2024, 06, 07),
    likes: 1,
  );
  static const fundModel = FundModel(
    id: '',
    title: TranslateModel(uk: 'PATRIOT UA', en: 'PATRIOT UA'),
    description: TranslateModel(
      uk: 'Державна установа у сфері управління Міністерства у справах ветеранів. Державний провайдер сервісу реінтеграції ветеранів до продуктивного цивільного життя.',
      en: 'A state institution under the management of the Ministry of Veterans Affairs. A state provider of services for reintegrating veterans into productive civilian life.',
    ),
    link: 'https://veteranfund.com.ua/',
    projectsLink: 'https://veteranfund.com.ua/projects/',
  );
  static const fundDesk = [fundModel, fundModel, fundModel];
  static final storyModel = StoryModel(
    id: '',
    date: ExtendedDateTime.current,
    story: 'У тихому містечку затишно жив пан Джонс, ветеран війни, ',
    userId: '',
  );
}

/// README: Variables with specific text
abstract class KAppText {
  static const String logo = 'VETERANAM';
  static const String exampleEmail = 'example@veteranam.info';
  static const String examplePhone = '+38 099 000 00 00';
  static const String authTokenKey = 'AUTH_TOKEN';
  static const String authChange = 'Authentication Status Changed:';
  static const String backendString = '';
  static const String usernameToken = 'USERNAME_TOKEN';
  static const String madeBy = '© Coding House Studio LLC - 2024';
  static const String email = 'hello@veteranam.info';
  static const String emailScheme = 'mailto';
  static const String veteranamName = 'veteranam.info';
  static const String linkedIn = 'https://www.linkedin.com/company/veteranam/';
  static const String instagram = 'https://www.instagram.com/veteranam_info';
  static const String facebook =
      'https://www.facebook.com/profile.php?id=61560499465895';
  static const String coffee = 'Buy me a Coffee';
  static const String cache = 'local cache';
  static const String server = 'server';
  static const String site = 'https://app.veteranam.info';
  static const String businessSite = 'https://business.veteranam.info';
  static const String appStoreId = '6584519009';
  static const String unknown = 'Unknown';
  static const String veteranamFontName = 'Veteranam';

  static const String androidInstallUrl = 'market://details?id=$_mobAppId';
  static const String iphoneInstallUrl =
      'https://apps.apple.com/app/id$_mobAppId';
  static const String _mobAppId = 'info.veteranam';

  static const String nickname = 'Nickname';

  static const String adminCompanyID = '1';

  static const String ukPrivacyPolicyPath =
      '${_markdownStartPath}privacy_policy_uk.md';
  static const String enPrivacyPolicyPath =
      '${_markdownStartPath}privacy_policy_en.md';
  static const String ukTermsConditions =
      '${_markdownStartPath}terms_conditions_uk.md';
  static const String _markdownStartPath = 'assets/markdown/';

  static const String androidPackageName = 'com.veteranam.package';
  static const String eligibilityAllUA = 'Всі перелічені';
  static const String eligibilityAllEN = 'All of the listed';
  static List<String> get routes => [
        KRoute.discounts.name,
        KRoute.support.name,
        KRoute.settings.name,
        KRoute.login.name,
      ];
  static const deletedFieldId = 'deletedOn';

  static const sublocationUA = 'Вся Україна';
  static const sublocationEN = 'All Ukraine';

  static const sublocation =
      TranslateModel(uk: sublocationUA, en: sublocationEN);
  static const eligibilityAll =
      TranslateModel(uk: eligibilityAllUA, en: eligibilityAllEN);
  static const categoryAll = TranslateModel(uk: 'Все', en: 'All');
  static const allStoresOfChain = TranslateModel(
    uk: 'Всі заклади мережі',
    en: 'All establishments of the chain',
  );
  static const allUkrainOnline =
      TranslateModel(uk: 'Вся Україна (онлайн)', en: 'All of Ukraine (online)');

  static const discountsCategories = [
    'Автосервіс',
    'Військторг',
    'Відпочинок',
    'Житло',
    'Магазини',
    'Медицина',
    'Освіта',
    'Перевезення',
    'Ресторани',
    'Салони краси',
    'Спорт',
  ];
  static const ukrainianAlphabet = [
    'а',
    'б',
    'в',
    'г',
    'ґ',
    'д',
    'е',
    'є',
    'ж',
    'з',
    'и',
    'і',
    'ї',
    'й',
    'к',
    'л',
    'м',
    'н',
    'о',
    'п',
    'р',
    'с',
    'т',
    'у',
    'ф',
    'х',
    'ц',
    'ч',
    'ш',
    'щ',
    'ь',
    'ю',
    'я',
  ];
}
