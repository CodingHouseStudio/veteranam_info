class RouteItem {
  const RouteItem({required this.path, required this.name});

  final String path;
  final String name;
}

class KRouteStatic {
  static const RouteItem home = RouteItem(path: '/', name: 'Home');
  static const RouteItem information = RouteItem(
    path: 'information',
    name: 'Information',
  );
  static const RouteItem discounts = RouteItem(
    path: 'discounts',
    name: 'Discounts',
  );
  static const RouteItem story = RouteItem(
    path: 'story',
    name: 'Story',
  );
  static const RouteItem work = RouteItem(
    path: 'work',
    name: 'Work',
  );
  static const RouteItem profile = RouteItem(
    path: 'profile',
    name: 'Profile',
  );
  static const RouteItem investors = RouteItem(
    path: 'investors',
    name: 'Investors',
  );
}
