import 'package:appfox_test/features/feature/data/models/answer_model.dart';
import 'package:appfox_test/features/feature/data/models/question_model.dart';
import 'package:appfox_test/features/feature/domain/entities/question_entity.dart';
import 'package:appfox_test/features/feature/presentation/bloc/app/app_bloc.dart';
import 'package:appfox_test/features/feature/presentation/widgets/submit_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    Key? key,
    required this.question,
    required this.pageController,
    required this.isLastPage,
    required this.data,
    required this.questionIndex,
    required this.questions,
  }) : super(key: key);

  final List<QuestionEntity> questions;
  final int questionIndex;
  final QuestionEntity question;
  final bool isLastPage;
  final PageController pageController;
  final List<AnswerModel> data;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int? ansIndex;

  /// Updates answer index.
  void updateIndex(int index) {
    setState(() => ansIndex = index);
  }

  /// Checks if tile is selected right now.
  bool selected(int index) => ansIndex == index;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final answers = widget.question.answers;
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.91,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 16.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: screenSize.width * 0.91,
                child: Text(
                  widget.question.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: answers.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (answers.values.toList()[index] != null) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        left: screenSize.width * (16 / screenSize.width),
                        right: screenSize.width * (16 / screenSize.width),
                      ),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        tileColor: Colors.grey.shade500,
                        textColor:
                            selected(index) ? Colors.white : Colors.black,
                        selectedTileColor: Colors.grey.shade800,
                        selected: selected(index),
                        onTap: () {
                          updateIndex(index);
                        },
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              screenSize.width * (16 / screenSize.width),
                          vertical: 4,
                        ),
                        title: AnimatedDefaultTextStyle(
                          style: TextStyle(
                            color:
                                selected(index) ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          duration: const Duration(milliseconds: 250),
                          child: Text(
                              "${index + 1}. ${answers.values.toList()[index]}"),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                AppConstants.skippedQuestionsRule,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              SubmitButtonWidget(
                onPressed: () {
                  final currQuestionIndex = widget.pageController.page!.toInt();

                  /// First we check if answer is already in list
                  ///
                  /// If it is, answer is removed and replaced by another one.
                  ///
                  /// In case if user came back to certain question in order to
                  /// change his answer.
                  if (widget.data.asMap().containsKey(currQuestionIndex)) {
                    widget.data.removeAt(currQuestionIndex);

                    /// This if statement is used in order to separate
                    /// logic of uploading results with page switching.
                    if (widget.pageController.page!.toInt() + 1 ==
                        widget.questions.length) {
                      _addAnswerAtCertainIndex(currQuestionIndex, answers);
                      BlocProvider.of<AppBloc>(context).add(
                        AppTestResultUploadInitialized(
                          answers: widget.data,
                          difficulty: widget.question.difficulty,
                          category: widget.question.category,
                        ),
                      );
                    } else {
                      _addAnswerAtCertainIndex(currQuestionIndex, answers);
                      _nextQuestion();
                    }
                  } else {
                    if (widget.pageController.page!.toInt() + 1 ==
                        widget.questions.length) {
                      _addAnswer(answers);
                      BlocProvider.of<AppBloc>(context).add(
                        AppTestResultUploadInitialized(
                          answers: widget.data,
                          difficulty: widget.question.difficulty,
                          category: widget.question.category,
                        ),
                      );
                    } else {
                      _addAnswer(answers);
                      _nextQuestion();
                    }
                  }
                },
                title: widget.isLastPage
                    ? AppConstants.submitQuestionButton
                    : AppConstants.nextQuestionButton,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  /// Inserts answer at certain index.
  void _addAnswerAtCertainIndex(
      int currQuestionIndex, Map<String, dynamic> answers) {
    if (ansIndex == null) {
      widget.data.insert(
        currQuestionIndex,
        const AnswerModel(isUserCorrect: false, userAnswer: "-1"),
      );
    } else {
      widget.data.insert(
        currQuestionIndex,
        AnswerModel(
          isUserCorrect: _isAnswerCorrect(
            question: widget.question,
            userAnswer: answers.values.toList()[ansIndex!],
          ),
          question: widget.question as QuestionModel,
          userAnswer: answers.values.toList()[ansIndex!],
        ),
      );
    }
  }

  /// Adds answer in the end of List.
  void _addAnswer(Map<String, dynamic> answers) {
    widget.data.add(
      ansIndex == null
          ? const AnswerModel(isUserCorrect: false, userAnswer: '-1')
          : AnswerModel(
              isUserCorrect: _isAnswerCorrect(
                question: widget.question,
                userAnswer: answers.keys.toList()[ansIndex!],
              ),
              userAnswer: answers.keys.toList()[ansIndex!],
              question: widget.question as QuestionModel,
            ),
    );
  }

  /// Just to make code more readable.
  void _nextQuestion() {
    widget.pageController.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  /// Checks if answer is correct.
  bool _isAnswerCorrect(
      {required QuestionEntity question, required String userAnswer}) {
    final userResult = question.correctAnswers["${userAnswer}_correct"];
    if (userResult == "true") {
      return true;
    } else if (userResult == "-1") {
      return false;
    } else {
      return false;
    }
  }
}
