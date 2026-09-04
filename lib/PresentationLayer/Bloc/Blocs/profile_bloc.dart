// Importing necessary Dart packages for JSON decoding, Flutter BLoC, and HTTP requests
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:infoinstall/DataLayer/Model/profile_model.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/profile_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/profile_state.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';
import 'package:logging/logging.dart';

// Importing custom event and state classes for the profileBloc
import '../../Components/constant.dart';

// BLoC class for handling state management related to fetching and displaying profiles
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with PrintMixin {
  // ProfileBloc(super.initialState);

  //Constructor initializes the ProfileBloc with the initial state and sets up event handling
  ProfileBloc() : super(InitialProfileState()) {
    on<FetchProfile>(_fetchProfile);
  }

  // Private method for handling the FetchProfile event and updating the state accordingly
  _fetchProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    // Checking if the event is of type FetchProfile
    if (event is FetchProfile) {
      // Emitting a loading state to indicate that the profile is being fetched
      emit(ProfileLoading());
      try {
        final ioc = HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
        final httpClient = IOClient(ioc);
        final String url =
            '$infoInstallProductionURL$profileUrlApi${event.profileRequest.userId}';
        logHttpRequest('GET', url);
        final response = await httpClient.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json', // Specify the content type here
          },
          // body: jsonEncode({
          //   'userId': event.profileRequest.userId,
          // }),
        );
        logHttpResponse(response.statusCode, url, body: response.body);
        // Checking if the response status code is OK (200)
        if (response.statusCode == 200) {
          // Decoding the JSON response and creating a ProfileLoaded state with the retrieved data
          // final Map<String, dynamic> decodedResponse =
          //     jsonDecode(response.body);

          final parsed = jsonDecode(response.body);
          final profileData = parsed['data'] as List;
          List<ProfileData> profiles =
              profileData.map((json) => ProfileData.fromJson(json)).toList();
          // ProfileData profileData = ProfileData.fromJson(decodedResponse);
          Logger("parsed json : ");

          if (profiles.isNotEmpty) {
            p("Success Profile");
            final profile = ProfileLoaded(
              stauts: response.statusCode,
              profileData: profiles[0],
              error: [],
            );
            // Emitting the ProfileLoaded state to update the UI with the fetched profile
            emit(profile);
          } else {
            final profile = ProfileError("Failed to load the profile");
            // Emitting the ProfileLoaded state to update the UI with the fetched profile
            emit(profile);
          }
        } else if (response.statusCode == 400) {
          // Decoding the JSON response and creating a ProfileLoaded state with the retrieved data
          // final Map<String, dynamic> decodedResponse =
          //     jsonDecode(response.body);
          // ProfileData profileData = ProfileData.fromJson(decodedResponse);

          // final data = json.decode(response.body);
          final profile = ProfileError("Failed to load the profile");

          // Emitting the ProfileLoaded state to update the UI with the fetched profile
          emit(profile);
        } else {
          // Emitting an error state if the response status code is not OK
          emit(ProfileError('Failed to load profile'));
        }
      } catch (e) {
        Logger("Catch Exception in parsing $e");
        // Emitting an error state if an exception occurs during the fetching process
        emit(ProfileError('Error: $e'));
      }
    }
  }
}
