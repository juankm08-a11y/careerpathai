import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onPressed;
  final String label;

  const LoadingButton({
    super.key,
    required this.loading,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            inherit: false,
          ),
        ),
        child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                inherit: false),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: loading ? 0 : 1,
                  child: Text(label),
                ),
                if (loading)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
              ],
            )));
  }
}
