import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app_session_it_sharks/injection_container.dart'
    as di;
import '../../../../core/components/input_field.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatDetailsPage extends StatefulWidget {
  final UserEntity recieverUser;
  const ChatDetailsPage({super.key, required this.recieverUser});

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        context.read<ChatsCubit>().getAllMessagesFunction(
          context.read<HomeCubit>().currentUser!.id!,
          widget.recieverUser.id,
        );
        return BlocConsumer<ChatsCubit, ChatsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = BlocProvider.of<ChatsCubit>(context);
            var messages = cubit.allMessages;
            var currentUserId = context.read<HomeCubit>().currentUser!.id!;
            return Scaffold(
              backgroundColor: Color(0xfff2f2f2),
              appBar: AppBar(
                backgroundColor: Color(0xfff2f2f2),
                surfaceTintColor: Color(0xfff2f2f2),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                        widget.recieverUser.avatarLink,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.recieverUser.name,
                      style: AppTextStyle.textStyleFont18BlackBold(),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var iAmSender =
                            currentUserId.toString() ==
                            messages[index].senderId;
                        return BubbleSpecialThree(
                          text: messages[index].content,
                          color:
                              iAmSender ? Colors.blueAccent : Color(0xFFE8E8EE),
                          textStyle: AppTextStyle.textStyleFont14BlackRegular()
                              .copyWith(
                                color: iAmSender ? Colors.white : Colors.black,
                              ),
                          tail: false,
                          isSender: iAmSender,
                        );
                      },
                      itemCount: messages.length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputField(
                            controller: controller,
                            hintText: "Enter your message ....",
                            prefixIcon: Icons.chat,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Message cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        FloatingActionButton.small(
                          backgroundColor: AppColors.kPrimaryColor,
                          elevation: 0,

                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              di.sl<ChatsCubit>().sendMessageFunction(
                                context.read<HomeCubit>().currentUser!.id!,
                                widget.recieverUser.id,
                                controller.text,
                              );
                              controller.clear();
                            }
                          },
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
