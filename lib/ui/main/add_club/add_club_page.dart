import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/interactors/create_club_interactor.dart';
import 'package:seating_generator_web/ui/main/add_club/add_club_bloc.dart';
import 'package:seating_generator_web/ui/main/add_club/add_club_event.dart';
import 'package:seating_generator_web/ui/main/add_club/add_club_router.dart';
import 'package:seating_generator_web/ui/main/add_club/add_club_state.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class AddClubPage extends StatelessWidget {
  const AddClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repos = RepositoryFactory.of(context);
    return BlocProvider<AddClubBloc>(
      create: (context) => AddClubBloc(
        createClubInteractor: CreateClubInteractor(repos.clubRepository),
        router: AddClubRouterImpl(context),
      ),
      child: const _AddClubPageContent(),
    );
  }
}

class _AddClubPageContent extends StatefulWidget {
  const _AddClubPageContent();

  @override
  State<_AddClubPageContent> createState() => _AddClubPageContentState();
}

class _AddClubPageContentState extends State<_AddClubPageContent> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _groupLinkController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _groupLinkController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final description = _descriptionController.text.trim();
    final groupLink = _groupLinkController.text.trim();

    context.read<AddClubBloc>().add(
          AddClubEvent.formSubmitted(
            name: name,
            description: description.isEmpty ? null : description,
            groupLink: groupLink.isEmpty ? null : groupLink,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.addClubTitle),
      ),
      body: BlocBuilder<AddClubBloc, AddClubState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: context.locale.addClubNameLabel,
                  hint: context.locale.addClubNameHint,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _descriptionController,
                  label: context.locale.addClubDescriptionLabel,
                  maxLines: 4,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _groupLinkController,
                  label: context.locale.addClubGroupLinkLabel,
                  textInputType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  onSubmit: (_) => _submit(context),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: context.locale.addClubCreateButton,
                  isLoading: state.isLoading,
                  onTap: () => _submit(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
