import 'package:flutter/material.dart';

class ShimmerDemo extends StatefulWidget {
  const ShimmerDemo({super.key});

  @override
  State<ShimmerDemo> createState() => _ShimmerDemoState();
}

class _ShimmerDemoState extends State<ShimmerDemo>
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

    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildShimmerText() {
    final sweep = -1.5 + 3.5 * _controller.value;

    const child = Text(
      'SHIMMER',
      style: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        letterSpacing: 4,
      ),
    );

    if (!_enabled) return child;

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment(sweep - 1.0, -0.5),
        end: Alignment(sweep + 1.0, 0.5),
        colors: const [
          Color(0xFFB8860B),
          Color(0xFFDAA520),
          Color(0xFFFFFFFF),
          Color(0xFFDAA520),
          Color(0xFFB8860B),
        ],
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Shimmer Effect'),
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
            _buildShimmerText(),
            const SizedBox(height: 48),
            _CodeLabel(
              lines: const [
                'ShaderMask(',
                '  shaderCallback: (bounds) => LinearGradient(',
                '    begin: Alignment(sweep - 1, -0.5),',
                '    end: Alignment(sweep + 1,  0.5),',
                '    colors: [darkGold, gold, white, gold, darkGold],',
                '  ).createShader(bounds),',
                '  blendMode: BlendMode.srcIn,',
                '  child: Text("SHIMMER"),',
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
          color: enabled ? const Color(0xFFDAA520) : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: enabled ? const Color(0xFFDAA520) : Colors.white24,
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
