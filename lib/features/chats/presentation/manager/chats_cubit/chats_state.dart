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
