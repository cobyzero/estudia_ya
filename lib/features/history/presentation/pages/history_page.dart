import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Study History',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pick up where you left off or review past insights.',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 32),
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search topics, summaries, or dates...',
                    hintStyle: GoogleFonts.outfit(color: const Color(0xFF94A3B8)),
                    icon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // TODAY
              _SectionHeader(title: 'TODAY'),
              const _HistoryCard(
                title: 'Advanced Thermodynamics',
                subtitle: 'Chat session',
                description: 'Explored the second law of thermodynamics and its applications i...',
                time: '2h ago',
                icon: Icons.chat_bubble_outline,
                iconColor: Color(0xFF6366F1),
                hasResume: true,
                progress: 0.6,
              ),
              const _HistoryCard(
                title: 'Modern History PDF',
                subtitle: 'Document Processing - Study',
                description: 'Summary generated for "The Cold War Era" chapter. Identified 12 key events and 5 major figures.',
                time: '',
                icon: Icons.folder_open_outlined,
                iconColor: Color(0xFF10B981),
              ),
              const SizedBox(height: 16),
              // YESTERDAY
              _SectionHeader(title: 'YESTERDAY'),
              const _HistoryCard(
                title: 'Python Decorators',
                subtitle: 'Detailed explanation of @property and custom wrapper functions with examples.',
                time: 'Yesterday',
                icon: Icons.chat_bubble_outline,
                iconColor: Color(0xFF6366F1),
                isCompact: true,
              ),
              const _HistoryCard(
                title: 'Organic Chem Notes',
                subtitle: 'Processed handwritten notes into structured Markdown format. Extracted reaction...',
                time: 'Yesterday',
                icon: Icons.description_outlined,
                iconColor: Color(0xFF10B981),
                isCompact: true,
              ),
              const _HistoryCard(
                title: 'Macroeconomics Quiz',
                subtitle: 'Reviewed aggregate demand curves and fiscal policy impacts. Mock test completed.',
                time: 'Yesterday',
                icon: Icons.chat_bubble_outline,
                iconColor: Color(0xFF6366F1),
                isCompact: true,
              ),
              const SizedBox(height: 16),
              // LAST WEEK
              _SectionHeader(title: 'LAST WEEK'),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _HistoryListItem(
                      title: 'Calculus III - Midterm Review',
                      subtitle: 'Document processed - Nov 22, 2023',
                      icon: Icons.description_outlined,
                      isLast: false,
                    ),
                    _HistoryListItem(
                      title: 'Linear Algebra Basics',
                      subtitle: 'Chat session - Nov 20, 2023',
                      icon: Icons.chat_bubble_outline,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF94A3B8),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String time;
  final IconData icon;
  final Color iconColor;
  final bool hasResume;
  final double? progress;
  final bool isCompact;

  const _HistoryCard({
    required this.title,
    this.subtitle = '',
    this.description = '',
    required this.time,
    required this.icon,
    required this.iconColor,
    this.hasResume = false,
    this.progress,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                  ],
                ),
              ),
              if (time.isNotEmpty)
                Text(
                  time,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
            ],
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              description,
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: const Color(0xFF475569),
                height: 1.5,
              ),
            ),
          ],
          if (hasResume) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'RESUME CONVERSATION',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_rounded, color: Color(0xFF6366F1), size: 12),
              ],
            ),
          ],
          if (progress != null) ...[
            const SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _HistoryListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isLast;

  const _HistoryListItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF6366F1), size: 18),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert, color: Color(0xFF94A3B8), size: 20),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, color: Color(0xFFF1F5F9), indent: 70),
      ],
    );
  }
}
