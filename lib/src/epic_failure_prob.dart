part of epic_failure;

class EpicFailureProb extends Equatable {
  final Type type;
  final num code;

  const EpicFailureProb(
    this.type, {
    @required this.code,
  });

  @override
  List<Object> get props => [type, code];
}
