import 'package:equatable/equatable.dart';

class Pokemon extends Equatable{
  final String name;
  final String url;

  const Pokemon({required this.name, required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => [name, url];
}