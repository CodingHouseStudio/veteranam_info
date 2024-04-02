import 'package:kozak/shared/shared.dart';

abstract class KAppText {
  static const String logo = 'Veteran';
  static const String enterButtonText = 'Увійти';
  static const String searchTextFieldHint = 'Пошук...';
  static const String filterItemResetAll = 'Скинути фільтри';
  static const String nickname = '@veteran';
  static const String email = 'example@gmail.com';
  static const String anonymous = 'Бути анонімом';
  static const String description =
      'Якщо ви робите свій профіль анонімним, на вашій сторінці не\n'
      'буде відображатися персональна інформація, тільки\nnickname.';
  static const String userName = 'Володимир Левандовський';
  static const String messageTextFieldHint = 'Напишіть Ваше повідомлення';
  static const String nameTextFieldHint = "Напишіть ваще ім'я";
  static const String footerAboutUs = 'Про нас';
  static const String footerContact = 'Контакти';
  static const String footerConsultationOnline = 'Консультація онлайн';
  static const String footerStories = 'Історії';
  static const String footerDiscountsCoupons = 'Знижки і купони';
  static const String footerMyProfiel = 'Мій профіль';
  static const String inputMassage = 'Напишіть Ваше повідомлення';
  static const String footerWork = 'Робота';
  static const String footerInformation = 'Інформація';
  static const String footerForInvestors = 'Для інвесторів';
  static const String storyCardButtonDetail = 'Детальніше';
  static const String storyCardButtonNotDetail = 'Сховати';
  static const String questionTitle =
      'Як мені знайти роботу за допомогою цього сайту?';
  static const String questionSubtitle =
      'Використовуйте веб-сайти спеціалізованих сервісів для пошуку роботи, '
      'таких як Indeed, LinkedIn, Glassdoor, Monster, або регіональні '
      'ресурси. Виберіть свою область інтересів та регіон, і шукайте '
      'вакансії, які відповідають вашим критеріям.';
  static const String errorTitle = 'Помилка';
  static const String error = 'Помилка при завнтаженні сторінки';
  static const String workRespondButton = 'Відгукнутись';

  static const buttonsText = [
    [
      KAppText.footerAboutUs,
      KAppText.footerForInvestors,
      KAppText.footerContact,
    ],
    [
      KAppText.footerStories,
      KAppText.footerDiscountsCoupons,
      KAppText.footerMyProfiel,
    ],
    [
      KAppText.footerWork,
      KAppText.footerInformation,
      KAppText.footerConsultationOnline,
    ],
  ];

  static final routes = [
    ['', '${KRoute.home.path}${KRoute.investors.path}', ''],
    [
      '${KRoute.home.path}${KRoute.story.path}',
      '${KRoute.home.path}${KRoute.discounts.path}',
      '${KRoute.home.path}${KRoute.profile.path}',
    ],
    [
      '${KRoute.home.path}${KRoute.work.path}',
      '${KRoute.home.path}${KRoute.information.path}',
      '',
    ],
  ];
}

abstract class KMockText {
  static const dropDownList = [
    'Житомир',
    'Львів',
    'Київ',
    'Жовква',
    'Трускавець',
    'Стебник',
  ];
  static const filter = ['Пільги', 'Житло', 'Гарячі лінії'];
  static final storyDate = DateTime(2024, 03, 12);
  static const userName = 'Anonim23456';
  static const emial = 'example@gmail.com';
  static const workTitle = 'Комплектувальник товару в магазин';
  static const workPrice = '12000 грн +%';
  static const workCity = 'м.Одеса';
  static const workEmployer = 'ТОВ Сільпо';
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

  static const story =
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
  static const String storyImage =
      'https://static.vecteezy.com/system/resources/thumbnails/008/492/251/small/back-to-school-illustration-cartoon-character-children-kid-png.png';
}
