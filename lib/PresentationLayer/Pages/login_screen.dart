import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infoinstall/DomainLayer/Entities/login_entity.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/login_bloc.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:infoinstall/PresentationLayer/Pages/dashboard_screen.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';

import '../Bloc/Events/login_event.dart';
import '../Bloc/States/login_state.dart';
import '../Components/color_plattes.dart';
import '../Components/constant.dart';
import '../Components/toast_message.dart';
import '../Widgets/custom_input_field.dart';

const platform = MethodChannel('device_info');

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PrintMixin {
  final storage = const FlutterSecureStorage();
  late bool result = true;
  // FOr user input of username and password this controller are used
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // For visible and hide the password
  bool _hidePassword = true;
  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final Map<String, dynamic> result =
          await platform.invokeMethod('getDeviceInfo');
      p(result.toString());
      return result;
    } on PlatformException catch (e) {
      p("Failed to get device info: '${e.message}'.");
      return <String, dynamic>{};
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    result = await InternetConnection().hasInternetAccess;
    setState(() {}); // Update UI on change
  }

  @override
  Widget build(BuildContext context) {
    // getDeviceInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOGIN",
          style: TextStyle(color: ColorsPlatte.lightgreenshede),
        ),
        backgroundColor: ColorsPlatte.accentColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: size.height * 0.08),
              const SizedBox(
                height: 32,
              ),
              Image.asset(
                'assets/images/ic_infoinsatll_trans.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "INFO INSTALL",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    BlocListener<LoginBloc, LoginState>(
                      listener: (listnerContext, state) async {
                        if (state is LoginLoaded) {
                          await storage.write(key: isLogin, value: '1.0');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(
                                userId: state.user.timeLineData[0].userID,
                                id: state.user.timeLineData[0].iD,
                              ),
                            ),
                          );
                        } else if (state is LoginError) {
                          customToast(
                            message: state.errorMessage,
                            color: Colors.red,
                          );
                        }
                      },
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return Stack(
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Welcome",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  CustomInputField(
                                    controller: userIdController,
                                    hintText: 'User name',
                                    inputFormatter: [
                                      LengthLimitingTextInputFormatter(15),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter username";
                                      } else if (value.length < 4) {
                                        return "Please enter proper username";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  // Password input field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF7F8F9),
                                        border: Border.all(
                                          color: const Color(0xFFE8ECF4),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextFormField(
                                          enableInteractiveSelection: false,
                                          controller: passwordController,
                                          obscureText: _hidePassword,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            hintStyle: const TextStyle(
                                              color: Color(0xFF8391A1),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _hidePassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: const Color(0xFF8391A1),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _hidePassword =
                                                      !_hidePassword;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter password";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MaterialButton(
                                            color: ColorsPlatte.blackColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            onPressed: () async {
                                              if (result) {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  String formattedDate = DateFormat(
                                                          "yyyy-MM-ddTHH:mm:ss.SSS'Z'")
                                                      .format(DateTime.now());
                                                  LoginRequest loginRequest =
                                                      LoginRequest(
                                                    loginName:
                                                        userIdController.text,
                                                    loginPassword:
                                                        passwordController.text,
                                                    userLoginTimeline:
                                                        UserLoginTimeline(
                                                      id: 0,
                                                      userId: 0,
                                                      logoutTime: formattedDate,
                                                      loginlat: 0.0,
                                                      loginlon: 0.0,
                                                      logoutlat: 0.0,
                                                      logoutlon: 0.0,
                                                      distance: 0,
                                                      travelTime: "",
                                                      batteryStatus: 100,
                                                      deviceName: "",
                                                      deviceModel: "",
                                                      cUserId: 0,
                                                    ),
                                                    insertMode: 0,
                                                  );
                                                  await storage.write(
                                                      key: 'username',
                                                      value: userIdController
                                                          .text);
                                                  await storage.write(
                                                      key: 'password',
                                                      value: passwordController
                                                          .text);

                                                  context
                                                      .read<LoginBloc>()
                                                      .add(FetchLogin(
                                                        loginRequest:
                                                            loginRequest,
                                                      ));
                                                }
                                              } else {
                                                customToast(
                                                  message:
                                                      "No internet connection!",
                                                  color: Colors.red,
                                                );
                                                checkInternetConnection();
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                "Login",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                              if (state is LoginLoading)
                                const SizedBox(
                                  height: 250,
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 32,
              // ),
              // const PoweredBy(),
              // SizedBox(height: size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
