import 'package:flutter/material.dart';

class MessageWindow extends StatefulWidget {
  final String contactName;

  const MessageWindow({Key? key, required this.contactName}) : super(key: key);

  @override
  _MessageWindowState createState() => _MessageWindowState();
}

class _MessageWindowState extends State<MessageWindow> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message ${widget.contactName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type your message....',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = _controller.text;
                    if (message.isNotEmpty) {
                      setState(() {
                        _messages.add(message);
                      });
                      _controller.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
