import 'package:flutter/material.dart';
import 'package:flutter_movie_app/domain/entity/user_info.dart';
import 'package:flutter_movie_app/presentation/home/home_bloc.dart';
import 'package:flutter_movie_app/shared/widgets/app_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final Function() onLogin;
  final Function() onLogout;

  const ProfilePage({
    super.key,
    required this.onLogin,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder<UserInfo?>(
        stream: context.read<HomeBLoC>().userLoggedStream,
        builder: (context, snapshot) {
          final userInfo = snapshot.data;
          if (userInfo == null) {
            return _notLoggedBuilder(context);
          }
          return _userProfileBuilder(context, userInfo);
        },
      ),
    );
  }

  _notLoggedBuilder(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: 100.0),
          const Text(
            'You are not Logged in!',
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
          TextButton(
            onPressed: onLogin,
            child: const Text(
              'Go to Login',
              style: TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  _userProfileBuilder(BuildContext context, UserInfo userInfo) {
    const double avatarSize = 100.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.1,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'Merriweather'),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/ic_close.svg',
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/ic_logout.svg',
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              width: 20.0,
            ),
            onPressed: () => onLogout(),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(avatarSize / 2),
                child: const AppNetworkImage(
                  imageUrl: 'https://xsgames.co/randomusers/assets/avatars/male/5.jpg',
                  width: avatarSize,
                  height: avatarSize,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                userInfo.email ?? 'N/A',
                style: TextStyle(color: Colors.blueGrey[400], fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
