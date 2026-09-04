import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoinstall/DomainLayer/Entities/profile_entity.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Blocs/profile_bloc.dart';
import 'package:infoinstall/PresentationLayer/Bloc/Events/profile_event.dart';
import 'package:infoinstall/PresentationLayer/Bloc/States/profile_state.dart';
import 'package:infoinstall/PresentationLayer/Components/constant.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../Widgets/app_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;
  const ProfileScreen({required this.userId, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;
  late bool result = true;
  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    checkInternetConnection();
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  Future<void> checkInternetConnection() async {
    result = await InternetConnection().hasInternetAccess;
    if (result) {
      ProfileRequest profileRequest = ProfileRequest(userId: widget.userId);
      _profileBloc.add(FetchProfile(profileRequest: profileRequest));
    }
    setState(() {}); // Update UI on change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(heading: "PROFILE"),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            return result
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        ProfileField(
                            label: 'User Name',
                            value: state.profileData.userName),
                        const Divider(),
                        ProfileField(
                            label: 'Name',
                            value: state.profileData.employeeName),
                        const Divider(),
                        ProfileField(
                            label: 'Role', value: state.profileData.roleName),
                        const Divider(),
                        ProfileField(
                            label: 'Mobile No',
                            value: state.profileData.mobileno),
                        const Divider(),
                        ProfileField(
                            label: 'Email', value: state.profileData.emailId),
                        const Divider(),
                        ProfileField(
                            label: 'Address', value: state.profileData.address),
                        const Divider(),
                        const ProfileField(
                            label: 'App Version', value: versionCode),
                        const Divider(),
                        const ProfileField(
                            label: 'Version Date', value: versionDate),
                        const Divider(),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'No internet connection!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await checkInternetConnection();
                          },
                          //initConnectivity(),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
          } else if (state is ProfileError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            if (result) {
              return const Center(
                child: Text('Please wait'),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'No internet connection!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await checkInternetConnection();
                      },
                      //initConnectivity(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              value,
              softWrap: true, // This is true by default
            ),
          ),
        ],
      ),
    );
  }
}
