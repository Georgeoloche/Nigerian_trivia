import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  String? _selectedAnswer;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  // Load questions from JSON file
  Future<void> _loadQuestions() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/questions.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        _questions = jsonList
            .map((e) => Question.fromJson(e as Map<String, dynamic>))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint('Error loading questions: $e');
    }
  }

  // Handle answer selection
  void _onAnswerSelected(String answer) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (answer == _questions[_currentIndex].correctAnswer) {
        _score++;
      }
    });

    // Move to next question after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), _nextQuestion);
  }

  void _nextQuestion() {
    if (!mounted) return;

    if (_currentIndex + 1 < _questions.length) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: _score,
            total: _questions.length,
          ),
        ),
      );
    }
  }

  // Get button color based on answer state
  Color _getOptionColor(String option) {
    if (!_answered) return Colors.white;

    if (option == _questions[_currentIndex].correctAnswer) {
      return const Color(0xFF4CAF50); // green
    }
    if (option == _selectedAnswer) {
      return const Color(0xFFE53935); // red
    }
    return Colors.white;
  }

  Color _getOptionTextColor(String option) {
    if (!_answered) return const Color(0xFF2D3748);

    if (option == _questions[_currentIndex].correctAnswer ||
        option == _selectedAnswer) {
      return Colors.white;
    }
    return const Color(0xFF2D3748);
  }

  @override
  Widget build(BuildContext context) {
    // Show loading spinner
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF008751)),
        ),
      );
    }

    // Show error if no questions loaded
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Could not load questions. Please try again.'),
        ),
      );
    }

    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;
    final optionLetters = ['A', 'B', 'C', 'D'];

    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF008751),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Nigeria Quiz 🇳🇬',
          style: GoogleFonts.fredoka(fontSize: 22, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar section
            Container(
              color: const Color(0xFF008751),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentIndex + 1} of ${_questions.length}',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      // Score badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '⭐ $_score pts',
                          style: GoogleFonts.nunito(
                            color: const Color(0xFF1A3A2A),
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFD700),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Questions and options
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Question card
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF008751).withValues(alpha: 0.2),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Q${_currentIndex + 1}',
                                style: GoogleFonts.fredoka(
                                  color: const Color(0xFF008751),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              question.question,
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A202C),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Answer options
                    ...question.options.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final option = entry.value;
                      final bgColor = _getOptionColor(option);
                      final textColor = _getOptionTextColor(option);
                      final isCorrect =
                          _answered && option == question.correctAnswer;
                      final isWrong = _answered &&
                          option == _selectedAnswer &&
                          option != question.correctAnswer;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: _answered
                              ? null
                              : () => _onAnswerSelected(option),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isCorrect
                                    ? const Color(0xFF4CAF50)
                                    : isWrong
                                        ? const Color(0xFFE53935)
                                        : const Color(0xFFCBD5E0),
                                width: isCorrect || isWrong ? 2.5 : 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Option letter
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isCorrect || isWrong
                                        ? Colors.white.withValues(alpha: 0.3)
                                        : const Color(0xFFE8F5E9),
                                  ),
                                  alignment: Alignment.center,
                                  child: isCorrect
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 20)
                                      : isWrong
                                          ? const Icon(Icons.close,
                                              color: Colors.white, size: 20)
                                          : Text(
                                              optionLetters[idx],
                                              style: GoogleFonts.fredoka(
                                                color:
                                                    const Color(0xFF008751),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    option,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // Feedback message
                    if (_answered)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedAnswer == question.correctAnswer
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _selectedAnswer == question.correctAnswer
                              ? '🎉 Correct! Great job!'
                              : '❌ Oops! The answer is: ${question.correctAnswer}',
                          style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _selectedAnswer == question.correctAnswer
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFFC62828),
                          ),
                          textAlign: TextAlign.center,
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