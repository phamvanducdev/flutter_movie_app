import 'package:flutter/material.dart';
import 'package:flutter_movie_app/domain/repository/auth_repository.dart';
import 'package:flutter_movie_app/presentation/login/login_bloc.dart';
import 'package:flutter_movie_app/shared/widgets/app_button_outline.dart';
import 'package:flutter_movie_app/shared/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<AuthRepository, LoginBLoC>(
          update: (context, repository, previous) => previous ?? LoginBLoC(authRepository: repository),
          dispose: (_, bLoC) => bLoC.dispose(),
        ),
      ],
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBLoC _bLoC;

  @override
  void initState() {
    super.initState();
    _bLoC = context.read<LoginBLoC>();
  }

  void onHandleLogin(BuildContext context) {
    _bLoC.onLogin(
      onSuccess: () {
        Navigator.pop(context);
      },
      onFailed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[400],
            content: const Text("Login failed!\nPlease re-check your email & password."),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(
                'assets/icons/ic_back.svg',
                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
            title: const Text(
              'Login',
              style: TextStyle(color: Colors.black, fontSize: 16.0, fontFamily: 'Merriweather'),
            ),
          ),
          body: KeyboardDismisser(
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 32.0),
                              StreamBuilder<bool>(
                                stream: _bLoC.isValidateStream,
                                builder: (context, snapshot) {
                                  final isValidate = snapshot.data ?? true;
                                  return AppTextField(
                                    onChanged: (value) => _bLoC.onChangeEmail(value),
                                    textLabel: 'Email',
                                    textHint: 'email@gmail.com',
                                    textError: isValidate ? null : 'Invalid email format',
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.emailAddress,
                                    maxLines: 1,
                                  );
                                },
                              ),
                              AppTextField(
                                onChanged: (value) => _bLoC.onChangePassword(value),
                                onSubmitted: (value) => onHandleLogin(context),
                                textLabel: 'Password',
                                textHint: '********',
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.visiblePassword,
                                maxLines: 1,
                                maxLength: 8,
                              ),
                              const SizedBox(height: 24.0),
                              StreamBuilder<bool>(
                                stream: _bLoC.isEnableLoginButtonStream,
                                builder: (streamBuilderContext, snapshot) {
                                  final isValidate = snapshot.data ?? false;
                                  return SizedBox(
                                    width: double.infinity,
                                    child: AppButtonOutline(
                                      onPressed: isValidate ? () => onHandleLogin(context) : null,
                                      text: 'Login',
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder<bool>(
          stream: _bLoC.isLoadingStream,
          builder: (context, snapshot) {
            return snapshot.data == true
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.0),
                    ),
                  )
                : Container();
          },
        )
      ],
    );
  }
}
