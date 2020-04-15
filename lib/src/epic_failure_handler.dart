import 'package:epic_failure/epic_failure.dart';

part 'epic_failure_handler_impl.dart';

abstract class EpicFailureHandler {
  static EpicFailureHandler _instance;

  /// Access to the instance of `FailureHandler`
  static EpicFailureHandler get instance {
    _instance ??= _FailureHandlerImpl();
    return _instance;
  }

  /// Short form to access the instance of `FailureHandler`
  static EpicFailureHandler get I => instance;

  /// Sets a default `Failure` that will be returned when there are no preset
  /// probabilities equivalent to the error thrown.
  void setUndeterminedFailure(EpicFailure undeterminedFailure);

  /// Registers a single `FailurePrint` that will be checked for probabilities
  /// equivelant to the error passed into `encounteredFailure`.
  void registerFailurePrint(EpicFailurePrint failurePrint);

  /// Similar to `registerFailurePrint()` but registers multiple at one time.
  void registerFailurePrints(List<EpicFailurePrint> failurePrints);

  /// Call inside of a `try {} catch (e) {}` block and pass the exception or
  /// error into the function. It will return a `Failure` that was blueprinted
  /// by a `FailurePrint` object and had a probability equivelent to the passed
  /// object.
  EpicFailure encounteredFailure(Object object);
}
