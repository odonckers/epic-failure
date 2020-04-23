part of epic_failure;

class EpicFailure<T> extends Equatable {
  final T priority;
  final FailureCode code;
  final String name;

  const EpicFailure({
    this.priority,
    this.code,
    this.name,
  });

  @override
  List<Object> get props => [priority, code, name];
}
