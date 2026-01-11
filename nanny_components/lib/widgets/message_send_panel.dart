import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_components/widgets/nanny_text_forms.dart';

class MessageSendPanel extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onAttachmentPressed;
  final TextEditingController controller;

  const MessageSendPanel({
    super.key,
    required this.onPressed,
    required this.onAttachmentPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child:
              NannyTextForm(hintText: 'Сообщение...', controller: controller),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onAttachmentPressed,
          child: SvgPicture.asset(
              'packages/nanny_components/assets/images/paperclip.svg',
              height: 24,
              width: 10),
        ),
        //IconButton(
        //    onPressed: onAttachmentPressed, icon: const Icon(Icons.attachment)),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: onPressed,
          child: SvgPicture.asset(
              'packages/nanny_components/assets/images/sent.svg',
              height: 24,
              width: 24),
        ),
        //Expanded(
        //  flex: 1,
        //  child: ElevatedButton(
        //      onPressed: onPressed, child: const Icon(Icons.send_rounded)),
        //),
      ],
    );
  }
}
