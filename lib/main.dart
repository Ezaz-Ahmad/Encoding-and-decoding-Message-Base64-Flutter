import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

//checking the git bash
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encode/Decode Message',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MessageEncoderDecoder(),
    );
  }
}

class MessageEncoderDecoder extends StatefulWidget {
  @override
  _MessageEncoderDecoderState createState() => _MessageEncoderDecoderState();
}

class _MessageEncoderDecoderState extends State<MessageEncoderDecoder> {
  final TextEditingController _controller = TextEditingController();
  String _output = '';

  void _encodeMessage() {
    setState(() {
      String input = _controller.text;
      List<int> bytes = utf8.encode(input);
      String encoded = base64.encode(bytes);
      _output = encoded;
    });
  }

  void _decodeMessage() {
    setState(() {
      try {
        String input = _controller.text;
        List<int> bytes = base64.decode(input);
        String decoded = utf8.decode(bytes);
        _output = decoded;
      } catch (e) {
        _output = 'Error: Invalid input for decoding.';
      }
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _output));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encode/Decode Message using Base64'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Enter a message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _encodeMessage,
              child: Text('Encode'),
            ),
            ElevatedButton(
              onPressed: _decodeMessage,
              child: Text('Decode'),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Output: $_output',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: _output.isNotEmpty ? _copyToClipboard : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
