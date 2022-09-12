abstract class AppConstants {
  /// Error messages.
  static const serverFailureMessage = "Something wrong with server.";
  static const unexpectedFailureMessage = "Unexpected error has occured.";

  /// Any constant strings.
  static const String appBarPreviousResults = 'Your previous results';
  static const String category = "Category";
  static const String difficulty = "Difficulty";
  static const String homeTitle = "Customize your quiz!";
  static const String submitButton = 'Submit to the quiz';
  static const String nextQuestionButton = "Next";
  static const String submitQuestionButton = "Submit";
  static const String skippedQuestionsRule =
      "Note that skipped question counts as wrong";
  static const String snackbarMissedContent = "You missed something";
  static const String snackbarDoneContent =
      "Results are saved. Congratulations!";
  static const String submitAlertDialogTitle = "Do you want to submit?";
  static const String submitAlertDialogContent =
      "That was the last question. By pressing OK you submit your results.";

  /// Maps with dropdown values.
  static const String notChosen = "Choose any";

  static const categories = {
    "notChosen": "Choose any",
    "linux": "Linux",
    "devops": "DevOps",
    "docker": "Docker",
  };

  static const difficulties = {
    "notChosen": "Choose any",
    "easy": "Easy",
    "medium": "Medium",
    "hard": "Hard",
  };
}
