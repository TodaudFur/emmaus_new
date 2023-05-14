import 'package:emmaus_new/ui/widgets/user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import 'login_widget.dart';

class UserBox extends StatelessWidget {
  UserBox({Key? key}) : super(key: key);

  final userCR = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (userCR.userModel.userId != 0)
          ? UserInfoWidget()
          : const LoginWidget(),
    );
  }
}
