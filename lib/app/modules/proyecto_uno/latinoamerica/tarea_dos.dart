import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/proyectemos_repository.dart';
import '../../../../commons/strings.dart';
import '../../../../commons/strings_latinoamerica.dart';
import '../../../../commons/styles.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/drawer_menu.dart';

class PUnoLatinoamericaTareaDosPage extends StatefulWidget {
  const PUnoLatinoamericaTareaDosPage({Key? key}) : super(key: key);

  @override
  State<PUnoLatinoamericaTareaDosPage> createState() =>
      _PUnoLatinoamericaTareaDosPageState();
}

class _PUnoLatinoamericaTareaDosPageState
    extends State<PUnoLatinoamericaTareaDosPage> {
  final formKey = GlobalKey<FormState>();
  final _answerUnoController = TextEditingController();
  final _answerDosController = TextEditingController();
  final _answerTresController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: const Text(
          Strings.titleLatinoamericaUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringsLationamerica.qOneLationPageTwo,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerUnoController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorque10:
                          'Su respuesta debe tener al menos 10 caracteres',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      StringsLationamerica.qTwoLatinPageTwo,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerDosController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorque10:
                          'Su respuesta debe tener al menos 10 caracteres',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      StringsLationamerica.qThreeLatinPageTwo,
                      style: ThemeText.paragraph14Gray,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hint: 'Respuesta',
                      controller: _answerTresController,
                      keyboardType: TextInputType.text,
                      validatorVazio: 'Ingrese tuja respuesta correctamente',
                      validatorMenorque10:
                          'Su respuesta debe tener al menos 10 caracteres',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      StringsLationamerica.titleQOnePageDosLatin,
                      style: ThemeText.paragraph16GrayNormal,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final json = {
                              'resposta_1': _answerUnoController.text,
                              'resposta_2': _answerDosController.text,
                              'resposta_3': _answerTresController.text,
                            };

                            sendAnswersToFirebase(json);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Resposta enviada com sucesso!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pushNamed(
                              context,
                              '/pUno_latinoamerica_tarea_tres',
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: loading
                              ? [
                                  const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ]
                              : [
                                  const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      'Contínua',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios),
                                ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendAnswersToFirebase(Map<String, String> json) async {
    const doc = 'uno/latinoamerica/atividade_2/';
    try {
      await context.read<ProyectemosRepository>().saveAnswers(doc, json);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
