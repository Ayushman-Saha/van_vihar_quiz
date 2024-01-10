import '../entities/quizQuestion.dart';

class QuizRepository {
  List<QuizQuestion> getQuestions() {
    //TODO: Fetch questions from an API, database, or local source
    return [
      QuizQuestion(
        question:
            'Play the audio. This is the voice of which of the following animal ??',
        answerChoices: [
          'Tiger',
          'Spotted Hyena',
          'Sloth Bear',
          'Himalayan Bear'
        ],
        correctAnswer: 'Spotted Hyena',
        hasAttachment: true,
        attachmentType: "audio",
        attachment:
            "https://firebasestorage.googleapis.com/v0/b/van-vihar-quiz.appspot.com/o/carnivores%2FGiggling_call_of_a_spotted_hyena_(Crocuta_crocuta)_-_1472-6785-10-9-S3.mp3?alt=media&token=0b4cfcba-290a-4f6c-8b7d-8eadd0f34fb6",
        descriptionAttachment:
            "https://plus.unsplash.com/premium_photo-1661852674235-967247c4a8ed?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        answerType: "text",
        answerDescription:
            "Spotted Hyena is also known as laughing hyena due to its sound.",
      ),
      QuizQuestion(
          question: 'Butterflies taste with their - ',
          answerChoices: ['Tongue', 'Wings', 'Abdomen', 'Feet'],
          correctAnswer: 'Feet',
          hasAttachment: false,
          answerType: "text",
          answerDescription:
              "Butterflies use their feet to tase the flower if it is good for nectar or not. ",
          descriptionAttachment:
              "https://images.unsplash.com/photo-1533048324814-79b0a31982f1?q=80&w=1968&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
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

      QuizQuestion(
        question: "Which bird is this?",
        hasAttachment: true,
        answerDescription:
            "The shikra (Accipiter badius) is a small bird of prey in the family Accipitridae found widely distributed in Asia and Africa where it is also called the little banded goshawk. The African forms may represent a separate species but have usually been considered as subspecies of the shikra.",
        answerType: "text",
        attachmentType: "image",
        attachment:
            "http://t1.gstatic.com/licensed-image?q=tbn:ANd9GcT_12ksb2R95XQg3Y4GoFpNt7oNRosj6qIGz_Hmbt8M_PyORr12sn-peRp2VMcjgAMVkAm5M9ytgnI-0GwHZG9BnRB-QfKBff0lhVxV7aNTDN4kwhuDTyJEi8mwfLeb2Zes57C1xlWn",
        answerChoices: [
          "Shikra",
          "Koel",
          "Spotted Dove",
          "Grey Hornbill",
        ],
        correctAnswer: "Shikra",
        descriptionAttachment:
            "http://t1.gstatic.com/licensed-image?q=tbn:ANd9GcT_12ksb2R95XQg3Y4GoFpNt7oNRosj6qIGz_Hmbt8M_PyORr12sn-peRp2VMcjgAMVkAm5M9ytgnI-0GwHZG9BnRB-QfKBff0lhVxV7aNTDN4kwhuDTyJEi8mwfLeb2Zes57C1xlWn",
      ),
      // Add more questions here
    ];
  }
}
