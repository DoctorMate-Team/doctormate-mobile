import 'package:doctor_mate/core/models/notification_type.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/features/notifications/data/models/notification_model.dart';
import 'package:doctor_mate/features/notifications/logic/notifications_cubit.dart';
import 'package:doctor_mate/features/notifications/logic/notifications_state.dart';
import 'package:doctor_mate/features/notifications/ui/widgets/notification_card.dart';
import 'package:doctor_mate/features/notifications/ui/widgets/notification_filter_tabs.dart';
import 'package:doctor_mate/features/notifications/ui/widgets/notifications_app_bar.dart';
import 'package:doctor_mate/features/notifications/ui/widgets/notifications_empty_state.dart';
import 'package:doctor_mate/features/notifications/ui/widgets/notifications_error_state.dart';
import 'package:doctor_mate/features/notifications/ui/widgets/notifications_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && context.read<NotificationsCubit>().hasMorePages) {
      context.read<NotificationsCubit>().loadMoreNotifications();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  List<NotificationModel> _filterNotifications(
    List<NotificationModel> notifications,
  ) {
    if (_selectedFilter == 'All') {
      return notifications;
    }

    return notifications.where((notification) {
      switch (_selectedFilter) {
        case 'Appointments':
          return notification.notificationType ==
                  NotificationType.appointmentReminder ||
              notification.notificationType ==
                  NotificationType.appointmentConfirmed ||
              notification.notificationType ==
                  NotificationType.appointmentCancelled;
        case 'Diagnosis':
          return notification.notificationType ==
              NotificationType.diagnosisAdded;
        case 'Prescriptions':
          return notification.notificationType ==
              NotificationType.prescriptionCreated;
        default:
          return true;
      }
    }).toList();
  }

  void _handleMarkAllRead() {
    context.read<NotificationsCubit>().markAllNotificationsAsRead();
  }

  void _handleNotificationTap(NotificationModel notification) {
    // Mark as read when tapped
    if (!notification.isRead) {
      context.read<NotificationsCubit>().markNotificationAsRead(
        notification.id,
      );
    }

    // Navigate based on notification type
    switch (notification.notificationType) {
      case NotificationType.appointmentConfirmed:
      case NotificationType.appointmentCancelled:
      case NotificationType.appointmentReminder:
        final appointmentId = notification.appointmentId;
        if (appointmentId != null) {
          context.pushNamed(
            Routes.appointmentDetails,
            queryParameters: {'appointmentId': appointmentId},
          );
        }
        break;

      case NotificationType.diagnosisAdded:
        final diagnosisId = notification.diagnosisId;
        if (diagnosisId != null) {
          // Navigate to medical records or diagnosis details
          context.pushNamed(Routes.medicalRecordScreen);
        }
        break;

      case NotificationType.prescriptionCreated:
        final prescriptionId = notification.prescriptionId;
        if (prescriptionId != null) {
          context.pushNamed(
            Routes.prescriptionsScreen,
            queryParameters: {'prescriptionId': prescriptionId},
          );
        }
        break;

      case NotificationType.unknown:
        break;
    }
  }

  void _handleNotificationDelete(NotificationModel notification) {
    context.read<NotificationsCubit>().deleteNotification(notification.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${notification.title} deleted'),
        backgroundColor: Colors.red.shade400,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: NotificationsAppBar(onMarkAllRead: _handleMarkAllRead),
      body: Column(
        children: [
          // Filter Tabs
          NotificationFilterTabs(
            selectedFilter: _selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),

          // Notifications List
          Expanded(
            child: BlocConsumer<NotificationsCubit, NotificationsState>(
              listenWhen:
                  (previous, current) =>
                      current is SuccessMarkAllAsRead ||
                      current is ErrorMarkAllAsRead ||
                      current is ErrorNotifications,
              buildWhen:
                  (previous, current) =>
                      current is LoadingNotifications ||
                      current is SuccessNotifications ||
                      current is ErrorNotifications ||
                      current is LoadingMoreNotifications ||
                      current is SuccessLoadMore,
              listener: (context, state) {
                state.maybeWhen(
                  successMarkAllAsRead: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('All notifications marked as read'),
                        backgroundColor: ColorsManager.primaryColor,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  errorMarkAllAsRead: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red.shade400,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  errorNotifications: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red.shade400,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loadingNotifications:
                      () => const Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                  successNotifications: (
                    notifications,
                    totalItems,
                    currentPage,
                    hasNextPage,
                    hasPreviousPage,
                  ) {
                    final filteredNotifications = _filterNotifications(
                      notifications,
                    );

                    if (filteredNotifications.isEmpty) {
                      return NotificationsEmptyState(
                        filterType: _selectedFilter,
                        onRefresh: () {
                          context.read<NotificationsCubit>().getNotifications(
                            refresh: true,
                          );
                        },
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<NotificationsCubit>()
                            .getNotifications(refresh: true);
                      },
                      color: ColorsManager.primaryColor,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16.w),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount:
                            filteredNotifications.length +
                            (hasNextPage ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= filteredNotifications.length) {
                            return const NotificationsLoadingIndicator();
                          }

                          final notification = filteredNotifications[index];
                          return NotificationCard(
                            title: notification.title,
                            message: notification.message,
                            type: notification.notificationType,
                            timestamp: notification.createdAt,
                            isRead: notification.isRead,
                            onTap: () => _handleNotificationTap(notification),
                            onDelete:
                                () => _handleNotificationDelete(notification),
                          );
                        },
                      ),
                    );
                  },
                  successLoadMore: (
                    notifications,
                    totalItems,
                    currentPage,
                    hasNextPage,
                    hasPreviousPage,
                  ) {
                    final filteredNotifications = _filterNotifications(
                      notifications,
                    );

                    if (filteredNotifications.isEmpty) {
                      return NotificationsEmptyState(
                        filterType: _selectedFilter,
                        onRefresh: () {
                          context.read<NotificationsCubit>().getNotifications(
                            refresh: true,
                          );
                        },
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<NotificationsCubit>()
                            .getNotifications(refresh: true);
                      },
                      color: ColorsManager.primaryColor,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16.w),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount:
                            filteredNotifications.length +
                            (hasNextPage ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= filteredNotifications.length) {
                            return const NotificationsLoadingIndicator();
                          }

                          final notification = filteredNotifications[index];
                          return NotificationCard(
                            title: notification.title,
                            message: notification.message,
                            type: notification.notificationType,
                            timestamp: notification.createdAt,
                            isRead: notification.isRead,
                            onTap: () => _handleNotificationTap(notification),
                            onDelete:
                                () => _handleNotificationDelete(notification),
                          );
                        },
                      ),
                    );
                  },
                  loadingMoreNotifications: (currentNotifications) {
                    final filteredNotifications = _filterNotifications(
                      currentNotifications,
                    );

                    return RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<NotificationsCubit>()
                            .getNotifications(refresh: true);
                      },
                      color: ColorsManager.primaryColor,
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16.w),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: filteredNotifications.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= filteredNotifications.length) {
                            return const NotificationsLoadingIndicator();
                          }

                          final notification = filteredNotifications[index];
                          return NotificationCard(
                            title: notification.title,
                            message: notification.message,
                            type: notification.notificationType,
                            timestamp: notification.createdAt,
                            isRead: notification.isRead,
                            onTap: () => _handleNotificationTap(notification),
                            onDelete:
                                () => _handleNotificationDelete(notification),
                          );
                        },
                      ),
                    );
                  },
                  errorNotifications:
                      (message) => NotificationsErrorState(
                        message: message,
                        onRetry: () {
                          context.read<NotificationsCubit>().getNotifications(
                            refresh: true,
                          );
                        },
                      ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
