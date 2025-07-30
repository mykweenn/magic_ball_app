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
      debugShowCheckedModeBanner: false,
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
  State<MagicBallScreen> createState() => MagicBallScreenState();
}

class MagicBallScreenState extends State<MagicBallScreen>
    with SingleTickerProviderStateMixin {
  final List<String> predictions = [
    'Бесспорно',
    'Предрешено',
    'Никаких сомнений',
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
  late AnimationController shakeController;

  @override
  void initState() {
    super.initState();
    shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )
    ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          shakeController.reset();
        }
      });
  }

  @override
  void dispose() {
    shakeController.dispose();
    super.dispose();
  }

  void getPrediction() {
    shakeController.forward();

    setState(() {
      currentPrediction = 'Думаю...';
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        currentPrediction = predictions[Random().nextInt(predictions.length)];
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
            AnimatedBuilder(
              animation: shakeController,
              builder: (context, child) {
                final shake = sin(shakeController.value * 10 * 1.5) * 0.4;
                return Transform.rotate(
                  angle: shake,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: getPrediction,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [Color.fromARGB(255, 2, 255, 221), Color.fromARGB(255, 177, 2, 240)],
                          radius: 0.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 191, 0).withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
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
                );
              },
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
