import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';

import '../../../core/theme/z_colors.dart';
import '../../../core/theme/z_text_styles.dart';
import '../../../shared/services/api_service.dart';
import '../../../shared/widgets/z_button.dart';
import '../../../shared/widgets/z_card.dart';

class ScrollScreen extends ConsumerStatefulWidget {
  const ScrollScreen({super.key, required this.topicId});
  final String topicId;

  @override
  ConsumerState<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends ConsumerState<ScrollScreen> {
  String? _pdfPath;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchScroll();
  }

  Future<void> _fetchScroll() async {
    try {
      final dio = ref.read(aiEngineClientProvider);
      final response = await dio.get<List<int>>(
        '/scroll/generate/${widget.topicId}',
        options: Options(responseType: ResponseType.bytes),
      );

      final dir = (await _getTempDir());
      final file = '${dir.path}/scroll_${widget.topicId}.pdf';
      await _writeBytes(file, response.data!);

      setState(() {
        _pdfPath = file;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<Directory> _getTempDir() async {
    // Use path_provider in production; stub for now
    return Directory('/tmp');
  }

  Future<void> _writeBytes(String path, List<int> bytes) async {
    final file = File(path);
    await file.writeAsBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZColors.base,
      appBar: AppBar(
        title: Text('Manga Cheat Sheet', style: ZTextStyles.h2Cyan),
        backgroundColor: ZColors.base,
        actions: [
          if (_pdfPath != null)
            IconButton(
              icon: const Icon(Icons.download, color: ZColors.primary),
              onPressed: () {/* Share/Download PDF */},
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: ZColors.primary))
          : _error != null
              ? _ErrorView(error: _error!, onRetry: () {
                  setState(() => _loading = true);
                  _fetchScroll();
                })
              : _pdfPath != null
                  ? PDFView(
                      filePath: _pdfPath!,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      backgroundColor: ZColors.base,
                      nightMode: true,
                    )
                  : const SizedBox.shrink(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error, required this.onRetry});
  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: ZColors.warning, size: 48),
            const SizedBox(height: 16),
            Text(
              'Could not generate Scroll',
              style: ZTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Make sure the AI engine is running.',
              style: ZTextStyles.bodyMuted,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ZButton(label: 'Retry', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
