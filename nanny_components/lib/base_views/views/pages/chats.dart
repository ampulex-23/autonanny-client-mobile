import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/pages/chats_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/from_api/drive_and_map/drive_tariff.dart';
import 'package:nanny_core/models/from_api/drive_and_map/schedule.dart';
import 'package:nanny_core/models/from_api/drive_and_map/schedule_responses_data.dart';
import 'package:nanny_core/models/from_api/other_parametr.dart';
import 'package:nanny_core/nanny_core.dart';

class ChatsView extends StatefulWidget {
  final bool persistState;

  const ChatsView({
    super.key,
    this.persistState = false,
  });

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView>
    with AutomaticKeepAliveClientMixin {
  late ChatsVM vm;

  @override
  void initState() {
    super.initState();
    vm = ChatsVM(context: context, update: setState);
  }

  @override
  void dispose() {
    super.dispose();
    vm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (wantKeepAlive) super.build(context);

    return Scaffold(
      appBar: const NannyAppBar(
        title: "Чаты",
        color: NannyTheme.secondary,
        isTransparent: false,
        hasBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              NannyTextForm(
                node: vm.node,
                hintText: 'Поиск по чатам..',
                onChanged: vm.chatSearch,
                suffixIcon: const Icon(Icons.search_rounded,
                    color: NannyTheme.onSurface),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => vm.chatsSwitch(switchToChats: false),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            !vm.chatsSelected
                                ? NannyTheme.primary
                                : NannyTheme.secondary),
                        foregroundColor: WidgetStatePropertyAll(
                          !vm.chatsSelected
                              ? NannyTheme.secondary
                              : const Color(0xFF2B2B2B),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        minimumSize: const WidgetStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: const Text("Заявки"),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => vm.chatsSwitch(switchToChats: true),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(vm.chatsSelected
                            ? NannyTheme.primary
                            : NannyTheme.secondary),
                        foregroundColor: WidgetStatePropertyAll(
                          vm.chatsSelected
                              ? NannyTheme.secondary
                              : const Color(0xFF2B2B2B),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        minimumSize: const WidgetStatePropertyAll(
                          Size(double.infinity, 50),
                        ),
                      ),
                      child: const Text("Чаты"),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: StatefulBuilder(builder: (context, update) {
                  vm.updateList = () => update(() {});

                  return vm.chatsSelected
                      ? RequestLoader(
                          request: vm.getChats,
                          completeView: (context, data) {
                            if (data == null) {
                              return const Center(
                                child: Text("У вас пока что нет чатов..."),
                              );
                            }

                            return ListView.separated(
                                padding: const EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var e = data.chats[index];
                                  return InkWell(
                                    onTap: () {
                                      vm.navigateToDirect(e);
                                      if (vm.node.hasFocus) {
                                        vm.node.unfocus();
                                      }
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Card(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 6),
                                            shape:
                                                const RoundedRectangleBorder(),
                                            elevation: 0,
                                            color: Colors.transparent,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Аватар пользователя
                                                ProfileImage(
                                                    url: e.photoPath,
                                                    radius: 50),
                                                const SizedBox(width: 11),

                                                // Текстовые элементы (Имя и Сообщение)
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e.username,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF2B2B2B),
                                                            fontSize: 16,
                                                            height: 17.6 / 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Nanito'),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        e.message == null
                                                            ? "Нет сообщений"
                                                            : e.message!.msg,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF6D6D6D),
                                                            fontSize: 12,
                                                            height: 16.8 / 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Nanito'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 11),

                                                // Время последнего сообщения
                                                Text(
                                                  e.message != null
                                                      ? DateFormat("HH:mm")
                                                          .format(
                                                          DateTime
                                                              .fromMillisecondsSinceEpoch(
                                                            e.message!.time *
                                                                1000,
                                                          ),
                                                        )
                                                      : "",
                                                  style: const TextStyle(
                                                      color: Color(0xFF2B2B2B),
                                                      fontSize: 12,
                                                      height: 14.4 / 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Nanito'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Разделитель
                                          if (index == data.chats.length - 1)
                                            const Divider(
                                                thickness: 1,
                                                height: 1,
                                                color: NannyTheme.grey),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                        thickness: 1,
                                        height: 1,
                                        color: NannyTheme.grey),
                                itemCount: data.chats.length);
                          },
                          errorView: (context, error) => ErrorView(
                            errorText: error.toString(),
                          ),
                        )
                      : RequestLoader(
                          request: vm.getRequests,
                          completeView: (context, data) {
                            //List<ScheduleResponsesData>? data = List.generate(
                            //  10,
                            //  (index) => ScheduleResponsesData(
                            //    id: 9,
                            //    idDriver: 9,
                            //    name: '123',
                            //    photoPath: 'photoPath',
                            //    idSchedule: 1,
                            //    fullTime: index % 2 == 0,
                            //    schedule: Schedule(
                            //      title: 'title',
                            //      duration: 500,
                            //      childrenCount: 5,
                            //      datetimeCreate: DateTime.now(),
                            //      weekdays: [NannyWeekday.friday],
                            //      tariff: DriveTariff(id: 3),
                            //      otherParametrs: [
                            //        OtherParametr(),
                            //      ],
                            //      roads: [
                            //        //Road(
                            //        //    weekDay: weekDay,
                            //        //    startTime: startTime,
                            //        //    endTime: endTime,
                            //        //    addresses: addresses,
                            //        //    title: title,
                            //        //    typeDrive: typeDrive)
                            //      ],
                            //    ),
                            //    idChat: index,
                            //    data: [ResponseRoadData(idRoad: 1, weekDay: 1)],
                            //  ),
                            //);

                            if ((data ?? []).isEmpty) {
                              return const Center(
                                child: Text("У вас нет заявок"),
                              );
                            }

                            return ListView(
                              padding: const EdgeInsets.only(bottom: 12),
                              children: [
                                requestItem(
                                    data: data!
                                        .where((e) => e.fullTime)
                                        .toList()),
                                const SizedBox(height: 12),
                                requestItem(
                                    data: data
                                        .where((e) => !e.fullTime)
                                        .toList()),
                              ],
                            );
                          },
                          errorView: (context, error) =>
                              ErrorView(errorText: error.toString()),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestItem({required List<ScheduleResponsesData> data}) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 20),
      decoration: BoxDecoration(
        color: NannyTheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            data.any((e) => e.fullTime)
                ? 'Заявки на полную занятость'
                : 'Заявки на частичную занятость',
            style: TextStyle(
                color: NannyTheme.onSecondary,
                fontSize: 18,
                height: 20 / 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito'),
          ),
          const SizedBox(height: 20),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var e = data[index];
                return InkWell(
                  onTap: () => vm.checkScheduleRequest(e),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.only(top: 10, bottom: 6),
                          shape: const RoundedRectangleBorder(),
                          elevation: 0,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Аватар пользователя
                              ProfileImage(url: e.photoPath, radius: 50),
                              const SizedBox(width: 11),

                              // Текстовые элементы (Имя и Сообщение)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name,
                                      style: const TextStyle(
                                          color: Color(0xFF2B2B2B),
                                          fontSize: 16,
                                          height: 17.6 / 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Nanito'),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      e.schedule?.title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Color(0xFF6D6D6D),
                                          fontSize: 12,
                                          height: 16.8 / 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Nanito'),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 11),

                              // Время последнего сообщения
                              Text(
                                e.schedule?.datetimeCreate != null
                                    ? DateFormat("HH:mm").format(
                                        e.schedule?.datetimeCreate ??
                                            DateTime.now(),
                                      )
                                    : "",
                                style: const TextStyle(
                                    color: Color(0xFF2B2B2B),
                                    fontSize: 12,
                                    height: 14.4 / 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nanito'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                  thickness: 1, height: 1, color: NannyTheme.grey),
              itemCount: data.length),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.persistState;
}
