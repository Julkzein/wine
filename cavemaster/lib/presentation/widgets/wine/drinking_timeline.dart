import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../data/models/wine.dart';

/// Horizontal timeline showing a wine's drinking window relative to today.
///
/// Visual layout:
///   ──[aging]──[drink window]──[peak]──[drink window end]──
///                         ▲ today
class DrinkingTimeline extends StatelessWidget {
  final Wine wine;

  const DrinkingTimeline({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    if (!wine.hasDrinkingWindow) {
      return _NoWindowPlaceholder();
    }

    final currentYear = DateTime.now().year;
    final vintageYear = wine.vintage ?? (currentYear - 3);

    // Determine timeline bounds
    final start = vintageYear;
    final end = (wine.drinkUntil ?? (wine.drinkFrom ?? currentYear) + 10) + 2;
    final span = (end - start).toDouble();
    if (span <= 0) return _NoWindowPlaceholder();

    double pos(int year) => ((year - start) / span).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Drinking Window', style: AppTypography.labelMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: CustomPaint(
            painter: _TimelinePainter(
              drinkFrom: wine.drinkFrom,
              drinkUntil: wine.drinkUntil,
              peakFrom: wine.peakFrom,
              peakUntil: wine.peakUntil,
              currentYear: currentYear,
              pos: pos,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(vintageYear.toString(), style: AppTypography.caption),
            if (wine.drinkFrom != null)
              Text(wine.drinkFrom.toString(), style: AppTypography.caption),
            if (wine.peakFrom != null && wine.peakUntil != null)
              Text(
                '${wine.peakFrom}–${wine.peakUntil}',
                style: AppTypography.caption
                    .copyWith(color: AppColors.success),
              ),
            if (wine.drinkUntil != null)
              Text(wine.drinkUntil.toString(), style: AppTypography.caption),
          ],
        ),
      ],
    );
  }
}

class _NoWindowPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule_outlined,
              color: AppColors.textDisabled, size: 18),
          const SizedBox(width: 10),
          Text('No drinking window set',
              style: AppTypography.bodySecondary),
        ],
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  final int? drinkFrom;
  final int? drinkUntil;
  final int? peakFrom;
  final int? peakUntil;
  final int currentYear;
  final double Function(int) pos;

  _TimelinePainter({
    required this.drinkFrom,
    required this.drinkUntil,
    required this.peakFrom,
    required this.peakUntil,
    required this.currentYear,
    required this.pos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final trackY = size.height / 2;
    const trackHeight = 6.0;
    const radius = Radius.circular(3);

    // ── Base track ────────────────────────────────────────────────────────
    final trackPaint = Paint()..color = AppColors.surfaceSecondary;
    canvas.drawRRect(
      RRect.fromLTRBR(0, trackY - trackHeight / 2, size.width,
          trackY + trackHeight / 2, radius),
      trackPaint,
    );

    // ── Drink window (amber) ──────────────────────────────────────────────
    if (drinkFrom != null || drinkUntil != null) {
      final from = pos(drinkFrom ?? currentYear);
      final until = pos(drinkUntil ?? currentYear + 5);
      final windowPaint = Paint()..color = AppColors.warning.withOpacity(0.5);
      canvas.drawRRect(
        RRect.fromLTRBR(
          size.width * from,
          trackY - trackHeight / 2,
          size.width * until,
          trackY + trackHeight / 2,
          radius,
        ),
        windowPaint,
      );
    }

    // ── Peak window (green) ───────────────────────────────────────────────
    if (peakFrom != null && peakUntil != null) {
      final from = pos(peakFrom!);
      final until = pos(peakUntil!);
      final peakPaint = Paint()..color = AppColors.success;
      canvas.drawRRect(
        RRect.fromLTRBR(
          size.width * from,
          trackY - trackHeight / 2 - 1,
          size.width * until,
          trackY + trackHeight / 2 + 1,
          radius,
        ),
        peakPaint,
      );
    }

    // ── Current year marker ───────────────────────────────────────────────
    final nowX = size.width * pos(currentYear);
    final markerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.5;
    canvas.drawLine(
      Offset(nowX, trackY - 14),
      Offset(nowX, trackY + 14),
      markerPaint,
    );

    // Triangle marker at top
    final path = Path()
      ..moveTo(nowX - 5, trackY - 18)
      ..lineTo(nowX + 5, trackY - 18)
      ..lineTo(nowX, trackY - 12)
      ..close();
    canvas.drawPath(path, Paint()..color = Colors.white);

    // "Now" label
    final tp = TextPainter(
      text: TextSpan(
        text: 'Now',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(nowX - tp.width / 2, trackY + 18));
  }

  @override
  bool shouldRepaint(_TimelinePainter old) =>
      old.drinkFrom != drinkFrom ||
      old.drinkUntil != drinkUntil ||
      old.peakFrom != peakFrom ||
      old.peakUntil != peakUntil ||
      old.currentYear != currentYear;
}
