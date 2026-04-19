import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../controllers/holiday_controller.dart';
import '../models/holiday_model.dart';

class HolidayScreen extends StatelessWidget {
  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HolidayController controller = Get.put(HolidayController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
        appBar: AppBar(
          title:  Text('Holidays ${DateTime.now().year}'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.status.value == ApiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.status.value == ApiStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Failed to load holidays'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchHolidays,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (controller.holidays.isEmpty) {
            return const Center(child: Text('No holidays found for this year.'));
          }

          return TabBarView(
            children: [
              _HolidayList(holidays: controller.upcomingHolidays),
              _HolidayList(holidays: controller.pastHolidays),
            ],
          );
        }),
      ),
    );
  }
}

class _HolidayList extends StatelessWidget {
  final List<HolidayModel> holidays;

  const _HolidayList({required this.holidays});

  @override
  Widget build(BuildContext context) {
    if (holidays.isEmpty) {
      return const Center(child: Text('No holidays to show.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: holidays.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _HolidayCard(holiday: holidays[index]);
      },
    );
  }
}

class _HolidayCard extends StatelessWidget {
  final HolidayModel holiday;

  const _HolidayCard({required this.holiday});

  @override
  Widget build(BuildContext context) {
    final bool isUpcoming = holiday.date.isAfter(DateTime.now().subtract(const Duration(days: 1)));
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isUpcoming ? null : Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Date Section
            Container(
              width: 80,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color:  isUpcoming ? const Color(0xFF00838F) : Colors.grey.shade200,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getMonth(holiday.date),
                    style: TextStyle(
                      color: isUpcoming ? Colors.white70 : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    holiday.date.day.toString(),
                    style: TextStyle(
                      color: isUpcoming ? Colors.white : Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            holiday.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        _TypeTag(type: holiday.type, isUpcoming: isUpcoming),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      holiday.getDayName,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonth(DateTime date) {
    const months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
    return months[date.month - 1];
  }
}

class _TypeTag extends StatelessWidget {
  final String type;
  final bool isUpcoming;

  const _TypeTag({required this.type, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (type.toUpperCase()) {
      case 'PUBLIC':
        color = Colors.green;
        break;
      case 'COMPANY':
        color = Colors.blue;
        break;
      default:
        color = Colors.cyan;
    }

    if (!isUpcoming) color = Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
