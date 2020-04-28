part of epic_failure;

class EpicFailure<T> extends Equatable {
  const EpicFailure({
    this.priority,
    this.code,
    this.name,
    this.message,
  });

  final T priority;
  final FailureCode code;
  final String name;
  final String message;

  @override
  List<Object> get props => [priority, code, name, message];
}
