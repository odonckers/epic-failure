import 'package:epic_failure/epic_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'failure_manager_impl.dart';

abstract class FailureManager {
  static FailureManager _instance;

  /// Access to the singular instance of `FailureManager`
  static FailureManager get instance => _instance ??= _FailureManagerImpl();

  /// Short form to access the singular instance of `FailureManager`
  static FailureManager get I => instance;

  EpicFailure get undeterminedFailure;
  List<_PredeterminedFailure> get predeterminedFailures;

  void setUndeterminedFailure<T>(EpicFailure<T> undeterminedFailure);
  void register<T>({
    @required T priority,
    @required List<FailureCode> codes,
    String name,
    String message,
    OnFailureThrown onFailure,
  });
  EpicFailure<T> generateEpicFailure<T>(Object object, StackTrace stack);
}
