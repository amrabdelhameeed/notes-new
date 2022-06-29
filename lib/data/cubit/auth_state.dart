part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginWithGoogleSuccess extends AuthState {}

class LoginWithGoogleFailed extends AuthState {}

class UploadNoteSuccess extends AuthState {}

class UpdateNoteSuccess extends AuthState {}

class UploadNoteFailed extends AuthState {}

class DeletedNoteSuccess extends AuthState {}

class GetNoteSuccess extends AuthState {}
