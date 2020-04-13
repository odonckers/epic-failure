import 'package:epic_failure/epic_failure.dart';

part 'failure_holder_impl.dart';

abstract class FailureHolder {
  static FailureHolder _instance;

  /// Access to the instance of `EpicFailure`
  static FailureHolder get instance {
    _instance ??= _FailureHolderImpl();
    return _instance;
  }

  /// Short form to access the instance of `EpicFailure`
  static FailureHolder get I => instance;

  /// If you need more than one instance of GetIt you can use `asNewInstance()`
  /// You should prefer to use the `instance` method to access the global
  /// instance of `EpicFailure`.
  factory FailureHolder.asNewInstance() => _FailureHolderImpl();

  /// Sets the basic undetermined failure that will be returned when calling
  /// `encounteredFailure()` with a caught exception and no registered failure
  /// catches it.
  void setUndeterminedFailure(Failure undeterminedFailure);

  /// Registers a `Failure` that will be run through when `encounteredFailure()`
  /// is called and returned if any probabilities are called.
  void registerFailure(Failure failure);

  /// Registers multiple `Failure` objects that will be run through when
  /// `encounteredFailure()` is called and returned if any probabilities are
  /// called.
  void registerFailures(List<Failure> failures);

  /// Call inside of a `try {} catch (e) {}` block and pass the exception or
  /// error into the function. It will return a `Failure` that was registered
  /// and had a `FlutterProb` that was flagged.
  Failure encounteredFailure(Object object);
}
