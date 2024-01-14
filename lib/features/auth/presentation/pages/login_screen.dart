import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_clean_arch/features/pokemons/presentation/pages/pokemons_screen.dart';

import '../../../../config/strings/strings_enum.dart';
import '../../../../core/utils/general_helper.dart';
import '../../../../core/widgets/custom_text_input_widget.dart';
import '../../../../core/widgets/general_button_widget.dart';
import '../../../../injection_container.dart';
import '../manager/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _bloc = sl<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: GeneralHelper.of(context).onWillPop,
      child: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              GeneralHelper.of(context).showLoadingDialog();
            }else if(state is AuthError){
              Navigator.pop(context);
              GeneralHelper.of(context).showErrorMessage(state.message);
            }else if(state is AuthSuccess){
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PokemonsScreen()));
            }
          },
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 90.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 12.h,
                          ),
                          Icon(
                            Icons.account_balance_outlined,
                            size: 40.sp,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          formWidget(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formWidget(BuildContext context) {
    return Form(
      key: _bloc.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.logIn,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 12,
          ),
          CustomTextInput(
            controller: _bloc.usernameTextEditingController,
            maxLines: 1,
            validationMessage: Strings.thisFieldIsRequired,
            isEnabled: true,
            validate: true,
            hint: Strings.username,
          ),
          const SizedBox(
            height: 12,
          ),
          CustomTextInput(
            controller: _bloc.passwordTextEditingController,
            maxLines: 1,
            validationMessage: Strings.thisFieldIsRequired,
            isEnabled: true,
            validate: true,
            hint: Strings.password,
          ),
          const SizedBox(
            height: 12,
          ),
          GeneralButton(
            color: Colors.blue,
            borderColor: Colors.blue,
            textColor: Colors.white,
            text: Strings.logIn.toUpperCase(),
            height: 12.w,
            onTap: () {
              _bloc.loginUser();
            },
          ),
        ],
      ),
    );
  }
}
