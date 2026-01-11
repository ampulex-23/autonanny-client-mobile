import 'package:flutter/material.dart';
import 'package:nanny_client/view_models/pages/children_list_vm.dart';
import 'package:nanny_components/nanny_components.dart';

class ChildrenListView extends StatefulWidget {
  const ChildrenListView({super.key});

  @override
  State<ChildrenListView> createState() => _ChildrenListViewState();
}

class _ChildrenListViewState extends State<ChildrenListView> {
  late ChildrenListVM vm;

  @override
  void initState() {
    super.initState();
    vm = ChildrenListVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: const NannyAppBar(
        color: Color(0xFFF7F7F7),
        hasBackButton: true,
        title: "Мои дети",
      ),
      body: FutureLoader(
        future: vm.loadRequest,
        completeView: (context, data) {
          if (!data) {
            return const ErrorView(
              errorText: "Не удалось загрузить данные!\nПовторите попытку",
            );
          }

          if (vm.children.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.child_care,
                    size: 80,
                    color: Color(0xFFE0E0E0),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'У вас пока нет добавленных детей',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: vm.addChild,
                    icon: const Icon(Icons.add),
                    label: const Text('Добавить ребенка'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NannyTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.children.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final child = vm.children[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: ProfileImage(
                          url: child.photoPath ?? '',
                          radius: 50,
                        ),
                        title: Text(
                          child.fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2B2B2B),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              child.ageDisplay,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF757575),
                              ),
                            ),
                            if (child.schoolClass != null && child.schoolClass!.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                child.schoolClass!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => vm.editChild(child),
                              icon: const Icon(Icons.edit, size: 20),
                              color: NannyTheme.primary,
                              splashRadius: 20,
                            ),
                            IconButton(
                              onPressed: () => vm.deleteChild(child),
                              icon: const Icon(Icons.delete, size: 20),
                              color: Colors.red,
                              splashRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: vm.addChild,
                      icon: const Icon(Icons.add),
                      label: const Text('Добавить ребенка'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: NannyTheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        errorView: (context, error) => ErrorView(errorText: error.toString()),
      ),
    );
  }
}
