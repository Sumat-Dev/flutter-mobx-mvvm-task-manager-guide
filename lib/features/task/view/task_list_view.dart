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
      setState(() {}); // Rebuild to allow Observer to see viewModel
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          PopupMenuButton<TaskStatus?>(
            icon: const Icon(Icons.filter_list),
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
            icon: const Icon(Icons.refresh),
          ),
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
                    child: Text('Error: ${_viewModel!.errorMessage}'),
                  );
                }

                if (_viewModel!.tasks.isEmpty) {
                  return const Center(child: Text('No tasks found'));
                }

                return ListView.builder(
                  itemCount: _viewModel!.tasks.length,
                  itemBuilder: (context, index) {
                    final task = _viewModel!.tasks[index];
                    return ListTile(
                      title: Text(task.title ?? 'No Title'),
                      subtitle: Text(task.description ?? ''),
                      trailing: Chip(
                        label: Text(task.status ?? ''),
                        backgroundColor: _getStatusColor(task.status),
                      ),
                      onTap: () async {
                        await Navigator.push(
                          context,
                           MaterialPageRoute(
                            builder: (context) => TaskDetailView(task: task),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color? _getStatusColor(String? statusStr) {
    if (statusStr == null) return null;
    if (statusStr == TaskStatus.todo.name) return Colors.orange[100];
    if (statusStr == TaskStatus.inProgress.name) return Colors.blue[100];
    if (statusStr == TaskStatus.done.name) return Colors.green[100];
    return Colors.grey[200];
  }
}
