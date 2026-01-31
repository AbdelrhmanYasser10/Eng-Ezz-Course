import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session_it_sharks/core/utils/startegy_handler.dart';
import 'package:e_commerce_app_session_it_sharks/core/widgets/loading_widget.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/message_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/widgets/pdf_viewer_widget.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app_session_it_sharks/injection_container.dart'
    as di;
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../../core/components/input_field.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_style.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../widgets/video_player_widget.dart';

class ChatDetailsPage extends StatefulWidget {
  final UserEntity recieverUser;
  const ChatDetailsPage({super.key, required this.recieverUser});

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final TextEditingController controller = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        context.read<ChatsCubit>().getAllMessagesFunction(
          context.read<HomeCubit>().currentUser!.id!,
          widget.recieverUser.id,
        );
        return BlocConsumer<ChatsCubit, ChatsState>(
          listener: (context, state) {
            if (state is EditImageSuccessfully) {
              setState(() {
                file = File(state.file.path);
              });
            }
            if (state is PickFileSuccessfully) {
              setState(() {
                file = state.file;
              });
            }
            if (state is UploadFileSuccessfully) {
              di.sl<ChatsCubit>().sendMessageFunction(
                context.read<HomeCubit>().currentUser!.id!,
                widget.recieverUser.id,
                controller.text,
                state.fileUrl,
                file!.path,
              );
              controller.clear();
              file = null;
            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<ChatsCubit>(context);
            var messages = cubit.allMessages;
            var currentUserId = context.read<HomeCubit>().currentUser!.id!;
            return Scaffold(
              appBar: AppBar(
                title: _buildUserRow(widget.recieverUser.id == -1),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var iAmSender =
                            currentUserId.toString() ==
                            messages[index].senderId;
                        if (messages[index].media != null) {
                          return Column(
                            children: [
                             FutureBuilder(
                                 future:  buildMediaContent(messages, index, iAmSender),
                                 builder: (context, snapshot) {
                                   if(snapshot.hasData) {
                                     return snapshot.data!;
                                   }
                                   else{
                                     return const SizedBox();
                                   }
                                 },
                             ),
                              BubbleSpecialThree(
                                text: messages[index].content,
                                color:
                                    iAmSender
                                        ? Colors.blueAccent
                                        : Color(0xFFE8E8EE),
                                textStyle:
                                    AppTextStyle.textStyleFont14BlackRegular()
                                        .copyWith(
                                          color:
                                              iAmSender
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                tail: false,
                                isSender: iAmSender,
                              ),
                            ],
                          );
                        }
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
                  file != null
                      ? SizedBox(
                        width: 200.w,
                        height: 200.h,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 200.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Image.file(
                                  file!,
                                  fit: BoxFit.cover,
                                  width: 200.w,
                                  height: 200.h,
                                  errorBuilder: (context, error, stackTrace) {
                                    final fileExtension =
                                        file!.path
                                            .split("/")
                                            .last
                                            .split(".")
                                            .last;
                                    return _buildPlaceHolder(fileExtension);
                                  },
                                ),
                              ),
                            ),
                            IconButton.filled(
                              onPressed: () {
                                setState(() {
                                  file = null;
                                });
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                            state is UploadFileLoading
                                ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kPrimaryColor,
                                  ),
                                )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: InputField(
                            controller: controller,
                            hintText: S.of(context).enterYourMessage,
                            prefixIcon: Icons.chat,
                            isChatField: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Message cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        state is UploadFileLoading
                            ? LoadingWidget()
                            : FloatingActionButton.small(
                              backgroundColor: AppColors.kPrimaryColor,
                              elevation: 0,

                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  if (file == null) {
                                    di.sl<ChatsCubit>().sendMessageFunction(
                                      context
                                          .read<HomeCubit>()
                                          .currentUser!
                                          .id!,
                                      widget.recieverUser.id,
                                      controller.text,
                                    );
                                    controller.clear();
                                  } else {
                                    context.read<ChatsCubit>().uploadFile(
                                      file!,
                                    );
                                  }
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

  Future<Widget> buildMediaContent(
    List<MessageEntity> messages,
    int index,
    bool iAmSender,
  ) async{
    String mediaType = getFileType(messages[index].media!.split("/").last.split(".").last);
    if(mediaType == "image") {
      return BubbleNormalImage(
        id: messages[index].id ?? "_image${Random().nextInt(100000)}",
        image: CachedNetworkImage(
          imageUrl:messages[index].media!,
          width: 200.w,
          height: 200.h,
          fit: BoxFit.cover,
        ),
        isSender: iAmSender,
      );
    }
    else if (mediaType == "video"){
      final uint8list = await VideoThumbnail.thumbnailData(
        video: messages[index].media!,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 25,
      );
      return Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          width: 200.w,
          height: 200.h,
          child: GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>VideoPlayerWidget(videoLink: messages[index].media!,))),
            child: Stack(
              children: [
                BubbleNormalImage(
                  id: messages[index].id ?? "_image${Random().nextInt(100000)}",
                  image: Image.memory(
                    uint8list!,
                    width: 200.w, // Optional: specify width
                    height: 200.h, // Optional: specify height
                    fit: BoxFit.cover, // Optional: specify fit
                  ),
                  isSender: iAmSender,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 64.sp,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    else{
      return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>PdfViewerWidget(pdfLink: messages[index].media!,))),

            child: Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    color: Colors.red,
                  ),
                  Text(
                    "Pdf file",
                    style: AppTextStyle.textStyleFont14GreyNormal(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Row _buildUserRow(bool isAiModel) {
    if (isAiModel) {
      return Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: Colors.white,
            backgroundImage: Svg(
              "assets/images/icons8-gemini-ai-250.svg",
              size: Size(24.w, 24.h),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            "GEMINI FLASH 2.5",
            style: AppTextStyle.textStyleFont18BlackBold(),
          ),
        ],
      );
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundImage: CachedNetworkImageProvider(
            widget.recieverUser.avatarLink,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          widget.recieverUser.name,
          style: AppTextStyle.textStyleFont18BlackBold(),
        ),
      ],
    );
  }

  Widget _buildPlaceHolder(String fileExtension) {
    String fileType = getFileType(fileExtension);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            fileType == "video"
                ? Icons.ondemand_video_rounded
                : fileType == "pdf"
                ? Icons.picture_as_pdf
                : Icons.audio_file_outlined,
            color: Colors.red,
            size: 54.sp,
          ),
          SizedBox(height: 20.0.h),
          Text(
            file!.path.split("/").last,
            style: AppTextStyle.textStyleFont14BlackRegular(),
          ),
        ],
      ),
    );
  }
}
