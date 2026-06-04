import 'dart:math';
import 'package:flutter/material.dart';

class FireTextDemo extends StatefulWidget {
  const FireTextDemo({super.key});

  @override
  State<FireTextDemo> createState() => _FireTextDemoState();
}

class _FireTextDemoState extends State<FireTextDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Fire Text'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: _ToggleButton(
        enabled: _enabled,
        onToggle: () => setState(() => _enabled = !_enabled),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final t = _controller.value;

                final text = const Text(
                  'FLUTTER',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 6,
                  ),
                );

                if (!_enabled) return text;

                return ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: const [
                      Color(0xFFFF0000),
                      Color(0xFFFF4500),
                      Color(0xFFFF8C00),
                      Color(0xFFFFD700),
                      Color(0xFFFFFFFF),
                    ],
                    stops: [
                      0.0,
                      0.2 + 0.06 * sin(t * 2 * pi),
                      0.5 + 0.06 * cos(t * 2 * pi * 1.3),
                      0.75 + 0.05 * sin(t * 2 * pi * 0.7),
                      1.0,
                    ],
                  ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: text,
                );
              },
            ),
            const SizedBox(height: 64),
            _CodeLabel(
              lines: const [
                'ShaderMask(',
                '  shaderCallback: (bounds) => LinearGradient(',
                '    begin: Alignment.bottomCenter,',
                '    end: Alignment.topCenter,',
                '    colors: [red, orange, gold, white],',
                '    stops: [0.0, 0.2, 0.5, 0.75, 1.0],',
                '  ).createShader(bounds),',
                '  blendMode: BlendMode.srcIn,',
                '  child: Text("FLUTTER"),',
                ')',
              ],
            ),
          ],
        ),
      ),
    );
  }
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
          color: enabled ? const Color(0xFFFF4500) : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: enabled ? const Color(0xFFFF4500) : Colors.white24,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              enabled ? Icons.toggle_on : Icons.toggle_off,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              enabled ? 'ShaderMask ON' : 'ShaderMask OFF',
              style: const TextStyle(
                color: Colors.white,
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
