import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_status.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/viewmodel/task_view_model.dart';
import 'package:provider/provider.dart';

class TaskDetailView extends StatefulWidget {
  const TaskDetailView({super.key, this.task});

  final TaskModel? task;

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TaskStatus _status;
  final _formKey = GlobalKey<FormState>();
  late TaskViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.task?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    _status = widget.task?.status != null
        ? TaskStatus.values.firstWhere(
            (e) => e.name == widget.task?.status,
            orElse: () => TaskStatus.todo,
          )
        : TaskStatus.todo;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<TaskViewModel>(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Create Task'),
        actions: [
          if (isEditing)
            Observer(
              builder: (_) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _viewModel.isLoading
                      ? null
                      : () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Task'),
                              content: const Text(
                                'Are you sure you '
                                'want to delete this task?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                    context,
                                    false,
                                  ),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm ?? false) {
                            await _viewModel.deleteTask(widget.task!.id!);
                            if (context.mounted) Navigator.pop(context);
                          }
                        },
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TaskStatus>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: TaskStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _status = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              Observer(
                builder: (_) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _viewModel.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                if (isEditing) {
                                  await _viewModel.updateTask(
                                    widget.task!.id!,
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    status: _status,
                                  );
                                } else {
                                  await _viewModel.createTask(
                                    _titleController.text,
                                    _descriptionController.text,
                                    _status,
                                  );
                                }
                                if (context.mounted) Navigator.pop(context);
                              }
                            },
                      child: _viewModel.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(isEditing ? 'Update' : 'Create'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
