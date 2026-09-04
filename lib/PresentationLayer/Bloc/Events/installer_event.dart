// Abstract base class for defining loign-related events
abstract class InstallerEvent {}

// Event class for triggering the fetching login details valid
class FetchInstaller extends InstallerEvent {
  final String installerID;

  FetchInstaller({required this.installerID});
}
