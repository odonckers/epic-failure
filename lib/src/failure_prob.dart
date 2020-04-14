part of epic_failure;

class FailureProb extends Equatable {
  final Type type;
  final num code;

  const FailureProb(
    this.type, {
    @required this.code,
  });

  @override
  List<Object> get props => [type, code];
}
