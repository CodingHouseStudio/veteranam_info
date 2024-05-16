// ignore_for_file: library_private_types_in_public_api

/// COMMENT: Class has path and name for all screens
class _RouteItem {
  const _RouteItem({required this.path, required this.name});

  final String path;
  final String name;
}

abstract class KRoute {
  static const _RouteItem home = _RouteItem(path: '/', name: 'Home');
  static const _RouteItem information = _RouteItem(
    path: 'information',
    name: 'Information',
  );
  static const _RouteItem discounts = _RouteItem(
    path: 'discounts',
    name: 'Discounts',
  );
  static const _RouteItem story = _RouteItem(
    path: 'story',
    name: 'Story',
  );
  static const _RouteItem work = _RouteItem(
    path: 'work',
    name: 'Work',
  );
  static const _RouteItem profile = _RouteItem(
    path: 'profile',
    name: 'Profile',
  );
  static const _RouteItem investors = _RouteItem(
    path: 'investors',
    name: 'Investors',
  );
  static const _RouteItem aboutUs = _RouteItem(
    path: 'aboutUs',
    name: 'AboutUs',
  );
  static const _RouteItem consultation = _RouteItem(
    path: 'consultation',
    name: 'Consultation',
  );
  static const _RouteItem contact = _RouteItem(
    path: 'contact',
    name: 'Contact',
  );
  static const _RouteItem login = _RouteItem(
    path: '/login',
    name: 'Login',
  );
  static const _RouteItem signUp = _RouteItem(
    path: '/signUp',
    name: 'SignUp',
  );
  static const _RouteItem thanks = _RouteItem(
    path: '/thanks',
    name: 'Thanks',
  );
  static const _RouteItem questionsForm = _RouteItem(
    path: '/questionsForm',
    name: 'QuestionsForm',
  );
  static const _RouteItem workEmployee = _RouteItem(
    path: 'employee',
    name: 'Employee',
  );
  static const _RouteItem workRespond = _RouteItem(
    path: 'respond',
    name: 'Respond',
  );
  static const _RouteItem employer = _RouteItem(
    path: 'employer',
    name: 'Employer',
  );
  static const _RouteItem profileSaves = _RouteItem(
    path: 'saves',
    name: 'Saves',
  static const _RouteItem storyAdd = _RouteItem(
    path: 'add',
    name: 'Add',
  );
}
