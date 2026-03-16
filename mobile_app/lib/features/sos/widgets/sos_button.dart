import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';

class SOSButton extends StatefulWidget {
  final VoidCallback onTriggered;
  final int holdDurationSeconds;

  const SOSButton({
    super.key,
    required this.onTriggered,
    this.holdDurationSeconds = 3,
  });

  @override
  State<SOSButton> createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> with TickerProviderStateMixin {
  late AnimationController _holdController;
  late AnimationController _heartbeatController;
  late AnimationController _rippleController;
  
  late Animation<double> _heartbeatAnimation;
  late Animation<double> _rippleAnimation;
  late Animation<double> _rippleOpacity;
  
  bool _isHolding = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    
    // Hold Controller
    _holdController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.holdDurationSeconds),
    );

    // Heartbeat Controller
    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _heartbeatAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.05).chain(CurveTween(curve: Curves.easeInOut)), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.05, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 50),
    ]).animate(_heartbeatController);

    // Ripple Controller
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _rippleAnimation = Tween<double>(begin: 0.8, end: 2.2).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.linear),
    );
    _rippleOpacity = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _holdController.dispose();
    _heartbeatController.dispose();
    _rippleController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startHold() {
    setState(() => _isHolding = true);
    _holdController.forward();
    _timer = Timer(Duration(seconds: widget.holdDurationSeconds), () {
      if (_isHolding) {
        widget.onTriggered();
        _reset();
      }
    });
  }

  void _endHold() {
    if (_holdController.value < 1.0) {
      _reset();
    }
  }

  void _reset() {
    setState(() => _isHolding = false);
    _holdController.reverse();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTapDown: (_) => _startHold(),
          onTapUp: (_) => _endHold(),
          onTapCancel: () => _reset(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ripples
              ...List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _rippleController,
                  builder: (context, child) {
                    final delay = index * 1.0;
                    final progress = (_rippleController.value + (delay / 3)) % 1.0;
                    return Opacity(
                      opacity: (1.0 - progress) * 0.3,
                      child: Container(
                        width: 240 * (0.8 + (progress * 1.0)),
                        height: 240 * (0.8 + (progress * 1.0)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.emergencyRed.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              
              // Main Button with Heartbeat
              ScaleTransition(
                scale: _heartbeatAnimation,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFE53935), Color(0xFFC62828)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.emergencyRed.withOpacity(0.4),
                        blurRadius: 50,
                        offset: const Offset(0, 20),
                      ),
                    ],
                    // Carbon fiber texture simulation via inner shadow or similar
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 80,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -4,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.touch_app_rounded,
                          color: Colors.white70,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
        
        // Progress Section
        SizedBox(
          width: 200,
          child: Column(
            children: [
              const Text(
                'Press & Hold',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: AnimatedBuilder(
                  animation: _holdController,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _holdController.value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.emergencyRed,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'for 3 seconds to alert security',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
