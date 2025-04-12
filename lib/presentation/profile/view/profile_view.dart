import 'package:flutter/material.dart';
import 'package:flutter_app/common/extension.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/presentation/profile/bloc/profile_cubit.dart';
import 'package:flutter_app/presentation/widgets/text_filed_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/card_custom.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController controllerPass = TextEditingController();
  final TextEditingController controllerPin = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CardCustom(
            child: _Info(context.watch<ProfileCubit>().state.user),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
            title: const Text(
              'Change password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              context.showPopup(() {
                context.read<ProfileCubit>().chagePass(controllerPass.text);
              },
                  'Change password',
                  SecurityTextFieldWidget(
                    controller: controllerPass,
                    hintText: 'Enter your new password',
                  ));
            },
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
            title: const Text(
              'Change pincode',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              context.showPopup(() {
                context.read<ProfileCubit>().chagePin(controllerPin.text);
              },
                  'Change pincode',
                  SecurityTextFieldWidget(
                    controller: controllerPin,
                    hintText: 'Enter your new pincode',
                  ));
            },
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 12,
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              context.read<ProfileCubit>().logout();
            },
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.user);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User name :${user.userName}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Full name :${user.hoTen}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Số tài khoản :${user.stk}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
