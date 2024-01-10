import '../entities/quizQuestion.dart';

class QuizRepository {
  List<QuizQuestion> getQuestions() {
    //TODO: Fetch questions from an API, database, or local source
    return [
      QuizQuestion(
          question: 'What is the capital of France?',
          answerChoices: ['Paris', 'London', 'Berlin', 'Madrid'],
          correctAnswer: 'Paris',
          hasAttachment: true,
          attachmentType: "image",
          attachment:
              "https://images.pexels.com/photos/6335058/pexels-photo-6335058.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          descriptionAttachment:
              "https://plus.unsplash.com/premium_photo-1661852674235-967247c4a8ed?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          answerType: "text",
          answerDescription:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      QuizQuestion(
        question: 'Which planet is known as the Red Planet?',
        answerChoices: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
        correctAnswer: 'Mars',
        hasAttachment: true,
        attachmentType: "audio",
        attachment:
            "https://firebasestorage.googleapis.com/v0/b/van-vihar-quiz.appspot.com/o/carnivores%2FGiggling_call_of_a_spotted_hyena_(Crocuta_crocuta)_-_1472-6785-10-9-S3.mp3?alt=media&token=0b4cfcba-290a-4f6c-8b7d-8eadd0f34fb6",
        answerType: "text",
        answerDescription:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      ),
      QuizQuestion(
          question: "Which of the following is a Lion?",
          answerChoices: [
            "https://images.pexels.com/photos/6335058/pexels-photo-6335058.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            "https://images.pexels.com/photos/7492295/pexels-photo-7492295.jpeg?auto=compress&cs=tinysrgb&w=800",
            "https://images.pexels.com/photos/7408291/pexels-photo-7408291.jpeg?auto=compress&cs=tinysrgb&w=800",
            "https://images.pexels.com/photos/17081254/pexels-photo-17081254/free-photo-of-elephant-in-nature.jpeg?auto=compress&cs=tinysrgb&w=800"
          ],
          correctAnswer:
              "https://images.pexels.com/photos/6335058/pexels-photo-6335058.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          hasAttachment: false,
          answerDescription: "This is a lion",
          answerType: "image",
          descriptionAttachment:
              "https://images.pexels.com/photos/6335058/pexels-photo-6335058.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
      // Add more questions here
    ];
  }
}
