import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:yt_dlp_gui/features/download_form/const/download_form_const.dart';

class YtUrlField extends StatelessWidget {
  const YtUrlField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: DownloadFormConst.ytUrl,
      decoration: const InputDecoration(
        hintText: 'Enter YouTube URL',
        alignLabelWithHint: true,
        labelText: 'Youtube URL',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.url(
            protocols: ['http', 'https'],
            requireProtocol: true,
            hostWhitelist: ['www.youtube.com', 'www.yt.com'],
          )
        ],
      ),
    );
  }
}
