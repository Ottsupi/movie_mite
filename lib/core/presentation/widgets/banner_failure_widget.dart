import 'package:flutter/material.dart';
import 'package:movie_mite/core/resources/failures.dart';

class BannerFailureWidget extends StatelessWidget {
  const BannerFailureWidget(this.failure, {super.key});

  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    if (failure == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Text(
          "Something went wrong. Please try again later.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    final Failure nonNullFailure = failure!;

    if (nonNullFailure is ServerFailure) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.cloud_off_outlined,
                      size: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      nonNullFailure.detail,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 4.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        nonNullFailure.detail,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
