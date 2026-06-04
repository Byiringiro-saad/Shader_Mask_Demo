import 'package:flutter/material.dart';

class ImageFadeDemo extends StatefulWidget {
  const ImageFadeDemo({super.key});

  @override
  State<ImageFadeDemo> createState() => _ImageFadeDemoState();
}

class _ImageFadeDemoState extends State<ImageFadeDemo> {
  double _fadeStop = 0.6;
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text('Image Fade'),
        backgroundColor: const Color(0xFF0D0D0D),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: _ToggleButton(
        enabled: _enabled,
        onToggle: () => setState(() => _enabled = !_enabled),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Interactive fade demo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_enabled) ...[
                    const SizedBox(height: 4),

                    Slider(
                      value: _fadeStop,
                      min: 0.1,
                      max: 1.0,
                      activeColor: const Color(0xFF4FC3F7),
                      onChanged: (v) => setState(() => _fadeStop = v),
                    ),
                  ] else
                    const SizedBox(height: 16),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _enabled
                        ? ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: const [Colors.white, Colors.transparent],
                              stops: [_fadeStop - 0.1, _fadeStop + 0.3],
                            ).createShader(bounds),
                            blendMode: BlendMode.dstIn,
                            child: _FakePhoto(),
                          )
                        : _FakePhoto(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            _CodeLabel(
              lines: const [
                'ShaderMask(',
                '  shaderCallback: (bounds) => LinearGradient(',
                '    begin: Alignment.topCenter,',
                '    end: Alignment.bottomCenter,',
                '    colors: [Colors.white, Colors.transparent],',
                '    stops: [_fadeStop - 0.1, _fadeStop + 0.3],',
                '  ).createShader(bounds),',
                '  blendMode: BlendMode.dstIn,  // key!',
                '  child: Image(...),',
                ')',
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// Simulates a photo using gradients — no network needed
class _FakePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
        ),
      ),
      child: Stack(
        children: [
          // Simulated landscape elements
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: CustomPaint(painter: _MountainPainter()),
          ),
          Positioned(
            top: 30,
            right: 40,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF1A3A4A);
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.2, size.height * 0.3)
      ..lineTo(size.width * 0.4, size.height * 0.6)
      ..lineTo(size.width * 0.55, size.height * 0.1)
      ..lineTo(size.width * 0.75, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.2)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _ToggleButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onToggle;
  const _ToggleButton({required this.enabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFF4FC3F7) : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: enabled ? const Color(0xFF4FC3F7) : Colors.white24,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              enabled ? Icons.toggle_on : Icons.toggle_off,
              color: enabled ? Colors.black : Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              enabled ? 'ShaderMask ON' : 'ShaderMask OFF',
              style: TextStyle(
                color: enabled ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final bool enabled;
  const _ArticleCard({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: enabled
                ? ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.transparent],
                      stops: [0.5, 1.0],
                    ).createShader(bounds),
                    blendMode: BlendMode.dstIn,
                    child: _FakePhoto(),
                  )
                : _FakePhoto(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ShaderMask: the widget you\'ve been missing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Flutter has a secret weapon for visual effects — and most developers have never touched it.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: Color(0xFF4FC3F7),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Flutter Devs',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                    const Spacer(),
                    const Text(
                      '5 min read',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeLabel extends StatelessWidget {
  final List<String> lines;
  const _CodeLabel({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Text(
                line,
                style: const TextStyle(
                  color: Color(0xFF9CDCFE),
                  fontFamily: 'monospace',
                  fontSize: 12,
                  height: 1.6,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
