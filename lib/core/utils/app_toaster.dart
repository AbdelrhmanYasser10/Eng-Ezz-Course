import 'package:e_commerce_app_session_it_sharks/core/styles/app_text_style.dart';
import 'package:e_commerce_app_session_it_sharks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({required BuildContext context, required String title, required String description , bool isError = false })=>toastification.show(
  context: context,
  type: isError ? ToastificationType.error: ToastificationType.success,
  style: ToastificationStyle.flat,
  autoCloseDuration: const Duration(seconds: 5),
  title: Text(title , style: AppTextStyle.textStyleFont18WhiteBold(),),
  // you can also use RichText widget for title and description parameters
  description: RichText(text:  TextSpan(text: '$description ', style: AppTextStyle.textStyleFont14GreyNormal().copyWith(color: Colors.white))),
  alignment: Alignment.bottomCenter,
  direction: TextDirection.ltr,
  animationDuration: const Duration(milliseconds: 300),
  animationBuilder: (context, animation, alignment, child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },
  icon: isError ? const Icon(Icons.error_outline) :const Icon(Icons.check),
  showIcon: true, // show or hide the icon
  primaryColor: Colors.white ,
  backgroundColor: isError ? Colors.red.shade700:Colors.green.shade700,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  borderRadius: BorderRadius.circular(12),

  showProgressBar: true,
  closeButton: ToastCloseButton(
    showType: CloseButtonShowType.onHover,
    buttonBuilder: (context, onClose) {
      return OutlinedButton.icon(
        onPressed: onClose,
        icon: const Icon(Icons.close, size: 20),
        label: Text(S.of(context).close),
      );
    },
  ),
  closeOnClick: false,
  pauseOnHover: true,
  dragToClose: true,
  callbacks: ToastificationCallbacks(
    onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
    onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
    onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
    onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
  ),
);