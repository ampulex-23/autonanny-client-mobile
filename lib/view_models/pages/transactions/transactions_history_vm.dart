import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/from_api/transaction.dart';

/// FE-MVP-023: ViewModel для истории транзакций
class TransactionsHistoryVM extends ViewModelBase {
  TransactionsHistoryVM({
    required super.context,
    required super.update,
  });

  final TextEditingController searchController = TextEditingController();
  
  List<Transaction> allTransactions = [];
  List<Transaction> filteredTransactions = [];
  TransactionFilter filter = TransactionFilter();

  bool get hasActiveFilters {
    return filter.startDate != null ||
           filter.endDate != null ||
           (filter.types != null && filter.types!.isNotEmpty) ||
           filter.minAmount != null ||
           filter.maxAmount != null ||
           (filter.searchQuery != null && filter.searchQuery!.isNotEmpty);
  }

  @override
  Future<bool> loadPage() async {
    // TODO: Загрузить транзакции с сервера
    // final result = await NannyUsersApi.getTransactions();
    // if (result.success && result.response != null) {
    //   allTransactions = result.response!;
    //   applyFilters();
    //   return true;
    // }
    // return false;

    // Тестовые данные
    await Future.delayed(const Duration(milliseconds: 500));
    allTransactions = _generateMockData();
    applyFilters();
    return true;
  }

  void applyFilters() {
    filteredTransactions = allTransactions.where((t) => filter.matches(t)).toList();
    filteredTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    update(() {});
  }

  void onSearchChanged(String query) {
    filter = TransactionFilter(
      startDate: filter.startDate,
      endDate: filter.endDate,
      types: filter.types,
      minAmount: filter.minAmount,
      maxAmount: filter.maxAmount,
      searchQuery: query.isEmpty ? null : query,
    );
    applyFilters();
  }

  void clearSearch() {
    searchController.clear();
    onSearchChanged('');
  }

  void clearFilters() {
    filter = TransactionFilter();
    searchController.clear();
    applyFilters();
  }

  Future<void> refresh() async {
    await reloadPage();
  }

  void showFilterDialog() {
    // TODO: Показать диалог с фильтрами
    NannyDialogs.showMessageBox(
      context,
      "Фильтры",
      "Диалог фильтров будет добавлен в следующей версии",
    );
  }

  void exportTransactions() {
    // TODO: Экспорт в PDF/Excel
    NannyDialogs.showMessageBox(
      context,
      "Экспорт",
      "Экспорт в PDF/Excel будет добавлен в следующей версии",
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Генерация тестовых данных
  List<Transaction> _generateMockData() {
    final now = DateTime.now();
    return [
      Transaction(
        id: 1,
        amount: 5000,
        type: 'deposit',
        description: 'Пополнение баланса через карту',
        createdAt: now.subtract(const Duration(days: 1)),
        status: 'completed',
      ),
      Transaction(
        id: 2,
        amount: -1500,
        type: 'payment',
        description: 'Оплата поездки #12345',
        createdAt: now.subtract(const Duration(days: 2)),
        status: 'completed',
      ),
      Transaction(
        id: 3,
        amount: 9750,
        type: 'earning',
        description: 'Выплата за неделю 15-21 октября',
        createdAt: now.subtract(const Duration(days: 3)),
        status: 'completed',
      ),
      Transaction(
        id: 4,
        amount: -500,
        type: 'withdrawal',
        description: 'Вывод средств на карту **** 1234',
        createdAt: now.subtract(const Duration(days: 5)),
        status: 'pending',
      ),
      Transaction(
        id: 5,
        amount: -50,
        type: 'commission',
        description: 'Комиссия за вывод средств',
        createdAt: now.subtract(const Duration(days: 5)),
        status: 'completed',
      ),
      Transaction(
        id: 6,
        amount: 3000,
        type: 'refund',
        description: 'Возврат за отмененную поездку',
        createdAt: now.subtract(const Duration(days: 7)),
        status: 'completed',
      ),
    ];
  }
}
