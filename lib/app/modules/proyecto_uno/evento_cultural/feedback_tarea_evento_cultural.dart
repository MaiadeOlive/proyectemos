import 'package:flutter/material.dart';

import '../../../../../commons/strings.dart';
import '../../widgets/feedback_page.dart';

class FeedbackTareaDivulgacion extends StatefulWidget {
  const FeedbackTareaDivulgacion({super.key});

  @override
  State<FeedbackTareaDivulgacion> createState() =>
      _FeedbackTareaStateDivulgacion();
}

class _FeedbackTareaStateDivulgacion extends State<FeedbackTareaDivulgacion> {
  final String firebaseDoc =
      'uno/feedback/evento_cultural/tarea_uno/feedback_professor/';
  final String pageTitle = Strings.titleArtistasHispanoamericanosUno;
  final String tareaTitle = Strings.feedbackTareaUno;
  final String taskCompleted = 'eventoReceivedFeedbackCompleted';

  @override
  Widget build(BuildContext context) {
    return FeedbackPage(
      firebaseDoc: firebaseDoc,
      pageTitle: pageTitle,
      tareaTitle: tareaTitle,
      taskCompleted: taskCompleted,
    );
  }
}
