/// FE-MVP-023: Модель финансовой транзакции
class Transaction {
  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.createdAt,
    this.status,
    this.relatedId,
  });

  final int id;
  final double amount;
  final String type; // deposit, withdrawal, payment, refund, commission
  final String description;
  final DateTime createdAt;
  final String? status; // completed, pending, failed
  final int? relatedId;

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] ?? 'unknown',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? json['datetime_create']),
      status: json['status'],
      relatedId: json['related_id'],
    );
  }

  bool get isIncome => amount > 0;
  bool get isExpense => amount < 0;

  String get typeText {
    switch (type) {
      case 'deposit':
        return 'Пополнение';
      case 'withdrawal':
        return 'Вывод средств';
      case 'payment':
        return 'Оплата';
      case 'refund':
        return 'Возврат';
      case 'commission':
        return 'Комиссия';
      case 'earning':
        return 'Заработок';
      default:
        return type;
    }
  }

  String get statusText {
    switch (status) {
      case 'completed':
        return 'Завершено';
      case 'pending':
        return 'В обработке';
      case 'failed':
        return 'Ошибка';
      default:
        return status ?? '';
    }
  }
}

/// Фильтр для транзакций
class TransactionFilter {
  TransactionFilter({
    this.startDate,
    this.endDate,
    this.types,
    this.minAmount,
    this.maxAmount,
    this.searchQuery,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? types;
  final double? minAmount;
  final double? maxAmount;
  final String? searchQuery;

  bool matches(Transaction transaction) {
    if (startDate != null && transaction.createdAt.isBefore(startDate!)) {
      return false;
    }
    if (endDate != null && transaction.createdAt.isAfter(endDate!)) {
      return false;
    }
    if (types != null && types!.isNotEmpty && !types!.contains(transaction.type)) {
      return false;
    }
    if (minAmount != null && transaction.amount.abs() < minAmount!) {
      return false;
    }
    if (maxAmount != null && transaction.amount.abs() > maxAmount!) {
      return false;
    }
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      if (!transaction.description.toLowerCase().contains(query) &&
          !transaction.typeText.toLowerCase().contains(query)) {
        return false;
      }
    }
    return true;
  }
}
