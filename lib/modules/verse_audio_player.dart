import 'package:flutter/cupertino.dart';
import 'package:tue_26oct/utilities/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VerseAudioPlayer extends StatelessWidget {

  final String audio_url;

  const VerseAudioPlayer({Key key, this.audio_url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: audioBaseUrl+audio_url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
