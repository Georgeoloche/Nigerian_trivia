# 🇳🇬 Nigeria Trivia Quiz App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-008751?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)](https://play.google.com)

> **Learn Nigeria, One Question at a Time** — A kid-friendly mobile trivia app built for Nigerian primary and secondary school students.

---

## 📖 About

Nigeria Trivia Quiz is a mobile application designed to make learning about Nigeria fun and engaging for young students. It covers Nigerian history, geography, culture, and basic science through an interactive quiz format with instant feedback and score tracking.

This project was built as an MVP (Minimum Viable Product) with a focus on clean architecture, readable code, and a polished user experience — ready for Google Play Store deployment.

---

## ✨ Features

- 📚 **20 curated trivia questions** covering history, geography, culture & science
- ✅ **Instant answer feedback** — correct answers highlight green, wrong answers highlight red
- 📊 **Live progress tracking** — animated progress bar and real-time score badge
- 🏆 **Result screen** — final score display with performance-based messages (5 tiers)
- 🔄 **Restart & replay** — play again or return home from result screen
- 🎨 **Kid-friendly UI** — colorful design with Nigerian green & gold palette
- 💫 **Smooth animations** — slide/fade question transitions
- 📱 **Custom splash screen** — branded app launch experience
- 🖼️ **Custom app icon** — unique branding for home screen

---

## 🏗️ Project Structure

```
nigeria_quiz/
├── lib/
│   ├── main.dart                  # App entry point & theme config
│   ├── models/
│   │   └── question.dart          # Question data model
│   └── screens/
│       ├── home_screen.dart       # Welcome/landing screen
│       ├── quiz_screen.dart       # Core quiz logic & UI
│       └── result_screen.dart     # Final score screen
├── assets/
│   ├── data/
│   │   └── questions.json         # 20 trivia questions (local JSON)
│   └── images/
│       └── logo.png               # App logo
└── pubspec.yaml
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter 3.x | UI framework |
| Dart 3.x | Programming language |
| Google Fonts | Typography (Nunito + Fredoka) |
| rootBundle | Local JSON asset loading |
| StatefulWidget | Quiz state management |
| Flutter Native Splash | Splash screen |
| Flutter Launcher Icons | App icon generation |

---

## 🧠 Architecture

The app follows a simple, readable architecture suitable for maintainability and scaling:

- **Models** — Plain Dart classes with `fromJson` factory constructors
- **Screens** — Separated by concern (Home, Quiz, Result)
- **State** — Managed locally with `StatefulWidget` and `setState()`
- **Data** — Questions loaded from a local JSON file using `rootBundle`

No over-engineering — clean, simple, and easy to understand.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio or VS Code

### Installation

```bash
# Clone the repository
git clone https://github.com/Georgeoloche/nigeria-quiz-app.git

# Navigate into the project
cd nigeria-quiz-app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build Release APK

```bash
# Single architecture (recommended)
flutter build apk --target-platform android-arm64 --release

# App Bundle for Play Store
flutter build appbundle --release
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^8.0.2

dev_dependencies:
  flutter_launcher_icons: ^0.14.1
  flutter_native_splash: ^2.4.1
```

---

## 🎯 Key Implementation Details

**Loading questions from JSON:**
```dart
final jsonString = await rootBundle.loadString('assets/data/questions.json');
final List<dynamic> jsonList = json.decode(jsonString);
_questions = jsonList.map((e) => Question.fromJson(e)).toList();
```

**Answer feedback with auto-advance:**
```dart
void _onAnswerSelected(String answer) {
  if (_answered) return;
  setState(() {
    _selectedAnswer = answer;
    _answered = true;
    if (answer == _questions[_currentIndex].correctAnswer) _score++;
  });
  Future.delayed(const Duration(milliseconds: 1500), _nextQuestion);
}
```

---

## 🗺️ Roadmap

- [ ] Add a countdown timer per question
- [ ] Add difficulty levels (Easy / Medium / Hard)
- [ ] Add sound effects for correct/wrong answers
- [ ] Save high score with SharedPreferences
- [ ] Add more question categories
- [ ] Multiplayer mode
- [ ] iOS release

---

## 👨‍💻 Author

**George Oloche**
Junior Flutter Developer | Building for Africa 🌍

[![GitHub](https://img.shields.io/badge/GitHub-Georgeoloche-181717?style=flat&logo=github)](https://github.com/Georgeoloche)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-George%20Oloche-0A66C2?style=flat&logo=linkedin)](https://linkedin.com/in/georgeoloche)

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <sub>Built with ❤️ for Nigerian students everywhere 🇳🇬</sub>
</div>
