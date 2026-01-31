import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/core/widgets/loading_widget.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/domain/entities/user_entity.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/manager/chats_cubit/chats_cubit.dart';
import 'package:e_commerce_app_session_it_sharks/features/chats/presentation/pages/chat_details_page.dart';
import 'package:e_commerce_app_session_it_sharks/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUserId = BlocProvider.of<HomeCubit>(context).currentUser!.id;
    BlocProvider.of<ChatsCubit>(context).getAllUsersFunction(currentUserId!);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: AppTextStyle.textStyleFont24BlackBold(),
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsPage(

                  recieverUser: UserEntity(
                      id: "-1",
                      name: "Gemini",
                      email:"Gemini@gmail.com",
                      role: "Ai model",
                      avatarLink:"assets/images/icons8-gemini-ai-250.svg",
                  ),
                ),));

              },
              iconSize: 24.sp,
              icon: SvgPicture.asset(
                "assets/images/icons8-gemini-ai-250.svg",
                color: Colors.blue,

              ),
          ),
        ],
      ),
      body: BlocBuilder<ChatsCubit,ChatsState>

        (builder: (context, state) {
          if(state is GetAllUsersLoading){
            return LoadingWidget();
          }
          else if(state is GetAllUsersErr){
            return Center(
              child: Text(
                "Err",
              ),
            );
          }
          else{
            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w
              ),
                itemBuilder: (context, index) {
                  var item = BlocProvider.of<ChatsCubit>(context).allUsers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsPage(recieverUser: item),));
                    },
                    child: Card(
                      elevation: 0,
                      child:Padding(
                        padding:  EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 8.w,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundImage: CachedNetworkImageProvider(
                                item.avatarLink,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: AppTextStyle.textStyleFont18BlackBold(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item.email,
                                    style: AppTextStyle.textStyleFont16BlackBold().copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              itemCount: BlocProvider.of<ChatsCubit>(context).allUsers.length,
            );
          }
        }, ),
    );
  }
}
