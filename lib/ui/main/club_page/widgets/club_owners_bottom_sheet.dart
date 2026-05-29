import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/domain/models/user_model.dart';
import 'package:seating_generator_web/domain/repositories/owners_repository.dart';
import 'package:seating_generator_web/feature/administration_page/widgets/add_owner_dialog.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ClubOwnersBottomSheet {
  ClubOwnersBottomSheet._();

  static Future<void> show(
    BuildContext context, {
    required int clubId,
  }) {
    // On desktop open a separate centered dialog window; on mobile keep the
    // draggable bottom sheet.
    if (!context.isMobile) {
      return showDialog<void>(
        context: context,
        builder: (_) => _ClubOwnersBody(clubId: clubId, isDialog: true),
      );
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _ClubOwnersBody(clubId: clubId),
    );
  }
}

class _ClubOwnersBody extends StatefulWidget {
  final int clubId;
  final bool isDialog;

  const _ClubOwnersBody({required this.clubId, this.isDialog = false});

  @override
  State<_ClubOwnersBody> createState() => _ClubOwnersBodyState();
}

class _ClubOwnersBodyState extends State<_ClubOwnersBody> {
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
    if (widget.isDialog) {
      return CustomDialog(
        child: SizedBox(
          width: 480,
          height: 600,
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildList(null)),
            ],
          ),
        ),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          _buildHeader(context),
          Expanded(child: _buildList(scrollController)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildList(ScrollController? scrollController) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_owners.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.locale.ownersEmpty,
            textAlign: TextAlign.center,
            style: MyTheme.of(context).defaultTextStyle,
          ),
        ),
      );
    }
    return ListView.builder(
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
