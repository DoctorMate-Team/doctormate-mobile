import 'package:doctor_mate/features/notifications/data/models/notification_model.dart';
import 'package:doctor_mate/features/notifications/data/repos/notifications_repository.dart';
import 'package:doctor_mate/features/notifications/logic/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._notificationsRepository)
    : super(const NotificationsState.initial());

  final NotificationsRepository _notificationsRepository;

  // In-memory cache for notifications
  List<NotificationModel> _allNotifications = [];
  int _currentPage = 1;
  int _totalItems = 0;
  bool _hasNextPage = false;
  bool _hasPreviousPage = false;
  final int _limit = 10;

  // Get notifications
  Future<void> getNotifications({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _allNotifications.clear();
    }

    emit(const NotificationsState.loadingNotifications());

    final result = await _notificationsRepository.getNotifications(
      page: _currentPage,
      limit: _limit,
    );

    result.when(
      success: (response) {
        _allNotifications = response.data.data;
        _totalItems = response.data.totalItems;
        _hasNextPage = response.data.hasNextPage;
        _hasPreviousPage = response.data.hasPreviousPage;

        emit(
          NotificationsState.successNotifications(
            notifications: _allNotifications,
            totalItems: _totalItems,
            currentPage: _currentPage,
            hasNextPage: _hasNextPage,
            hasPreviousPage: _hasPreviousPage,
          ),
        );

        // Also fetch unread count
        getUnreadCount();
      },
      failure: (error) {
        emit(
          NotificationsState.errorNotifications(
            message:
                error.apiErrorModel.message ?? 'Failed to load notifications',
          ),
        );
      },
    );
  }

  // Load more notifications (for pagination)
  Future<void> loadMoreNotifications() async {
    if (!_hasNextPage) return;

    emit(
      NotificationsState.loadingMoreNotifications(
        currentNotifications: _allNotifications,
      ),
    );

    _currentPage++;

    final result = await _notificationsRepository.getNotifications(
      page: _currentPage,
      limit: _limit,
    );

    result.when(
      success: (response) {
        _allNotifications.addAll(response.data.data);
        _totalItems = response.data.totalItems;
        _hasNextPage = response.data.hasNextPage;
        _hasPreviousPage = response.data.hasPreviousPage;

        emit(
          NotificationsState.successLoadMore(
            notifications: _allNotifications,
            totalItems: _totalItems,
            currentPage: _currentPage,
            hasNextPage: _hasNextPage,
            hasPreviousPage: _hasPreviousPage,
          ),
        );
      },
      failure: (error) {
        _currentPage--; // Revert page increment on error
        emit(
          NotificationsState.errorLoadMore(
            currentNotifications: _allNotifications,
            message:
                error.apiErrorModel.message ??
                'Failed to load more notifications',
          ),
        );
      },
    );
  }

  // Get unread count
  Future<void> getUnreadCount() async {
    final result = await _notificationsRepository.getUnreadCount();

    result.when(
      success: (response) {
        emit(NotificationsState.unreadCountUpdated(count: response.data.count));
      },
      failure: (error) {
        // Silently fail for unread count
      },
    );
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    final result = await _notificationsRepository.markNotificationAsRead(
      notificationId: notificationId,
    );

    result.when(
      success: (response) {
        // Update local cache
        final index = _allNotifications.indexWhere(
          (n) => n.id == notificationId,
        );
        if (index != -1) {
          _allNotifications[index] = NotificationModel(
            id: _allNotifications[index].id,
            title: _allNotifications[index].title,
            message: _allNotifications[index].message,
            type: _allNotifications[index].type,
            metadata: _allNotifications[index].metadata,
            isRead: true,
            createdAt: _allNotifications[index].createdAt,
          );
        }

        emit(
          NotificationsState.successNotifications(
            notifications: _allNotifications,
            totalItems: _totalItems,
            currentPage: _currentPage,
            hasNextPage: _hasNextPage,
            hasPreviousPage: _hasPreviousPage,
          ),
        );

        // Refresh unread count
        getUnreadCount();
      },
      failure: (error) {
        emit(
          NotificationsState.errorMarkAsRead(
            message: error.apiErrorModel.message ?? 'Failed to mark as read',
          ),
        );
      },
    );
  }

  // Mark all notifications as read
  Future<void> markAllNotificationsAsRead() async {
    final result = await _notificationsRepository.markAllNotificationsAsRead();

    result.when(
      success: (response) {
        // Update local cache
        _allNotifications =
            _allNotifications.map((notification) {
              return NotificationModel(
                id: notification.id,
                title: notification.title,
                message: notification.message,
                type: notification.type,
                metadata: notification.metadata,
                isRead: true,
                createdAt: notification.createdAt,
              );
            }).toList();

        emit(const NotificationsState.successMarkAllAsRead());

        // Refresh the notifications list
        getNotifications(refresh: true);
      },
      failure: (error) {
        emit(
          NotificationsState.errorMarkAllAsRead(
            message:
                error.apiErrorModel.message ?? 'Failed to mark all as read',
          ),
        );
      },
    );
  }

  // Delete notification (optimistic update)
  void deleteNotification(String notificationId) {
    _allNotifications.removeWhere((n) => n.id == notificationId);
    _totalItems--;

    emit(
      NotificationsState.successNotifications(
        notifications: _allNotifications,
        totalItems: _totalItems,
        currentPage: _currentPage,
        hasNextPage: _hasNextPage,
        hasPreviousPage: _hasPreviousPage,
      ),
    );

    // Refresh unread count
    getUnreadCount();
  }

  // Clear all notifications (local only)
  void clearAllNotifications() {
    _allNotifications.clear();
    _totalItems = 0;
    _currentPage = 1;

    emit(
      NotificationsState.successNotifications(
        notifications: [],
        totalItems: 0,
        currentPage: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      ),
    );

    // Refresh unread count
    getUnreadCount();
  }

  // Get current notifications list
  List<NotificationModel> get currentNotifications => _allNotifications;

  // Check if has more pages
  bool get hasMorePages => _hasNextPage;
}
