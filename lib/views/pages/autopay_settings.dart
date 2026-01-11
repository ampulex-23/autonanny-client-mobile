import 'package:flutter/material.dart';
import 'package:nanny_client/view_models/pages/autopay_settings_vm.dart';
import 'package:nanny_components/nanny_components.dart';

/// FE-MVP-020: Экран настроек автоматического списания
class AutopaySettingsView extends StatefulWidget {
  const AutopaySettingsView({super.key});

  @override
  State<AutopaySettingsView> createState() => _AutopaySettingsViewState();
}

class _AutopaySettingsViewState extends State<AutopaySettingsView> {
  late AutopaySettingsVM vm;

  @override
  void initState() {
    super.initState();
    vm = AutopaySettingsVM(context: context, update: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      appBar: const NannyAppBar(
        title: 'Автоплатежи',
        color: Color(0xFFf7f7f7),
      ),
      body: FutureLoader(
        future: vm.loadRequest,
        completeView: (context, data) {
          if (!data) {
            return const ErrorView(
              errorText: 'Не удалось загрузить данные',
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Информационная карточка
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF1976D2)),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Автоматическое списание происходит еженедельно с выбранной карты',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Переключатель автоплатежей
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.autorenew,
                        size: 32,
                        color: Color(0xFF6750A4),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Автоматическое списание',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2B2B2B),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Еженедельная оплата',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: vm.isAutopayEnabled,
                        onChanged: vm.toggleAutopay,
                        activeColor: const Color(0xFF6750A4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Выбор карты по умолчанию
                if (vm.isAutopayEnabled) ...[
                  const Text(
                    'Карта для списания',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2B2B2B),
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (vm.cards.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CD),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFFE69C)),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.warning_amber, color: Color(0xFF856404)),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'У вас нет привязанных карт',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF856404),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: vm.addCard,
                            icon: const Icon(Icons.add_card),
                            label: const Text('Добавить карту'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6750A4),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...vm.cards.map((card) {
                      final isSelected = vm.selectedCardId == card.id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => vm.selectCard(card.id),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF6750A4)
                                    : const Color(0xFFE0E0E0),
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  size: 32,
                                  color: isSelected
                                      ? const Color(0xFF6750A4)
                                      : const Color(0xFF757575),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '**** ${card.cardNumber}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF2B2B2B),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        card.name,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF757575),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF6750A4),
                                    size: 24,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  const SizedBox(height: 16),
                  
                  // Кнопка добавления карты
                  if (vm.cards.isNotEmpty)
                    TextButton.icon(
                      onPressed: vm.addCard,
                      icon: const Icon(Icons.add),
                      label: const Text('Добавить другую карту'),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF6750A4),
                      ),
                    ),
                ],
              ],
            ),
          );
        },
        errorView: (context, error) => ErrorView(errorText: error.toString()),
      ),
    );
  }
}
