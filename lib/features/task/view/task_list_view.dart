import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_status.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/view/task_detail_view.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/viewmodel/task_view_model.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  TaskViewModel? _viewModel;
  TaskStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _viewModel = Provider.of<TaskViewModel>(context, listen: false);
      _viewModel?.setContext(context);
      await _viewModel?.init();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        title: const Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          PopupMenuButton<TaskStatus?>(
            icon: const Icon(Icons.filter_list_rounded),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onSelected: (status) async {
              setState(() {
                _selectedStatus = status;
              });
              await _viewModel?.getTasks(status: status);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('All'),
              ),
              ...TaskStatus.values.map(
                (status) => PopupMenuItem(
                  value: status,
                  child: Text(status.name),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              await _viewModel?.getTasks(status: _selectedStatus);
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _viewModel == null
          ? const Center(child: CircularProgressIndicator())
          : Observer(
              builder: (_) {
                if (_viewModel!.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_viewModel!.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline_rounded, size: 48, color: Colors.redAccent),
                        const SizedBox(height: 16),
                        Text(
                          'Oops! Error: ${_viewModel!.errorMessage}',
                          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (_viewModel!.tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox_rounded, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'No tasks found\nEnjoy your free time!',
                          style: TextStyle(color: Colors.grey[500], fontSize: 16, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ).copyWith(bottom: 80),
                  itemCount: _viewModel!.tasks.length,
                  itemBuilder: (context, index) {
                    final task = _viewModel!.tasks[index];
                    final statusColor = _getStatusColor(task.status) ?? Colors.grey;
                    return Card(
                      elevation: 0,
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => TaskDetailView(task: task),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getStatusIcon(task.status),
                                  color: statusColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title ?? 'No Title',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black87,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    if (task.description != null &&
                                        task.description!.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        task.description!,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                          height: 1.4,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: statusColor),
                                ),
                                child: Text(
                                  task.status?.toUpperCase() ?? 'UNKNOWN',
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const TaskDetailView(),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Task', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Color? _getStatusColor(String? statusStr) {
    if (statusStr == null) return Colors.grey;
    if (statusStr == TaskStatus.todo.name) return Colors.orange;
    if (statusStr == TaskStatus.inProgress.name) return Colors.blue;
    if (statusStr == TaskStatus.done.name) return Colors.green;
    return Colors.grey;
  }

  IconData _getStatusIcon(String? statusStr) {
    if (statusStr == null) return Icons.help_outline_rounded;
    if (statusStr == TaskStatus.todo.name) return Icons.assignment_outlined;
    if (statusStr == TaskStatus.inProgress.name) return Icons.pending_actions_rounded;
    if (statusStr == TaskStatus.done.name) return Icons.check_circle_outline_rounded;
    return Icons.help_outline_rounded;
  }
}
