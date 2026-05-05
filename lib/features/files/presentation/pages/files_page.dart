import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

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
                'Study Materials',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your notes and research documents.',
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
                    hintText: 'Search documents...',
                    hintStyle: GoogleFonts.outfit(color: const Color(0xFF94A3B8)),
                    icon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Upload Area
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    width: 1,
                    style: BorderStyle.solid, // Note: dashed border would need a custom painter or package
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.cloud_upload_outlined, color: Color(0xFF6366F1), size: 28),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Drag and drop files here',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Support for PDF, DOCX, JPG and MD files up to 50MB',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // File List
              const _FileCard(
                title: 'Calculus_Final_Notes.pdf',
                subtitle: 'PDF Document',
                date: 'Oct 24, 2023',
                icon: Icons.description_outlined,
                iconColor: Color(0xFFF87171),
                progress: 1.0,
              ),
              const _FileCard(
                title: 'Structure_Diagram_V1.png',
                subtitle: 'PNG Image',
                date: 'Oct 22, 2023',
                icon: Icons.image_outlined,
                iconColor: Color(0xFF60A5FA),
                progress: 1.0,
              ),
              const _FileCard(
                title: 'History_Essay_Draft.docx',
                subtitle: 'Uploading...',
                date: '72%',
                icon: Icons.article_outlined,
                iconColor: Color(0xFF818CF8),
                progress: 0.72,
                isUploading: true,
              ),
              const _FileCard(
                title: 'Meeting_Notes_Physics.md',
                subtitle: 'Markdown',
                date: 'Oct 18, 2023',
                icon: Icons.note_outlined,
                iconColor: Color(0xFFFBBF24),
                progress: 1.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final IconData icon;
  final Color iconColor;
  final double progress;
  final bool isUploading;

  const _FileCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.progress,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
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
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subtitle,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: isUploading ? const Color(0xFF6366F1) : const Color(0xFF64748B),
                            fontWeight: isUploading ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        Text(
                          date,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: isUploading ? const Color(0xFF6366F1) : const Color(0xFF059669),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (!isUploading)
                Positioned(
                  right: 0,
                  top: -2,
                  child: Icon(Icons.check_circle, color: const Color(0xFF059669), size: 10),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
