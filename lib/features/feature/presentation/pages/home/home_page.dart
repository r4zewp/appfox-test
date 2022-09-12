import 'package:appfox_test/features/feature/common/constants.dart';
import 'package:appfox_test/features/feature/core/router/page_routes.dart';
import 'package:appfox_test/features/feature/presentation/bloc/app/app_bloc.dart';
import 'package:appfox_test/features/feature/presentation/widgets/choice_tile_widget.dart';
import 'package:appfox_test/features/feature/presentation/widgets/not_chosen_snackbar_widget.dart';
import 'package:appfox_test/features/feature/presentation/widgets/submit_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String chosenCategory = "notChosen";
  String chosenDifficulty = "notChosen";

  bool isLoadingQuestions = false;

  /// Method is used in order to update category when dropdownbutton has changed;
  void updateCategory(String newCategory) =>
      setState(() => chosenCategory = newCategory);

  /// Method is used in orted to update difficulty when dropdownbutton has changed.
  void updateDifficulty(String newDifficulty) =>
      setState(() => chosenDifficulty = newDifficulty);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double contentWidth = screenSize.width * 0.91;
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppResultsSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildSnackbar(
              contentWidth: contentWidth,
              title: AppConstants.snackbarDoneContent,
            ),
          );
        }
        if (state is AppLoadingQuestions) {
          setState(() => isLoadingQuestions = true);
        }
        if (state is AppLoadedQuestions) {
          Navigator.of(context).pushNamed(
            PageRoutes.questions,
            arguments: {"questions": state.questions},
          );
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(AppConstants.homeTitle),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageRoutes.savedResults);
              },
              icon: const Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Center(
          child: SizedBox(
            width: contentWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ChoiceTileWidget(
                      content: AppConstants.categories,
                      title: AppConstants.category,
                      updateValue: (String category) =>
                          updateCategory(category),
                    ),
                    ChoiceTileWidget(
                      content: AppConstants.difficulties,
                      title: AppConstants.difficulty,
                      updateValue: (String difficulty) =>
                          updateDifficulty(difficulty),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedCrossFade(
                      alignment: Alignment.centerLeft,
                      firstChild: SubmitButtonWidget(
                        onPressed: () {
                          if (chosenCategory != "notChosen" &&
                              chosenDifficulty != "notChosen") {
                            BlocProvider.of<AppBloc>(context, listen: false)
                                .add(
                              AppQuestionsInitialized(
                                category: chosenCategory,
                                difficulty: chosenDifficulty,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              buildSnackbar(
                                contentWidth: contentWidth,
                                title: AppConstants.snackbarMissedContent,
                              ),
                            );
                          }
                        },
                        title: AppConstants.submitButton,
                      ),
                      secondChild:
                          const CupertinoActivityIndicator(color: Colors.white),
                      crossFadeState: isLoadingQuestions
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 250),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      child: isLoadingQuestions
                          ? const SizedBox(height: 24.0)
                          : const SizedBox(height: 20.0),
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
}
