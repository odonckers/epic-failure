part of epic_failure;

class FailureCode extends Equatable {
  const FailureCode(
    this.number, {
    this.name,
    @required this.runtimeType,
  });

  final num number;
  final Type runtimeType;
  final String name;

  @override
  List<Object> get props => [number, name, runtimeType];
}
