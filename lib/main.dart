import 'package:flutter/material.dart';
import 'demos/fire_text_demo.dart';
import 'demos/shimmer_demo.dart';
import 'demos/image_fade_demo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShaderMask Demos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              const Text(
                'Demos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 28),
              _DemoCard(
                number: '01',
                title: 'Fire Text',
                accentColor: const Color.fromARGB(255, 255, 255, 255),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FireTextDemo()),
                ),
              ),
              const SizedBox(height: 16),
              _DemoCard(
                number: '02',
                title: 'Shimmer Effect',
                accentColor: const Color.fromARGB(255, 255, 255, 255),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ShimmerDemo()),
                ),
              ),
              const SizedBox(height: 16),
              _DemoCard(
                number: '03',
                title: 'Image Fade',
                accentColor: const Color.fromARGB(255, 255, 255, 255),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ImageFadeDemo()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String number;
  final String title;
  final Color accentColor;
  final VoidCallback onTap;

  const _DemoCard({
    required this.number,
    required this.title,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: accentColor.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(16),
          color: accentColor.withValues(alpha: 0.07),
        ),
        child: Row(
          children: [
            Text(
              number,
              style: TextStyle(
                color: accentColor.withValues(alpha: 0.4),
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: accentColor, size: 16),
          ],
        ),
      ),
    );
  }
}
