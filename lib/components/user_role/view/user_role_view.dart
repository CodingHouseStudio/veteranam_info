import 'package:flutter/material.dart';
import 'package:veteranam/components/user_role/user_role.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class UserRoleScreen extends StatelessWidget {
  const UserRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UserRoleBodyWidget(key: UserRoleKeys.screen);
  }
}
