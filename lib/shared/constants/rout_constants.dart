// ignore_for_file: library_private_types_in_public_api

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
}
