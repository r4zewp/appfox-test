import 'package:appfox_test/features/feature/core/router/page_routes.dart';
import 'package:appfox_test/features/feature/data/models/answer_model.dart';
import 'package:appfox_test/features/feature/domain/entities/question_entity.dart';
import 'package:appfox_test/features/feature/presentation/bloc/app/app_bloc.dart';
import 'package:appfox_test/features/feature/presentation/widgets/loading_alert_dialog.dart';
import 'package:appfox_test/features/feature/presentation/widgets/question_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsPageView extends StatefulWidget {
  const QuestionsPageView({Key? key, required this.questions})
      : super(key: key);

  final Object? questions;

  @override
  State<QuestionsPageView> createState() => _QuestionsPageViewState();
}

class _QuestionsPageViewState extends State<QuestionsPageView> {
  final PageController _pageCtrl = PageController();
  bool isLastPage = false;
  List<AnswerModel> results = [];

  void nextPage() {
    _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionsList = widget.questions as List<QuestionEntity>;
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppSavingResultsInitialized) {
          showCupertinoDialog(
              context: context,
              builder: (context) => buildLoadingAlert(context));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              if (_pageCtrl.page != 0) {
                if (isLastPage) {
                  setState(() => isLastPage = false);
                }
                _pageCtrl.previousPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(PageRoutes.home, (route) => false);
                BlocProvider.of<AppBloc>(context).add((AppInitialized()));
              }
            },
          ),
          centerTitle: true,
          title: Text('${questionsList.first.category} quiz'),
        ),
        body: PageView.builder(
          onPageChanged: (page) {
            if (page + 1 == questionsList.length) {
              setState(() => isLastPage = true);
            }
          },
          controller: _pageCtrl,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => QuestionPage(
            questions: questionsList,
            questionIndex: index,
            data: results,
            isLastPage: isLastPage,
            pageController: _pageCtrl,
            question: questionsList[index],
          ),
        ),
      ),
    );
  }
}
