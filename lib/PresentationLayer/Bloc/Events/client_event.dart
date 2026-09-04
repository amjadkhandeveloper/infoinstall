// Abstract base class for defining loign-related events
abstract class ClientEvent {}

// Event class for triggering the fetching login details valid
class FetchClient extends ClientEvent {
  final String clientID;

  FetchClient({required this.clientID});
}
