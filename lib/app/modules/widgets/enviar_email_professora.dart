import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/services/toast_services.dart';

import '../../../commons/strings/strings.dart';
import '../../../commons/styles.dart';
import '../../../repository/proyectemos_repository.dart';
import '../../../utils/email_sender.dart';
import '../../../utils/get_user.dart';
import 'custom_text_form_field.dart';
import 'drawer_menu.dart';

class EnvioEmailProfesora extends StatefulWidget {
  const EnvioEmailProfesora({super.key});

  @override
  State<EnvioEmailProfesora> createState() => _EnvioEmailProfesoraState();
}

class _EnvioEmailProfesoraState extends State<EnvioEmailProfesora> {
  String? tareaTitle;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _repository = ProyectemosRepository();
  late FocusNode focusNode;
  bool isEmailSending = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tareaTitle = ModalRoute.of(context)?.settings.arguments as String?;
  }

  Future getEmailTeacherFromFirebase() async {
    final emails = [];

    try {
      final data = await _repository.getTeacherEmail();
      emails.addAll(data);
    } on FirebaseException catch (e) {
      e.toString();
    }
    return emails.first;
  }

  Future<void> sendEmail(GoogleSignInAccount? currentUser) async {
    final email = await getEmailTeacherFromFirebase();
    final studentInfo = await _repository.getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allStudentInfo = [
      studentInformation[0],
      studentInformation[1],
      studentInformation[2],
    ];
    final subject = 'Mediação feedback tarea $tareaTitle';
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n\n 
${_emailController.text}''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      [],
      [email],
      subject,
      text,
    );
    showToast(Strings.emailEnviado);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

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
        title: Text(
          Strings.enviarEmailProfesora,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: DrawerMenuWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enviar un email a profesora',
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              focusNode: focusNode,
              textInputAction: TextInputAction.go,
              hint: 'Respuesta',
              controller: _emailController,
              keyboardType: TextInputType.text,
              validatorVazio: 'Ingrese tuja respuesta correctamente',
              validatorMenorqueNumero:
                  'Su respuesta debe tener al menos 3 caracteres',
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(ThemeColors.yellow),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isEmailSending = true;
                  });
                  sendEmail(currentUser).then(
                    (value) => {
                      setState(() {
                        isEmailSending = false;
                      }),
                      Navigator.pop(context),
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: isEmailSending
                          ? const CircularProgressIndicator(
                              color: ThemeColors.blue,
                            )
                          : const Text(
                              'Enviar el email',
                              style: TextStyle(
                                fontSize: 20,
                                color: ThemeColors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
