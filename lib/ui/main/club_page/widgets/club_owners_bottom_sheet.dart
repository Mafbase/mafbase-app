import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';
import 'package:seating_generator_web/feature/administration_page/widgets/add_owner_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class ClubOwnersBottomSheet {
  ClubOwnersBottomSheet._();

  static Future<void> show(
    BuildContext context, {
    required int clubId,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ClubOwnersBottomSheetBody(clubId: clubId),
    );
  }
}

class _ClubOwnersBottomSheetBody extends StatefulWidget {
  final int clubId;

  const _ClubOwnersBottomSheetBody({required this.clubId});

  @override
  State<_ClubOwnersBottomSheetBody> createState() =>
      _ClubOwnersBottomSheetBodyState();
}

class _ClubOwnersBottomSheetBodyState
    extends State<_ClubOwnersBottomSheetBody> {
  late final OwnersRepository _ownersRepository;

  bool _isLoading = true;
  List<UserModel> _owners = const [];

  @override
  void initState() {
    super.initState();
    _ownersRepository = RepositoryFactory.of(context).ownersRepository;
    _loadOwners();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Row(
              children: [
                Text(
                  context.locale.ownersTitle,
                  style: MyTheme.of(context).headerTextStyle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: _onAddOwner,
                  icon: const Icon(Icons.add),
                  tooltip: context.locale.ownersAddTitle,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _owners.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            context.locale.ownersEmpty,
                            textAlign: TextAlign.center,
                            style: MyTheme.of(context).defaultTextStyle,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: _owners.length,
                        itemBuilder: (context, index) {
                          final owner = _owners[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    owner.email,
                                    style: MyTheme.of(context).defaultTextStyle,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _onDeleteOwner(owner),
                                  icon: Icon(
                                    Icons.delete,
                                    color: MyTheme.of(context).redColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadOwners() async {
    setState(() {
      _isLoading = true;
    });
    final owners = await _ownersRepository.getClubOwners(clubId: widget.clubId);
    if (!mounted) {
      return;
    }
    setState(() {
      _owners = owners;
      _isLoading = false;
    });
  }

  Future<void> _onAddOwner() async {
    final email = await AddOwnerDialog.open(
      context: context,
      title: context.locale.ownersAddTitle,
    );

    if (email == null) {
      return;
    }

    await _ownersRepository.addClubOwner(clubId: widget.clubId, email: email);
    if (!mounted) {
      return;
    }
    await _loadOwners();
  }

  Future<void> _onDeleteOwner(UserModel owner) async {
    final shouldDelete = await ConfirmDialog.open(
      context,
      context.locale.ownersRemoveOwner(owner.email),
    );

    if (shouldDelete != true) {
      return;
    }

    await _ownersRepository.deleteClubOwner(
      clubId: widget.clubId,
      ownerId: owner.id,
    );

    if (!mounted) {
      return;
    }
    await _loadOwners();
  }
}
