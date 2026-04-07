import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/custom_columns/domain/models/custom_column_model.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/custom_columns_editor_bloc.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/custom_columns_editor_event.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/custom_columns_editor_state.dart';
import 'package:seating_generator_web/feature/custom_columns/ui/widgets/custom_column_edit_dialog.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class CustomColumnsEditorPage extends StatelessWidget {
  final int clubId;

  const CustomColumnsEditorPage({super.key, @PathParam('clubId') required this.clubId});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryFactory.of(context).customColumnsRepository;
    return BlocProvider<CustomColumnsEditorBloc>(
      create: (context) =>
          CustomColumnsEditorBloc(repository, clubId)..add(const CustomColumnsEditorEvent.pageOpened()),
      child: _CustomColumnsEditorContent(clubId: clubId),
    );
  }
}

class _CustomColumnsEditorContent extends StatefulWidget {
  final int clubId;

  const _CustomColumnsEditorContent({required this.clubId});

  @override
  State<_CustomColumnsEditorContent> createState() => _CustomColumnsEditorPageState();
}

class _CustomColumnsEditorPageState extends State<_CustomColumnsEditorContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomColumnsEditorBloc, CustomColumnsEditorState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.locale.customColumns),
            leading: const BackButton(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showEditDialog(context),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: state.isLoading
              ? const LoadingOverlayWidget()
              : state.columns.isEmpty
                  ? _EmptyState()
                  : _ColumnsList(
                      columns: state.columns,
                      onEdit: (column) => _showEditDialog(context, column: column),
                      onDelete: (column) => _showDeleteConfirmation(context, column),
                    ),
        );
      },
    );
  }

  Future<void> _showEditDialog(
    BuildContext context, {
    CustomColumnModel? column,
  }) async {
    final result = await CustomColumnEditDialog.show(
      context,
      clubId: widget.clubId,
      column: column,
    );
    if (result == null || !context.mounted) return;

    if (column != null) {
      context.read<CustomColumnsEditorBloc>().add(
            CustomColumnsEditorEvent.updateColumn(
              columnId: column.id,
              title: result.title,
              formula: result.formula,
            ),
          );
    } else {
      context.read<CustomColumnsEditorBloc>().add(
            CustomColumnsEditorEvent.createColumn(
              title: result.title,
              formula: result.formula,
            ),
          );
    }
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    CustomColumnModel column,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.locale.customColumnsDelete),
        content: Text(
          context.locale.customColumnsDeleteConfirm(column.title),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              context.locale.customColumnsDelete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    context.read<CustomColumnsEditorBloc>().add(
          CustomColumnsEditorEvent.deleteColumn(columnId: column.id),
        );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.locale.customColumnsEmpty,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ColumnsList extends StatelessWidget {
  final List<CustomColumnModel> columns;
  final Function(CustomColumnModel) onEdit;
  final Function(CustomColumnModel) onDelete;

  const _ColumnsList({
    required this.columns,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: columns.length,
      itemBuilder: (context, index) {
        final column = columns[index];
        return Card(
          child: ListTile(
            title: Text(column.title),
            subtitle: Text(
              column.formula,
              style: const TextStyle(fontFamily: 'monospace'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onEdit(column),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(column),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
