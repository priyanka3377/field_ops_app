import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {

  final String title;
  final String count;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade600,
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          borderRadius: BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                Container(

                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),

                    borderRadius:
                    BorderRadius.circular(14),
                  ),

                  child: const Icon(
                    Icons.dashboard_customize,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 18,
                ),
              ],
            ),

            const SizedBox(height: 28),

            Text(
              count,

              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              title,

              style: const TextStyle(
                fontSize: 15,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}