import 'package:flutter/material.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';

import '../../../../../commons/styles.dart';
import '../../../widgets/custom_text_form_field.dart';

class QuestionThreeComoCrearPodcast extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const QuestionThreeComoCrearPodcast({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<QuestionThreeComoCrearPodcast> createState() =>
      _QuestionThreeComoCrearPodcastState();
}

class _QuestionThreeComoCrearPodcastState
    extends State<QuestionThreeComoCrearPodcast>
    with AutomaticKeepAliveClientMixin {
  TextEditingController get controller => widget.controller;
  FocusNode get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                StringsComoCrearUnPodcast.questionThreeTareaDosCrearUnPodcast,
                style: ThemeText.paragraph14Gray,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                hint: 'Respuesta',
                controller: controller,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorqueNumero:
                    'Su respuesta debe tener al menos 3 caracteres',
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
