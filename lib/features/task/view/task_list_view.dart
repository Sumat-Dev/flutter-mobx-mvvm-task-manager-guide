import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_mobx_mvvm_task_manager/core/base/view/base_view.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_model.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/model/task_status.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/view/task_detail_view.dart';
import 'package:flutter_mobx_mvvm_task_manager/features/task/viewmodel/task_view_model.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  TaskStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return BaseView<TaskViewModel>(
      onModelReady: (viewModel) async {
        viewModel.setContext(context);
        await viewModel.init();
      },
      onPageBuilder: (context, viewModel) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppBar(viewModel),
        body: Observer(
          builder: (_) {
            if (viewModel.isLoading) return _buildLoading();
            if (viewModel.errorMessage != null) return _buildError(viewModel);
            if (viewModel.tasks.isEmpty) return _buildEmptyState();
            return _buildTaskList(viewModel);
          },
        ),
        floatingActionButton: _buildFAB(context),
      ),
    );
  }

  AppBar _buildAppBar(TaskViewModel viewModel) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
      title: const Text('My Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      actions: [
        _buildFilterMenu(viewModel),
        IconButton(
          onPressed: () => viewModel.getTasks(status: _selectedStatus),
          icon: const Icon(Icons.refresh_rounded),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildFilterMenu(TaskViewModel viewModel) {
    return PopupMenuButton<TaskStatus?>(
      icon: const Icon(Icons.filter_list_rounded),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (status) async {
        setState(() => _selectedStatus = status);
        await viewModel.getTasks(status: status);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(child: Text('All')),
        ...TaskStatus.values.map(
          (status) => PopupMenuItem(
            value: status,
            child: Text(status.name),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError(TaskViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, size: 48, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(
            'Oops! Error: ${viewModel.errorMessage}',
            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
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

  Widget _buildTaskList(TaskViewModel viewModel) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).copyWith(bottom: 80),
      itemCount: viewModel.tasks.length,
      itemBuilder: (context, index) => _TaskCard(task: viewModel.tasks[index]),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => MaterialPageRoute<void>(builder: (context) => const TaskDetailView()),
      icon: const Icon(Icons.add_rounded),
      label: const Text('New Task', style: TextStyle(fontWeight: FontWeight.bold)),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(task.status);
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
        onTap: () => MaterialPageRoute<void>(builder: (context) => TaskDetailView(task: task)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusIcon(statusColor),
              const SizedBox(width: 16),
              Expanded(child: _buildTaskInfo()),
              const SizedBox(width: 12),
              _buildStatusBadge(statusColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(_getStatusIcon(task.status), color: color, size: 24),
    );
  }

  Widget _buildTaskInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title ?? 'No Title',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black87),
        ),
        if (task.description?.isNotEmpty ?? false) ...[
          const SizedBox(height: 6),
          Text(
            task.description!,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildStatusBadge(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        task.status?.toUpperCase() ?? 'UNKNOWN',
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == TaskStatus.todo.name) return Colors.orange;
    if (status == TaskStatus.inProgress.name) return Colors.blue;
    if (status == TaskStatus.done.name) return Colors.green;
    return Colors.grey;
  }

  IconData _getStatusIcon(String? status) {
    if (status == TaskStatus.todo.name) return Icons.assignment_outlined;
    if (status == TaskStatus.inProgress.name) return Icons.pending_actions_rounded;
    if (status == TaskStatus.done.name) return Icons.check_circle_outline_rounded;
    return Icons.help_outline_rounded;
  }
}
