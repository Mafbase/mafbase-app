import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class OwnerRow extends StatelessWidget {
  final Function()? onDelete;
  final String? email;

  const OwnerRow({
    super.key,
    this.onDelete,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8,),
          Text("$email"),
          const Spacer(),
          if (onDelete != null)
            Center(
              child: IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete,
                  size: 24,
                  color: MyTheme.of(context).redColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
