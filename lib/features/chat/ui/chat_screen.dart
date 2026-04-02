import 'package:doctor_mate/core/di/dependency_injection.dart';
import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/logic/chat_list_cubit.dart';
import 'package:doctor_mate/features/chat/logic/chat_list_state.dart';
import 'package:doctor_mate/features/chat/ui/widgets/conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatListCubit>()..loadConversations(),
      child: const _ChatScreenContent(),
    );
  }
}

class _ChatScreenContent extends StatefulWidget {
  const _ChatScreenContent();

  @override
  State<_ChatScreenContent> createState() => _ChatScreenContentState();
}

class _ChatScreenContentState extends State<_ChatScreenContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<ChatConversationResponse> _getActiveConversations(
    List<ChatConversationResponse> conversations,
  ) => conversations.where((c) => c.status == 'active').toList();

  List<ChatConversationResponse> _getArchivedConversations(
    List<ChatConversationResponse> conversations,
  ) => conversations.where((c) => c.status == 'archived').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildTabBar(),
            Expanded(
              child: BlocBuilder<ChatListCubit, ChatListState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading:
                        () => const Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                    success: (conversations) {
                      final activeConversations = _getActiveConversations(
                        conversations,
                      );
                      final archivedConversations = _getArchivedConversations(
                        conversations,
                      );

                      return TabBarView(
                        controller: _tabController,
                        children: [
                          _buildConversationList(activeConversations),
                          _buildConversationList(archivedConversations),
                        ],
                      );
                    },
                    error:
                        (message) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.info_circle,
                                size: 64.sp,
                                color: Colors.red.shade300,
                              ),
                              verticalSpacing(16),
                              Text(
                                'Error loading conversations',
                                style: TextStyles.font18DarkGreenBold,
                              ),
                              verticalSpacing(8),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32.w),
                                child: Text(
                                  message,
                                  style: TextStyles.font14DarkGreenMedium
                                      .copyWith(color: Colors.grey.shade600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              verticalSpacing(16),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ChatListCubit>()
                                      .loadConversations();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsManager.primaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.w,
                                    vertical: 12.h,
                                  ),
                                ),
                                child: Text(
                                  'Retry',
                                  style: TextStyles.font14GreenSemiBold
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF34A853), Color(0xFF2E7D32)],
              ),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF34A853).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Iconsax.messages, color: Colors.white, size: 24.sp),
          ),
          horizantialSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Messages', style: TextStyles.font18DarkGreenBold),
                verticalSpacing(2),
                BlocBuilder<ChatListCubit, ChatListState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      success:
                          (conversations) => Text(
                            '${conversations.where((c) => (c.unreadCount ?? 0) > 0).length} unread',
                            style: TextStyles.font12DarkGreenRegular.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                      orElse:
                          () => Text(
                            '0 unread',
                            style: TextStyles.font12DarkGreenRegular.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<ChatListCubit>().refreshConversations();
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Iconsax.refresh,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: BlocBuilder<ChatListCubit, ChatListState>(
        builder: (context, state) {
          final activeCount = state.maybeWhen(
            success:
                (conversations) =>
                    _getActiveConversations(conversations).length,
            orElse: () => 0,
          );

          return TabBar(
            controller: _tabController,
            indicatorColor: ColorsManager.primaryColor,
            indicatorWeight: 3,
            labelColor: ColorsManager.primaryColor,
            unselectedLabelColor: Colors.grey.shade600,
            labelStyle: TextStyles.font14GreenSemiBold,
            unselectedLabelStyle: TextStyles.font14DarkGreenMedium,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Active'),
                    if (activeCount > 0) ...[
                      horizantialSpacing(6),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '$activeCount',
                          style: TextStyles.font12DarkGreenSemiBold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Tab(text: 'Archived'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConversationList(List<ChatConversationResponse> conversations) {
    if (conversations.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return ConversationCard(
          conversation: conversation,
          onTap: () {
            context.push(
              '${Routes.chatConversationScreen}?conversationId=${conversation.id}',
              extra: conversation,
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.message_text,
              color: Colors.grey.shade400,
              size: 56.sp,
            ),
          ),
          verticalSpacing(24),
          Text(
            'No conversations yet',
            style: TextStyles.font18DarkGreenBold.copyWith(
              color: Colors.grey.shade800,
            ),
          ),
          verticalSpacing(8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              'Start chatting with your doctor after booking an appointment',
              style: TextStyles.font14DarkGreenMedium.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
