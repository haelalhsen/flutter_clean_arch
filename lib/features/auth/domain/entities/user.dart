import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String username;
  final String password;
  const User({required this.username, required this.password,});

  @override
  // TODO: implement props
  List<Object?> get props => [username,password];
}