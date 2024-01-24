import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/features/account/logic/account_bloc.dart';
import 'package:myapp/src/router/coordinator.dart';
import 'package:myapp/widgets/card/card.dart';
import 'package:myapp/widgets/card/card_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            XCardSection(
              children: [
                XCardSectionButton(
                  title: 'Edit profile',
                  onTap: () {
                    AppCoordinator.showEditProfile();
                  },
                ),
              ],
            ),
            const SizedBox(height: 46),
            InkWell(
              onTap: () async {
                final result =
                    await context.read<AccountBloc>().onLogOut(context);
                if (result == true) {
                  // ignore: use_build_context_synchronously
                  AppCoordinator.showSignInScreen();
                }
              },
              child: const XCard(
                child: Text(
                  'Logout',
                  style: TextStyle(color: Color(0xFFC94A28)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
