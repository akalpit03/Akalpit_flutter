import 'package:akalpit/features/posts/story/ui/supporter/chatting/models/chat_block_model.dart';
import 'package:flutter/material.dart';
 

class ChatBlockWidget extends StatelessWidget {
  final ChatBlockModel model;

  const ChatBlockWidget({required this.model, Key? key}) : super(key: key);

  bool _isUserSender(String sender) {
    return sender.toLowerCase() == "you" || sender.toLowerCase() == "user";
  }

  @override
  Widget build(BuildContext context) {
    return model.isChatting
        ? _buildChatMode(context)
        : _buildNarrationMode(context);
  }

  // ----------------------------------------------------
  //                CHAT MODE (Modern UI)
  // ----------------------------------------------------
  Widget _buildChatMode(BuildContext context) {
    return Column(
      children: model.messages.map((msg) {
        final isSender = _isUserSender(msg.sender);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color:
                        isSender ? Colors.blue.shade600 : Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isSender ? 16 : 4),
                      bottomRight: Radius.circular(isSender ? 4 : 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sender
                      Text(
                        msg.sender,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSender
                              ? Colors.white.withOpacity(0.8)
                              : Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Message text
                      Text(
                        msg.text,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.3,
                          color: isSender ? Colors.white : Colors.black87,
                        ),
                      ),

                      if (msg.timestamp != null)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              msg.timestamp!,
                              style: TextStyle(
                                fontSize: 11,
                                color: isSender
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ----------------------------------------------------
  //            NARRATION MODE (Story UI)
  // ----------------------------------------------------
  Widget _buildNarrationMode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: model.messages.map((msg) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black26,
                fontSize: 16,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: "${msg.sender} ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
                ),
                const TextSpan(text: ": "),

                TextSpan(
                  text: "“${msg.text}”",
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white60,
                  ),
                ),

                if (msg.timestamp != null)
                  TextSpan(
                    text: "  (${msg.timestamp})",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
