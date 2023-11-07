import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../../../commons/strings/strings_la_encuesta.dart';
import '../../../widgets/custom_record_audio_button.dart';
import 'tarea_dos_controller.dart';

class QuestionComoCrearUnaEncuestaTres extends StatefulWidget {
  final TareaDosComoCrearUnaEncuestaController controller;

  const QuestionComoCrearUnaEncuestaTres({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionComoCrearUnaEncuestaTres> createState() =>
      _QuestionComoCrearUnaEncuestaTresState();
}

class _QuestionComoCrearUnaEncuestaTresState
    extends State<QuestionComoCrearUnaEncuestaTres> {
  TareaDosComoCrearUnaEncuestaController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsLaEncuesta.questionThreeLaEncuestaTareaDos,
            style: ThemeText.paragraph16GrayNormal,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomRecordAudioButton(
            question: StringsLaEncuesta.questionThreeLaEncuestaTareaDos,
            isAudioFinish: _controller.isAudioFinish,
            namedRoute: '/record_and_play_la_encuesta_tarea_dos',
            labelButton: 'Grabar la respuesta',
            labelButtonFinished: 'Completo',
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
