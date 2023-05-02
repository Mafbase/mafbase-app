import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage._({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();

  static String createLocation(BuildContext context) =>
      context.namedLocation('contacts');

  static final route = GoRoute(
    path: 'contacts',
    name: 'contacts',
    builder: (context, state) => const ContactsPage._(),
  );
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 24),
        child: SelectionArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.phone, size: 32),
                      SizedBox(width: 8),
                      Flexible(child: Text("+79528828343")),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.person, size: 32),
                      SizedBox(width: 8),
                      Flexible(child: Text("Анисов Сергей Владимирович"))
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.perm_contact_cal_outlined, size: 32),
                      SizedBox(width: 8),
                      Flexible(child: Text("ИНН: 701724290760")),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
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
