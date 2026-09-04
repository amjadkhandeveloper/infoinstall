// Abstract base class for defining loign-related events
import 'package:infoinstall/DomainLayer/Entities/profile_entity.dart';

abstract class ProfileEvent {}

// Event class for triggering the fetching login details valid
class FetchProfile extends ProfileEvent {
  ProfileRequest profileRequest;

  FetchProfile({required this.profileRequest});
}
