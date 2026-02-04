import 'package:doctor_mate/core/helper/spacing.dart';
import 'package:doctor_mate/core/routing/routes.dart';
import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:doctor_mate/features/chat/data/models/chat_message_response.dart';
import 'package:doctor_mate/features/chat/ui/widgets/conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<ChatConversationResponse> _conversations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadConversations();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadConversations() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _conversations.addAll(_getMockConversations());
          _isLoading = false;
        });
      }
    });
  }

  List<ChatConversationResponse> _getMockConversations() {
    return [
      ChatConversationResponse(
        id: 'CONV001',
        appointmentId: 'APT001',
        doctorId: 'D001',
        doctorName: 'Dr. Sarah Johnson',
        doctorImage:
            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400',
        doctorSpecialty: 'Cardiologist',
        patientId: 'P123',
        patientName: 'John Doe',
        patientImage:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
        isOnline: true,
        unreadCount: 2,
        status: 'active',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        lastMessage: ChatMessageModel(
          id: 'MSG001',
          content: 'Thank you doctor, I\'ll follow your advice.',
          messageType: 'text',
          senderType: 'patient',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
        ),
      ),
      ChatConversationResponse(
        id: 'CONV002',
        appointmentId: 'APT002',
        doctorId: 'D002',
        doctorName: 'Dr. Michael Chen',
        doctorImage:
            'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400',
        doctorSpecialty: 'Dermatologist',
        patientId: 'P123',
        patientName: 'John Doe',
        patientImage:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
        isOnline: false,
        unreadCount: 0,
        status: 'active',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        lastMessage: ChatMessageModel(
          id: 'MSG002',
          content:
              'The medication should help within 3-5 days. Let me know if symptoms persist.',
          messageType: 'text',
          senderType: 'doctor',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: true,
        ),
      ),
      ChatConversationResponse(
        id: 'CONV003',
        appointmentId: 'APT003',
        doctorId: 'D003',
        doctorName: 'Dr. Emily Roberts',
        doctorImage:
            'https://images.unsplash.com/photo-1594824476967-48c8b964273f?w=400',
        doctorSpecialty: 'General Practitioner',
        patientId: 'P123',
        patientName: 'John Doe',
        patientImage:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
        isOnline: true,
        unreadCount: 1,
        status: 'active',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 5)),
        lastMessage: ChatMessageModel(
          id: 'MSG003',
          content:
              'Your lab results are ready. Can we schedule a call to discuss?',
          messageType: 'text',
          senderType: 'doctor',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          isRead: false,
        ),
      ),
      ChatConversationResponse(
        id: 'CONV004',
        appointmentId: 'APT004',
        doctorId: 'D004',
        doctorName: 'Dr. James Wilson',
        doctorImage:
            'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400',
        doctorSpecialty: 'Pediatrician',
        patientId: 'P123',
        patientName: 'John Doe',
        patientImage:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
        isOnline: false,
        unreadCount: 0,
        status: 'active',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        lastMessage: ChatMessageModel(
          id: 'MSG004',
          content: 'Great! The treatment plan is working well.',
          messageType: 'text',
          senderType: 'patient',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isRead: true,
        ),
      ),
    ];
  }

  List<ChatConversationResponse> get _activeConversations =>
      _conversations.where((c) => c.status == 'active').toList();

  List<ChatConversationResponse> get _archivedConversations =>
      _conversations.where((c) => c.status == 'archived').toList();

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
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildConversationList(_activeConversations),
                  _buildConversationList(_archivedConversations),
                ],
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
                Text(
                  '${_conversations.where((c) => (c.unreadCount ?? 0) > 0).length} unread',
                  style: TextStyles.font12DarkGreenRegular.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // TODO: Search functionality
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Iconsax.search_normal_1,
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
      child: TabBar(
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
                if (_activeConversations.isNotEmpty) ...[
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
                      '${_activeConversations.length}',
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
      ),
    );
  }

  Widget _buildConversationList(List<ChatConversationResponse> conversations) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorsManager.primaryColor),
      );
    }

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
