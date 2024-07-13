import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage._({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();

  static String createLocation(BuildContext context) =>
      context.namedLocation('contacts');

  static final route = GoRoute(
    path: '/contacts',
    name: 'contacts',
    builder: (context, state) => const ContactsPage._(),
  );
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: TextStyle(
          fontSize: 24,
          color: MyTheme.of(context).textColor
        ),
        child: const SelectionArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone, size: 32),
                      SizedBox(width: 8),
                      Flexible(child: Text("+79528828343")),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, size: 32),
                      SizedBox(width: 8),
                      Flexible(child: Text("Анисов Сергей Владимирович")),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.perm_contact_cal_outlined, size: 32),
                      SizedBox(width: 8),
                      Flexible(child: Text("ИНН: 701724290760")),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_city_outlined, size: 32),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          "Адрес: 634045, Россия, Томская Обл, г Томск, Улица Мокрушина 24, кв 67",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
