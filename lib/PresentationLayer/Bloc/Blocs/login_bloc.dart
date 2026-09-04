// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

// Importing custom event and state classes for the loginBloc
import '../../../DomainLayer/Entities/login_entity.dart';
import '../../Components/constant.dart';
import '../Events/login_event.dart';
import '../States/login_state.dart';

// BLoC class for handling state management related to fetching and displaying logins
class LoginBloc extends Bloc<LoginEvent, LoginState> with PrintMixin {
  // LoginBloc(super.initialState);

  //Constructor initializes the LoginBloc with the initial state and sets up event handling
  LoginBloc() : super(InitialLoginState()) {
    on<FetchLogin>(_fetchLogin);
    on<DoLogout>(_doLogout); // Handles logout events, which was missing
  }

  // Private method for handling the FetchLogin event and updating the state accordingly
  _fetchLogin(LoginEvent event, Emitter<LoginState> emit) async {
    // Checking if the event is of type FetchLogin
    if (event is FetchLogin) {
      // Emitting a loading state to indicate that the login is being fetched
      emit(LoginLoading());
      try {
        Logger(
            "Login request is ${event.loginRequest.loginName} and ${event.loginRequest.loginPassword}");
        // Making an HTTP POST request to the quotable.io API to fetch a random login
        p(jsonEncode({
          'loginName': event.loginRequest.loginName,
          'loginPassword': event.loginRequest.loginPassword,
          'userLoginTimeline': event.loginRequest.userLoginTimeline.toJson(),
          'insertMode': event.loginRequest.insertMode,
        }));
        // Create a HttpClient that ignores bad certificates
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String loginUrl = infoInstallProductionURL + loginUrlApi;
        logHttpRequest('POST', loginUrl, body: {
          'loginName': event.loginRequest.loginName,
          'loginPassword': event.loginRequest.loginPassword,
          'userLoginTimeline': event.loginRequest.userLoginTimeline.toJson(),
          'insertMode': event.loginRequest.insertMode,
        });
        final response = await httpClient.post(
          Uri.parse(loginUrl),
          headers: {
            'Content-Type': 'application/json', // Specify the content type here
          },
          body: jsonEncode({
            'loginName': event.loginRequest.loginName,
            'loginPassword': event.loginRequest.loginPassword,
            'userLoginTimeline': event.loginRequest.userLoginTimeline.toJson(),
            'insertMode': event.loginRequest.insertMode,
          }),
        );

        logHttpResponse(response.statusCode, loginUrl, body: response.body);
        // Checking if the response status code is OK (200)
        if (response.statusCode == 200) {
          p('response status is 200 ');
          // Decoding the JSON response and creating a LoginLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          LoginUser loginUser = LoginUser.fromJson(decodedResponse);
          Logger("parsed json");

          if (loginUser.status == 200) {
            p('login status is 200 ');
            LoginUser loginUser = LoginUser.fromJson(decodedResponse);
            Logger("parsed json");
            p("Success Login");
            final login = LoginLoaded(
              status: loginUser.status,
              user: loginUser,
              error: [],
            );
            // Emitting the LoginLoaded state to update the UI with the fetched login
            emit(login);
          } else {
            LoginErrorUser loginErrorUser =
                LoginErrorUser.fromJson(decodedResponse);
            p('login status is else ');
            final login = LoginError(
              loginErrorUser.message,
            );
            // Emitting the LoginLoaded state to update the UI with the fetched login
            emit(login);
          }
        } else if (response.statusCode == 400) {
          p('response status is 400 ');
          // Decoding the JSON response and creating a LoginLoaded state with the retrieved data
          // final Map<String, dynamic> decodedResponse =
          //     jsonDecode(response.body);
          // LoginUser loginUser = LoginUser.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final login = LoginError(
            "Login failed. Please try again.",
          );

          // Emitting the LoginLoaded state to update the UI with the fetched login
          emit(login);
        } else {
          p('response status is else ');
          // Emitting an error state if the response status code is not OK
          emit(LoginError(
            "Invalid login credential",
          ));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        p('$e');
        // Emitting an error state if an exception occurs during the fetching process
        emit(LoginError('Error: $e'));
      }
    }
  }

// Private method for handling the FetchLogin event and updating the state accordingly
  _doLogout(LoginEvent event, Emitter<LoginState> emit) async {
    // Checking if the event is of type FetchLogin
    if (event is DoLogout) {
      // Emitting a loading state to indicate that the login is being fetched
      emit(LoginLoading());
      try {
        p(jsonEncode({
          'userLoginTimeline': event.logoutRequest.userLogoutTimeline.toJson(),
          'insertMode': event.logoutRequest.insertMode,
        }));
        final String logoutUrl = infoInstallProductionURL + logoutUrlApi;
        logHttpRequest('POST', logoutUrl, body: {
          'userLoginTimeline': event.logoutRequest.userLogoutTimeline.toJson(),
          'insertMode': event.logoutRequest.insertMode,
        });
        final response = await http.post(
          Uri.parse(logoutUrl),
          headers: {
            'Content-Type': 'application/json', // Specify the content type here
          },
          body: jsonEncode({
            'userLoginTimeline':
                event.logoutRequest.userLogoutTimeline.toJson(),
            'insertMode': event.logoutRequest.insertMode,
          }),
        );
        logHttpResponse(response.statusCode, logoutUrl, body: response.body);
        // Checking if the response status code is OK (200)
        if (response.statusCode == 200) {
          // Decoding the JSON response and creating a LoginLoaded state with the retrieved data
          // final Map<String, dynamic> decodedResponse =
          //     jsonDecode(response.body);
          if (response.statusCode == 200) {
            final logoutResponse = jsonDecode(response.body);
            if (logoutResponse['status'] == 200) {
              p("Success logout");
              emit(LogoutLoaded(status: 200, message: "Logout Successful"));
            } else {
              emit(LoginError(logoutResponse['message']));
            }
          } else {
            emit(LoginError(
                'Failed to logout with status code: ${response.statusCode}'));
          }
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a LoginLoaded state with the retrieved data
          final Map<String, dynamic> decodedResponse =
              jsonDecode(response.body);
          LoginUser loginUser = LoginUser.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final login = LoginError(
            loginUser.message.toString(),
          );

          // Emitting the LoginLoaded state to update the UI with the fetched login
          emit(login);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(LoginError('Failed to load login'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(LoginError('Error: $e'));
      }
    }
  }
}
