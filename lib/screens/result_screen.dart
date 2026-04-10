import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  // Get performance message based on score
  Map<String, String> _getPerformance() {
    final percentage = (score / total) * 100;

    if (percentage == 100) {
      return {
        'emoji': '🏆',
        'title': 'Perfect Score!',
        'message': 'You are a Nigeria expert! Amazing!',
      };
    } else if (percentage >= 80) {
      return {
        'emoji': '🌟',
        'title': 'Excellent!',
        'message': 'You know Nigeria really well!',
      };
    } else if (percentage >= 60) {
      return {
        'emoji': '👍',
        'title': 'Good Job!',
        'message': 'Not bad! Keep studying!',
      };
    } else if (percentage >= 40) {
      return {
        'emoji': '📚',
        'title': 'Keep Trying!',
        'message': 'You can do better! Try again!',
      };
    } else {
      return {
        'emoji': '💪',
        'title': "Don't Give Up!",
        'message': 'Keep practising and you will improve!',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final perf = _getPerformance();
    final percentage = ((score / total) * 100).round();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF008751),
              Color(0xFF00A651),
              Color(0xFF005F3A),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Trophy emoji
                  Text(
                    perf['emoji']!,
                    style: const TextStyle(fontSize: 80),
                  ),

                  const SizedBox(height: 16),

                  // Performance title
                  Text(
                    perf['title']!,
                    style: GoogleFonts.fredoka(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    perf['message']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Score card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        children: [
                          Text(
                            'Your Score',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Score display
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$score',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 72,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF008751),
                                  ),
                                ),
                                TextSpan(
                                  text: ' / $total',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 36,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Percentage bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: score / total,
                              minHeight: 14,
                              backgroundColor: Colors.grey[200],
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(
                                Color(0xFF008751),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            '$percentage% Correct',
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF008751),
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 12),

                          // Stats row
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              _StatItem(
                                icon: Icons.check_circle,
                                label: 'Correct',
                                value: '$score',
                                color: const Color(0xFF4CAF50),
                              ),
                              _StatItem(
                                icon: Icons.cancel,
                                label: 'Wrong',
                                value: '${total - score}',
                                color: const Color(0xFFE53935),
                              ),
                              _StatItem(
                                icon: Icons.quiz,
                                label: 'Total',
                                value: '$total',
                                color: const Color(0xFF2196F3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Play again button
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const QuizScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(
                        'Play Again!',
                        style: GoogleFonts.fredoka(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        foregroundColor: const Color(0xFF1A3A2A),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Home button
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home_rounded,
                        color: Colors.white70),
                    label: Text(
                      'Back to Home',
                      style: GoogleFonts.nunito(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Small reusable stat widget
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.fredoka(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}