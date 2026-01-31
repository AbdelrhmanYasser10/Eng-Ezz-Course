part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class GetAllUsersLoading extends ChatsState {}
final class GetAllUsersSuccessfully extends ChatsState {}
final class GetAllUsersErr extends ChatsState {}

final class SendMessageSuccessfully extends ChatsState {}
final class SendMessageError extends ChatsState {

}
final class GetAllMessagesSuccessfully extends ChatsState {}

final class PickImageSuccessfully extends ChatsState {}
final class PickImageError extends ChatsState {}

final class EditImageSuccessfully extends ChatsState {
  final CroppedFile file;
  EditImageSuccessfully(this.file);
}
final class PickFileError extends ChatsState {}

final class PickFileSuccessfully extends ChatsState {
  final File file;
  PickFileSuccessfully(this.file);
}
final class EditImageError extends ChatsState {}


final class UploadFileLoading extends ChatsState {}
final class UploadFileSuccessfully extends ChatsState {
  final String fileUrl;
  UploadFileSuccessfully(this.fileUrl);
}
final class UploadFileError extends ChatsState {}
