part of epic_failure;

class EpicPrint<T> extends Equatable {
  final T priority;
  final List<EpicCheck> checks;
  final String name;
  final OnFailureThrown onFailure;

  const EpicPrint({
    @required this.priority,
    @required this.checks,
    this.name,
    this.onFailure,
  });

  @override
  List<Object> get props => [priority, checks, name, onFailure];
}
