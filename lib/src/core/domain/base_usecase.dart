import 'package:fpdart/fpdart.dart';
import '../errors/app_failure.dart';

typedef AsyncResult<S, F> = Future<Either<S, F>>;

abstract class BaseUsecase<Input, Output extends Object> {
  AsyncResult<Output, AppFailure> call(Input param);
}

abstract class BaseUsecaseNoParam<Output extends Object?> {
  AsyncResult<Output, AppFailure> call();
}
