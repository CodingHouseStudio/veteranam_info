// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_collection_literal

import 'package:kozak/shared/shared.dart';

/// COMMENT: Variables with mock text. It's temporary data we change it when add firebase for this elements
abstract class KMockText {
  static const dropDownList = [
    'Житомир',
    'Львів',
    'Київ',
    'Жовква',
    'Трускавець',
    'Стебник',
  ];
  static const facebook = 'Facebook';
  static const donateCardTitle = 'Благодійний фонд '
      '«ПОВЕРНИСЬ ЖИВИМ»';
  static const donateCardSubtitle =
      '«Повернись живим» — це благодійний фонд компетентної допомоги армії, а також громадська організація, яка займається аналітикою у секторі безпеки та оборони, реалізує проєкти з реабілітації ветеранів через спорт.';
  static const userName = 'Володимир Левандовський';
  static const nickname = '@veteran';
  static const email = 'example@gmail.com';
  static const description =
      'Якщо ви робите свій профіль анонімним, на вашій сторінці не\n'
      'буде відображатися персональна інформація, тільки\nnickname.';
  static final date = DateTime(2024, 03, 12);
  static const userNameAnonim = 'Anonim23456';
  static const emial = 'example@gmail.com';
  static const tags = <List<String>?>[
    ['Пільги', 'Гарячі лінії'],
    ['Житло'],
    [],
    ['Житло', 'Гарячі лінії'],
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
  static const previousPage = 'Попередня';
  static const nextPage = 'Наступна';
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
  static const instructionDiscount = 'Щоб отримати потрібно: \nЗаписатися на'
      ' прийом;\nПоказати документи, що підтверджують участь у бойових діях.';

  static const image =
      'https://static.vecteezy.com/system/resources/thumbnails/008/492/251/small/back-to-school-illustration-cartoon-character-children-kid-png.png';
}

/// README: Variables with specific text
abstract class KAppText {
  static const String authTokenKey = 'AUTH_TOKEN';
  static const String authChange = 'AuthenticationStatusChanged:';
  static const String backendString = '';
  static const String usernameToken = 'USERNAME_TOKEN';
  static final routes = [
    [
      KRoute.aboutUs.name,
      KRoute.investors.name,
      KRoute.contact.name,
    ],
    [
      KRoute.story.name,
      KRoute.discounts.name,
      KRoute.profile.name,
    ],
    [
      KRoute.work.name,
      KRoute.information.name,
      KRoute.consultation.name,
    ],
  ];
}
