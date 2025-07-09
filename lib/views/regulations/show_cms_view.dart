import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:revalesuva/components/custom_text.dart';
import 'package:revalesuva/model/cms/cms_model.dart' as cms_model;
import 'package:revalesuva/utils/navigation_helper.dart';

class ShowCmsView extends StatelessWidget {
  const ShowCmsView({super.key, required this.data});

  final cms_model.Datum data;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        NavigationHelper.onBackScreen(
            widget: ShowCmsView(
          data: data,
        ));
      },
      canPop: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 80),
          children: [
            Align(
              alignment: AlignmentDirectional.center,
              child: TextHeadlineLarge(
                text: data.title ?? "",
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(20),
            HtmlWidget(data.description ?? ""),
          ],
        ),
      ),
    );
  }
}
