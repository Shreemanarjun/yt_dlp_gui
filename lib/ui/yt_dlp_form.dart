import 'package:flutter/material.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config.dart';
import 'package:yt_dlp_gui/domain/yt_dlp_config_enums.dart';
import 'package:yt_dlp_gui/shell/yt_dlp_command.dart';
import 'package:yt_dlp_gui/ui/widgets/EnumDropDown.dart';
import 'package:yt_dlp_gui/ui/widgets/TextCheckBox.dart';
import 'package:yt_dlp_gui/ui/widgets/TextInputField.dart';

class YtDlpForm extends StatefulWidget {
  const YtDlpForm({super.key});

  @override
  State<YtDlpForm> createState() => _YtDlpFormState();
}

class _YtDlpFormState extends State<YtDlpForm> {
  YtDlpConfig _config = YtDlpConfig.defaultConfig();

  void setDlAudio(bool? value) {
    setState(() {
      _config = _config.set(dlAudio: value);
    });
  }

  void setDlVideo(bool? value) {
    setState(() {
      _config = _config.set(dlVideo: value);
    });
  }

  void setDlThumbnail(bool? value) {
    _config = _config.set(dlThumbnail: value);
    setState(() {});
  }

  void setDlSubtitles(bool? value) {
    setState(() {
      _config = _config.set(dlSubtitles: value);
    });
  }

  void setYtUrl(String? value) {
    if (value != _config.ytUrl) {
      debugPrint("setYtUrl: $value : ${_config.ytUrl}");
      _config = _config.set(ytUrl: value);
    }
  }

  void setVideoSize(VideoSize? value) {
    setState(() {
      _config = _config.set(vSize: value);
    });
  }

  void setAudioBitrate(AudioBitrate? value) {
    setState(() {
      _config = _config.set(aBitrate: value);
    });
  }

  void setVideoFormat(VideoFormat? value) {
    setState(() {
      _config = _config.set(vFormat: value);
    });
  }

  void setAudioFormat(AudioFormat? value) {
    setState(() {
      _config = _config.set(aFormat: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextInputField(
          value: _config.ytUrl,
          hintText: "Enter YouTube URL",
          onChanged: setYtUrl,
        ),
        TextCheckBox(label: "Download Video", value: _config.dlVideo, onChanged: setDlVideo),
        TextCheckBox(label: "Download Audio", value: _config.dlAudio, onChanged: setDlAudio),
        TextCheckBox(
            label: "Download Thumbnail", value: _config.dlThumbnail, onChanged: setDlThumbnail),
        TextCheckBox(
            label: "Download Subtitles", value: _config.dlSubtitles, onChanged: setDlSubtitles),
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              Row(
                children: [
                  EnumDropDown(VideoSize.values, label: "Video Size", onSelected: setVideoSize),
                  EnumDropDown(VideoFormat.values, label: "Video Format", onSelected: setVideoFormat),
                ],
              ),
              Row(
                children: [
                  EnumDropDown(AudioFormat.values, label: "Audio Format", onSelected: setAudioFormat),
                  EnumDropDown(AudioBitrate.values, label: "Audio Bitrate", onSelected: setAudioBitrate),
                ],
              ),
            ],
          ),
        ),
        FilledButton(
            onPressed: () {
              debugPrint(YtDlpCommand(_config).buildCommand());
            },
            child: const Text("Download")),
      ],
    )));
  }
}
