// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_collection_literal

import 'package:veteranam/shared/shared.dart';

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
  static const questionTitle = [
    'Як мені знайти роботу за допомогою цього сайту?',
    'Де я можу використати знижки і купони?',
    'Як інформація потрапляє на ваш веб-сайт?',
    'Які документи мені потрібно показати, щоб отримати допомогу від партнерів?',
  ];
  static const questionSubtitle =
      'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи, '
      'таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні '
      'ресурси. Виберіть свою область інтересів та регіон, і шукайте '
      'вакансії, які відповідають вашим критеріям.';
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

  static final discountModel = DiscountModel(
    id: '',
    userId: '',
    company: 'Ескулаб',
    companyEN: 'Ecsculab',
    link: 'https://esculab.com/',
    discount: [10],
    title:
        '20% знижки на аналізи для військових та людей, які внутрішньо переміщені.',
    categoryEN: ['Medical'],
    category: ['Медицина'],
    subcategoryEN: ['Analyses'],
    subcategory: ['Аналізи'],
    // eligibility: 'Військовослужбовці та ВПО',
    description: 'Пропозиція діє у всіх відділеннях лабораторії.',
    requirements:
        'Військовим - наявність документу, що підтверджує  професійну',
    territory: 'Всі відділення лабораторії.',
    location: ['Вся Україна'],
    expiration: 'Діє постійно',
    exclusions:
        '- при замовленні досліджень та оплаті їх онлайн на сайті Ескулаб;',
    phoneNumber: '+380 800 503 680',
    directLink:
        'https://esculab.com/20-vidsotkiv-na-analizy-dlya-viyskovyh-ta-lyudey-yaki-vnutrishno-peremishcheni',
    dateVerified: ExtendedDateTime.current,
    userName: 'Anonymous',
    titleEN:
        '20% discount on tests for military personnel and internally displaced persons.',
    // eligibilityEN: 'Military personnel and internally displaced persons',
    descriptionEN: 'The offer is valid in all branches of the laboratory.',
    requirementsEN:
        'Military personnel - presence of a document confirming professional status',
    territoryEN: 'All branches of the laboratory.',
    exclusionsEN:
        '- when ordering tests and paying for them online on the Esculab website;',
    expirationEN: 'It works all the time',
    locationEN: ['All Ukraine'],
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
    title: 'PATRIOT UA',
    description:
        'Державна установа у сфері управління Міністерства у справах ветеранів. Державний провайдер сервісу реінтеграції ветеранів до продуктивного цивільного життя.',
    link: 'https://veteranfund.com.ua/',
    projectsLink: 'https://veteranfund.com.ua/projects/',
    titleEN: 'PATRIOT UA',
    descriptionEN:
        'A state institution under the management of the Ministry of Veterans Affairs. A state provider of services for reintegrating veterans into productive civilian life.',
    // teamPartnersLink: 'https://veteranfund.com.ua/about/team/',
    // email: 'info@veteranfund.mva.gov.ua',
    // phoneNumber: '+380 (98) 009 48 72',
    // size: 48,
    // registered: 'Ukraine registered',
    // domain: 'Ветерани',
  );
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
  static const String authChange = 'AuthenticationStatusChanged:';
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
  static const String site = 'https://veteranam.info';
  static List<String> get routes => [
        KRoute.discounts.name,
        KRoute.support.name,
        KRoute.settings.name,
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
