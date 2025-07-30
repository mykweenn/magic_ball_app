import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MagicBallApp());
}

class MagicBallApp extends StatelessWidget {
  const MagicBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шар предсказаний',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MagicBallScreen(),
    );
  }
}

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  final List<String> predictions = [
    'Бесспорно',
    'Предрешено',
    'Никаких сомнений',
    'Определённо да',
    'Можешь быть уверен в этом',
    'Мне кажется — да',
    'Вероятнее всего',
    'Хорошие перспективы',
    'Знаки говорят — да',
    'Да',
    'Пока не ясно, попробуй снова',
    'Спроси позже',
    'Лучше не рассказывать',
    'Сейчас нельзя предсказать',
    'Сконцентрируйся и спроси опять',
    'Даже не думай',
    'Мой ответ — нет',
    'По моим данным — нет',
    'Перспективы не очень хорошие',
    'Весьма сомнительно'
  ];

  String currentPrediction = 'Спросите меня о чем угодно';
  bool isShaking = false;

  void getPrediction() {
    setState(() {
      isShaking = true;
      currentPrediction = 'Думаю...';
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        final random = Random();
        currentPrediction = predictions[random.nextInt(predictions.length)];
        isShaking = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шар предсказаний'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: getPrediction,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                transform: isShaking 
                    ? Matrix4.rotationZ(0.1 * sin(2 * pi * DateTime.now().millisecondsSinceEpoch / 200))
                    : null,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
                width: 250,
                height: 250,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      currentPrediction,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Нажмите на шар для предсказания',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}