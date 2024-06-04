import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/strings/strings_evento_cultural.dart';
import '../../../../commons/styles.dart';
import '../../widgets/drawer_menu.dart';

class CriacaoEventoFeedback extends StatefulWidget {
  const CriacaoEventoFeedback({super.key});

  @override
  State<CriacaoEventoFeedback> createState() => _CriacaoEventoFeedbackState();
}

class _CriacaoEventoFeedbackState extends State<CriacaoEventoFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () =>
              Navigator.pushNamed(context, '/pUno_evento_cultural_menu'),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: Text(
          Strings.titlePropuestadeEventoUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: DrawerMenuWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          children: [
            Text(
              StringsEventoCultural.descriptionDosEventocultural,
              style: ThemeText.paragraph16GrayNormal,
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
                  Navigator.pushNamed(
                    context,
                    '/pUno_feedback_page',
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Acceder al feedback',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          color: ThemeColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                  Navigator.pushNamed(
                    context,
                    '/pUno_send_email_prof',
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Entrar en contacto con la profesora',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
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
