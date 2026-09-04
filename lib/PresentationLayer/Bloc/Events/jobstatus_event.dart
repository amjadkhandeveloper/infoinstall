// Abstract base class for defining loign-related events

abstract class JobStatusEvent {}

// Event class for triggering the fetching login details valid
class UpdateJobStatus extends JobStatusEvent {
  final String requestString;
  final int jobStatusId;
  UpdateJobStatus({
    required this.requestString,
    required this.jobStatusId,
  });
}
