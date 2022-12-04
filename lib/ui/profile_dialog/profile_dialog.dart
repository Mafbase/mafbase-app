import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/domain/models/player_model.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_bloc.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_event.dart';
import 'package:seating_generator_web/ui/profile_dialog/profile_dialog_state.dart';
import 'package:seating_generator_web/utils.dart';

class ProfileDialog extends StatefulWidget {
  final PlayerModel player;

  const ProfileDialog({Key? key, required this.player}) : super(key: key);

  static Future<bool?> open(BuildContext context, PlayerModel player) {
    return showDialog<bool>(
      context: context,
      builder: (context) => BlocProvider<ProfileDialogBloc>(
        create: (context) => getIt(
          param1: context,
          param2: player,
        ),
        child: ProfileDialog(
          player: player,
        ),
      ),
    );
  }

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  final nicknameController = TextEditingController();
  final fsmNicknameController = TextEditingController();
  final mafbankNicknameController = TextEditingController();
  final mafbankFocusNode = FocusNode();
  final fsmFocusNode = FocusNode();
  final nicknameFocusNode = FocusNode();

  @override
  void initState() {
    nicknameController.text = widget.player.nickname;
    fsmNicknameController.text = widget.player.fsmNickaname ?? "";
    mafbankNicknameController.text = widget.player.mafbankNickname ?? "";
    super.initState();
  }

  @override
  void dispose() {
    nicknameController.dispose();
    fsmNicknameController.dispose();
    mafbankNicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileDialogBloc, ProfileDialogState>(
      builder: (context, state) => CustomDialog(
        child: Stack(
          children: [
            SizedBox(
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null && mounted) {
                          context.read<ProfileDialogBloc>().add(
                                ProfileDialogEvent.editImage(
                                  bytes: Uint8List.fromList(
                                    await image.openRead().fold<List<int>>(
                                      [],
                                      (previous, element) => previous + element,
                                    ),
                                  ),
                                  fileName: image.name,
                                ),
                              );
                        }
                      },
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: state.imageUrl == null
                            ? Image.asset(
                                AppAssets.playerPhoto,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                state.imageUrl ?? "",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.player.nickname,
                            style: MyTheme.of(context).headerTextStyle,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            controller: nicknameController,
                            onSubmit: (_) {
                              fsmFocusNode.requestFocus();
                            },
                            focusNode: nicknameFocusNode,
                            label: context.locale.nicknameHint,
                          ),
                          CustomTextField(
                            controller: fsmNicknameController,
                            onSubmit: (_) {
                              mafbankFocusNode.requestFocus();
                            },
                            focusNode: fsmFocusNode,
                            label: context.locale.fsmNicknameHint,
                          ),
                          CustomTextField(
                            controller: mafbankNicknameController,
                            onSubmit: (_) {
                              mafbankFocusNode.unfocus();
                            },
                            focusNode: mafbankFocusNode,
                            label: context.locale.mafbankNicknameHint,
                          ),
                          CustomButton(
                            text: context.locale.save,
                            onTap: () {
                              context.read<ProfileDialogBloc>().add(
                                    ProfileDialogEvent.onSubmit(
                                      nickname: nicknameController.text,
                                      mafbankNickname:
                                          mafbankNicknameController.text,
                                      fsmNickname: fsmNicknameController.text,
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoading)
              const Positioned.fill(child: LoadingOverlayWidget()),
          ],
        ),
      ),
    );
  }
}
