import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/strings/failures.dart';
import '../../../../core/error/failures.dart';
import '../../domain/use_cases/login.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({
    required this.loginUseCase,
  }) : super(AuthInitial());

  static AuthCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  GlobalKey<FormState>? loginFormKey=GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  Future<void> loginUser() async {
    if (loginFormKey!.currentState!.validate()) {
      emit(AuthLoading());
     loginUseCase(
        usernameTextEditingController.text,
        passwordTextEditingController.text,
      ).then((response) {
        response.fold(
                (failure) =>  emit(AuthError(message: _mapFailureToMessage(failure))),
                (user) => emit(AuthSuccess()),
        );
      });
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}
