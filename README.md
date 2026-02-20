# DoctorMate - Medical Appointment Booking App

A professional Flutter application for booking medical appointments with doctors across various specialties.

## 📱 Project Overview

DoctorMate is a comprehensive medical appointment booking platform that connects patients with healthcare professionals. The app features a modern, user-friendly interface with real-time data integration, advanced state management, and push notification support for appointment reminders and health updates.

## 🏗️ Architecture

The project follows **Clean Architecture** principles with **BLoC Pattern** for state management:

```
lib/
├── core/
│   ├── di/                 # Dependency Injection (GetIt)
│   ├── functions/          # Utility functions
│   ├── helper/             # Helper classes
│   ├── models/             # Core models (including NotificationData, NotificationType)
│   ├── networking/         # API configuration (Retrofit, Dio)
│   ├── routing/            # Navigation (GoRouter)
│   ├── services/           # Firebase & Notification services
│   ├── theme/              # App theme & styles
│   └── widgets/            # Reusable widgets
├── features/
│   ├── auth/               # Authentication feature
│   ├── home/               # Home screen with doctors listing
│   ├── details/            # Doctor details screen
│   ├── appointment/        # Appointment booking feature
│   ├── onBoarding/         # Onboarding screens
│   ├── splash/             # Splash screen
│   └── profile/            # Profile screen
└── main.dart
```

## ✨ Features Implemented

### 🔐 Authentication Module
- **Login Screen**: Email/password authentication with validation
- **Sign Up**: User registration with form validation
- **Complete Profile**: Profile completion with image picker
  - Upload profile image (File & MultipartFile)
  - Form validation for personal information
  - Integration with authentication API

### 🏠 Home Screen
- **Specialties List**: Horizontal scrollable list with categories
  - Real-time data from API
  - Auto-selection of first specialty
  - Colorful icons with CachedNetworkImage support
  - Selected state with visual feedback
  
- **Doctors List**: Dynamic list based on selected specialty
  - Professional card design with doctor information
  - Doctor image, name, address, qualifications
  - Consultation fee display
  - Working hours with complete visibility
  - "Book Now" action button
  - Shimmer loading effects matching card design
  
- **Modern Quick Actions** (2 Actions in Column Layout):
  - **Scan QR**: Quick scan for appointments
    - Purple gradient with scan barcode icon
    - Horizontal card with arrow indicator
  - **Smart Checkup**: AI-powered health checkup
    - Red gradient with heart icon
    - Navigation to Smart Checkup screen
  - Professional card design with large icons (56×56)
  - Gradient backgrounds with shadows
  - Smooth tap interactions
  
- **Smart Caching System**:
  - Cache doctors by specialty ID
  - Prevent redundant API calls
  - Instant data display from cache
  - `clearDoctorsCache()` method for refresh

### 👨‍⚕️ Doctor Details Screen
- **Professional AppBar**: 
  - Clean design with 70.h height
  - Back button (44×44) and favorite button
  - Centered title with proper spacing
  
- **Doctor Header Card**:
  - Large doctor image with CachedNetworkImage
  - Verified badge
  - Action buttons (Call, Video, Message)
  
- **Quick Stats Section**:
  - Patients count, years of experience, rating
  - Gradient background design
  - Dividers between stats
  
- **Tab System** (About, Location, Reviews):
  - **About Tab**: Working hours, contact info, location, qualifications
  - **Location Tab**: Clinic address with map placeholder
  - **Reviews Tab**: Overall rating with individual patient reviews
  
- **Bottom Actions**:
  - Message button
  - Book Appointment button

- **Professional Loading States**:
  - Custom shimmer loading matching screen layout
  - Smooth transitions between states

### 📅 Appointment Booking System
- **Complete Booking Flow**:
  - 4-step wizard: Date/Time → Reason → Payment → Summary
  - Step validation preventing incomplete submissions
  - State persistence when navigating between steps
  - GoRouter integration with doctor details passed via extra parameter
  
- **Smart Date & Time Selection**:
  - **Intelligent Date Picker**: 
    - Automatically filtered by doctor's working days (Monday-Sunday)
    - Auto-selection of first available working day on screen load
    - Calendar-style display with 30-day range
    - Month navigation (previous/next)
  - **API-Driven Time Slots**:
    - Real-time availability fetched from server
    - Slots categorized by Morning (6am-12pm), Afternoon (12pm-5pm), Evening (5pm-10pm)
    - Automatic slot fetching on date change
    - Empty state when no slots available
    - Time format HH:mm with proper display
  
- **Appointment Type**:
  - Video Call, Voice Call, In-Person options
  - Visual selection with icons and descriptions
  - Default selection (Video Call) with automatic parent notification
  - Gradient backgrounds for selected state
  
- **Consultation Reason**:
  - 5 predefined reasons: Regular Checkup, Follow-up Visit, New Symptoms, Medical Reports, Prescription Refill
  - "Other" option with multi-line custom text input
  - State restoration on navigation (both predefined and custom)
  - Color-coded icons for each category
  
- **Payment Method**:
  - 3 options: Cash Payment, Credit Card, Digital Wallet
  - Visual selection with gradient highlights
  - Default selection (Cash Payment) with automatic notification
  - Consultation fee display from doctor details
  - Animated selection indicators
  
- **Summary & Confirmation**:
  - Complete booking overview with all selections
  - Doctor information card:
    - Profile image with NetworkImage support
    - Doctor name and specialty from passed data
    - Fallback placeholders for null values
  - Booking details card:
    - Selected date (YYYY-MM-DD format)
    - Selected time (HH:mm format)
    - Appointment type (Video/Voice/In-Person)
    - Consultation reason (full text)
  - Payment information card:
    - Selected payment method
    - Consultation fee in EGP
    - Professional gradient container design
  
- **Success Screen**:
  - Animated success icon with elastic bounce
  - Booking reference number (first 8 chars of appointment ID, uppercase)
  - Real appointment data from API response:
    - Actual appointment date formatted from DateTime
    - Appointment time from response
    - Appointment type with proper mapping
    - Doctor information (name, specialty, image from booking response)
  - Quick actions: Back to Home, View Appointment
  - Professional fade and scale animations

- **API Integration**:
  - **GET** `/doctors/{doctorId}/available-slots?date={date}`:
    - Fetch available time slots for specific date
    - Response: AvailableSlotsResponse with slots[], isWorkingDay, slotDuration
  - **POST** `/appointments`:
    - Request: AppointmentRequestBody (doctorId, appointmentDate, appointmentTime, reason, appointmentType)
    - Response: AppointmentResponseBody with complete appointment details
    - Includes patient and doctor full information
  - **State Management**:
    - AppointmentCubit with availableSlots and bookAppointment methods
    - BlocListener for loading/success/error states
    - Loading dialog during API calls
    - Error snackbar with user-friendly messages

- **Data Flow & State Management**:
  - Doctor details (DoctorDetailsModel) passed from Details screen via GoRouter extra
  - Working days used to filter date picker
  - Consultation fee passed to summary and payment display
  - All step selections maintained with initial value parameters:
    - `initialDate`, `initialTime`, `initialType`
    - `initialReason`, `initialPayment`
  - State restoration when navigating back between steps
  - WidgetsBinding.addPostFrameCallback for safe default notifications
  - Step validation preventing progression with incomplete data

- **Technical Implementation**:
  - **Models**:
    - AppointmentRequestBody: Full booking request structure
    - AppointmentResponseBody: Complete response with nested models
    - AvailableSlotsResponse: Slots with metadata
    - DoctorDetailsModel: Enhanced with workingDays, qualifications, phoneNumber
  - **Bug Fixes**:
    - setState during build error resolved with addPostFrameCallback
    - Default selection notification to parent components
    - Working days parsing and date filtering
    - Time slot categorization and display
  - **Improvements**:
    - Pagination support for doctors list (page, limit parameters)
    - DoctorSpecialtyResponse wrapper with pagination metadata
    - Enhanced About tab with working days as chips
    - Gradient working time card with availability badge

### 👤 Profile Screen
- **User Profile Display**:
  - Real-time profile data from API
  - Profile image with edit functionality
  - User info (name, email, phone, role, address, blood type)
  
- **Account Settings**:
  - Edit Profile option
  - Security settings
  - Payment methods management
  - Notifications preferences
  
- **Help & Support**:
  - Help Center
  - Contact Us
  - Terms & Conditions
  - Privacy Policy
  
- **Professional Loading**:
  - Custom shimmer loading matching screen layout
  - Smooth transitions between states
  - Error handling with retry functionality

### 🤖 Smart Checkup Feature (AI-Powered Health Analysis)

#### 🩺 Smart Checkup Screen
- **AI-Powered Health Check Interface**:
  - Professional gradient header with heart icon
  - Two checkup modes: Symptom Check & Skin Analysis
  - Mode selector with animated toggle
  
- **Symptom Checkup Mode**:
  - Multi-line text input for symptom description
  - Real-time validation
  - Professional card design with gradient accent
  
- **Skin Analysis Mode**:
  - Image upload with camera/gallery picker
  - Image compression using `pickImageAndCompress()`
  - Preview uploaded image with remove option
  - Professional upload card with camera icon
  
- **Important Disclaimer**:
  - Amber-themed notice card
  - Warning about AI limitations
  - Professional medical advice recommendation
  
- **API Integration**:
  - POST `/smart-checkup/skin` - FormData with image file
  - POST `/smart-checkup/symptoms` - JSON with symptoms text
  - SmartCheckResponse model with @JsonKey annotations
  - BlocListener for navigation on success/error
  - BlocBuilder for loading states
  
- **Clean Architecture & Widget Extraction**:
  - ✅ **8 reusable StatelessWidgets** extracted:
    * CheckupAppBar - App bar with back button
    * CheckupHeaderCard - Header with gradient icon
    * CheckupDisclaimerCard - Important notice card
    * ResultAppBar - Result screen app bar
    * ResultHeaderCard - Result header with severity
    * ResultActionButtons - Action buttons
    * ResultDisclaimerCard - Medical disclaimer
    * RecommendedDoctorsSection - Doctors list
  - ✅ **CheckupTypeSelector** - Toggle between modes
  - ✅ **SymptomInputCard** - Symptom text input
  - ✅ **ImageUploadCard** - Image picker with preview
  - ✅ **No SizedBox usage** - Custom spacing throughout
  - ✅ **CustomMaterialButton** for all buttons

#### 🔬 Smart Checkup Result Screen
- **Dynamic Severity Display**:
  - Color-coded headers (Green/Orange/Red)
  - Severity icons (Tick/Info/Danger)
  - Gradient backgrounds based on severity
  - Confidence percentage display
  
- **AI Analysis Results**:
  - **Possible Diagnosis**: Main diagnosis with confidence
  - **Description**: Detailed condition explanation
  - **Emergency Care**: Urgent care instructions (if applicable)
  - **Risk Factors**: List of identified risk factors
  - **Recommendations**: Health recommendations
  - **Symptoms**: Related symptoms list
  
- **Recommended Doctors Section**:
  - List of specialist doctors for condition
  - Reuses existing DoctorCard from home feature
  - Navigation to doctor details screen
  - Professional gradient section header
  - Empty state when no doctors available
  
- **Action Buttons**:
  - **New Checkup**: Returns to checkup screen
  - **Save Report**: Saves analysis (shows success feedback)
  - CustomMaterialButton with gradient styling
  
- **Medical Disclaimer**:
  - Amber-themed warning card
  - Custom disclaimer text from API response
  - Professional typography
  
- **API Response Handling**:
  - SmartCheckResponse model with snake_case mapping
  - @JsonKey annotations for proper JSON parsing:
    * possible_diagnosis → possibleDiagnosis
    * emergency_care → emergencyCare
    * risk_factors → riskFactors
    * recommended_doctors → recommendedDoctors
    * additional_info → additionalInfo
  - RecommendedDoctorModel with specialty conversion
  - Proper error handling with user feedback

#### 🏗️ Smart Checkup Architecture
- **State Management**:
  - SmartCheckupCubit with 4 states per mode (Initial/Loading/Success/Error)
  - BlocListener for navigation and error handling
  - BlocBuilder for loading states and button management
  
- **API Services**:
  - Retrofit with FormData for multipart uploads
  - @Body() FormData for skin checkup endpoint
  - @Body() SymptomCheckupRequestBody for symptom checkup
  - build_runner code generation
  
- **Data Models**:
  - SmartCheckResponse (main response)
  - AdditionalInfoModel (nested data)
  - RecommendedDoctorModel (doctor recommendations)
  - SymptomCheckupRequestBody (request)
  
- **Navigation Flow**:
  - Smart Checkup Screen → Result Screen
  - Result Screen → Doctor Details (via DoctorCard)
  - Query parameters for checkType (symptom/skin)
  - GoRouter integration with named routes

- **Technical Features**:
  - Real image picker implementation (no mock data)
  - Image compression before upload
  - FormData construction for multipart requests
  - Error SnackBar with user-friendly messages
  - Loading state with disabled button
  - Professional gradient designs throughout
  - Responsive design with flutter_screenutil

### � Medical Records & Prescriptions System

#### 📋 Medical Records Screen
- **Complete Medical History**:
  - Patient medical records list with pagination
  - Record type filtering (All, Diagnosis, Lab Results, Prescriptions)
  - Professional card design with diagnosis information
  - Status badges with color coding
  - Navigation to detailed diagnosis view
  
- **Diagnosis Details Screen**:
  - Complete diagnosis information display
  - Diagnosis header with severity badge and ICD code
  - Clinical description with creation date
  - Doctor information card
  - Action buttons (Download Report, View Prescription, Contact Doctor)
  - Empty state handling with custom message
  - Gradient design with professional UI
  
- **Professional Loading & States**:
  - Custom shimmer loading matching card layouts
  - Empty state with "No diagnosis data" message
  - Error handling with retry functionality
  - Smooth transitions between states

#### 💊 Prescription Details Screen
- **Complete Prescription Display**:
  - Professional prescription header with Rx number
  - Status badge (Active, Expired, Completed, Cancelled)
  - Prescribed date with calendar format
  
- **Patient & Doctor Information Cards**:
  - Patient information with profile image
  - Prescribing doctor details with specialty
  - CachedNetworkImage integration for avatars
  - Fallback icons when images unavailable
  
- **Medications List**:
  - Complete medication details:
    - Drug name with numbered badges
    - Dosage information with color coding
    - Instructions with info icons
    - Duration in days with calendar badges
  - Medications count display
  - List with dividers for clarity
  - Color-coded medication cards (green theme)
  
- **Additional Information**:
  - Important notes card with amber warning design
  - Validity period with prescribed date
  - Professional gradient containers
  
- **Action Buttons**:
  - Download prescription (prepared)
  - Share prescription (prepared)
  - Contact doctor (prepared)
  - CustomMaterialButton throughout
  
- **Professional UI Components**:
  - **Shimmer Loading**: Complete skeleton matching screen layout
    - Header card shimmer (150h)
    - Patient card shimmer (100h)
    - Doctor card shimmer (100h)
    - Medications card with 3 item shimmers
    - Validity card shimmer (80h)
    - Action buttons shimmers
  - **Error State**: Retry functionality with error message
  - Responsive design with ScreenUtil
  - Consistent spacing with custom helpers
  
- **Navigation Integration**:
  - Accessible from diagnosis screen
  - Receives diagnosisId and appointmentId via GoRouter
  - AppointmentId used for API prescription fetch
  
- **Clean Architecture & Widget Extraction**:
  - ✅ **10 reusable StatelessWidgets** extracted:
    * PrescriptionHeaderCard - Header with Rx number and status
    * PrescriptionPatientCard - Patient information display
    * PrescriptionDoctorCard - Doctor information with specialty
    * PrescriptionMedicationItem - Individual medication details
    * PrescriptionMedicationsCard - Medications list container
    * PrescriptionNotesCard - Important notes section
    * PrescriptionValidityCard - Validity period information
    * PrescriptionActionButtons - Download/Share/Contact actions
    * PrescriptionErrorState - Error display with retry
    * PrescriptionShimmerLoading - Complete loading skeleton
  - ✅ **Main screen optimized** - Clean code with widget composition
  - ✅ **Consistent custom widgets** - CustomMaterialButton, spacing helpers
  - ✅ **No SizedBox usage** - All replaced with verticalSpacing/horizantialSpacing
  - ✅ **Proper BLoC pattern** - PrescriptionsCubit with state management

### �📅 Appointment Management System

#### 🗓️ Appointment Management Screen (Bottom Navigation)
- **3-Tab Interface** with professional Material Design:
  - **Upcoming Tab**: Active scheduled appointments
  - **Completed Tab**: Past appointments history
  - **Cancelled Tab**: Cancelled appointments record
  
- **Smart Filtering System**:
  - Quick filter chips: All, Today, This Week, This Month
  - Filter bottom sheet with sort options:
    - Date (Newest First / Oldest First)
    - Doctor Name (A-Z)
    - Specialty
  - Search functionality in AppBar (prepared)
  
- **Professional Appointment Cards**:
  - **Status-based gradient headers**:
    - Blue gradient for Upcoming (clock icon)
    - Green gradient for Completed (checkmark icon)
    - Red gradient for Cancelled (close icon)
  - **Doctor Information Display**:
    - Profile image with CachedNetworkImage
    - Doctor name and specialty
    - Clinic address with location pin
  - **Appointment Details**:
    - Date with calendar icon (MMM dd, yyyy format)
    - Time with clock icon (hh:mm a format)
    - Consultation reason
    - Booking reference ID (8-char uppercase)
  - **Status-Based Action Buttons**:
    - **Upcoming**: Cancel (red outline) + Reschedule (green filled)
    - **Completed**: View Details + Book Again
    - **Cancelled**: Book New Appointment (single action)
  
- **Interactive Features**:
  - Pull-to-refresh for manual data updates
  - Cancel appointment with confirmation dialog
  - Reschedule appointment (prepared for implementation)
  - View appointment details
  - Book again functionality (prepared)
  
- **Professional UI States**:
  - **Loading State**: Shimmer loading matching card design (5 cards)
  - **Empty States**: Custom messages and icons per tab:
    - Upcoming: "No upcoming appointments" with calendar icon
    - Completed: "No completed appointments yet" with checkmark
    - Cancelled: "No cancelled appointments" with close icon
  - **Error State**: Retry button with error message
  - **Success Feedback**: SnackBar for actions (green/red)
  
- **Pagination & Performance**:
  - API pagination support (page, limit parameters)
  - Client-side filtering by status (upcoming/completed/cancelled)
  - Automatic refresh after status updates
  
#### 📝 Appointment Booking Feature
- **Multi-Step Booking Flow** (4 Steps):
  1. **Date & Time Selection**:
     - Interactive calendar with 30-day range
     - Month navigation (previous/next)
     - Time slots organized by period (Morning, Afternoon, Evening)
     - Visual indicators for past times
     - Appointment type selection (Video Call, Voice Call, In-Person)
  
  2. **Reason for Consultation**:
     - 5 predefined consultation reasons with custom icons
     - Regular Checkup, Follow-up Visit, New Symptoms, Medical Reports
     - "Other" option with multi-line text field
     - Animated card selection with color-coded categories
  
  3. **Payment Method**:
     - Cash Payment, Credit Card, Digital Wallet options
     - Professional card design with gradient backgrounds
     - Animated selection with checkmarks
  
  4. **Booking Summary**:
     - Complete booking information review
     - Doctor information card with image
     - Payment details with consultation fee
     - Professional card layouts with gradient accents

- **Success Screen**:
  - Animated success icon with elastic animation
  - Booking confirmation with appointment details
  - Quick actions (Back to Home, View Appointment)
  - Professional fade and scale animations

- **UI/UX Excellence**:
  - Custom step indicator with gradient progress
  - Smooth page transitions with AnimatedSwitcher
  - Professional app bar with centered title
  - Responsive grid layouts for time slots (3 columns, aspect ratio 2.2)
  - Consistent color theming across all steps
  - Back/Continue navigation with proper validation
  - Card-based design with shadows and borders

- **Navigation Integration**:
  - Accessible from Doctor Details and Home screens
  - GoRouter integration with named routes
  - Success screen redirects to home or appointment view

### 🔔 Push Notifications System

#### Firebase Cloud Messaging Integration
- **Complete FCM Setup with Local Notifications**:
  - Firebase Cloud Messaging for push notifications
  - Flutter Local Notifications for custom notification display
  - Background, foreground, and terminated state handling
  - Notification tap navigation to relevant screens
  
- **Supported Notification Types**:
  - **DiagnosisAdded**: New diagnosis available notifications
    - Navigates to Medical Records screen
    - Displays doctor name and diagnosis information
  - **AppointmentReminder**: Upcoming appointment reminders
    - Navigates to Appointment Management screen
    - Shows scheduled date and time
  - **AppointmentConfirmed**: Appointment confirmation notifications
    - Navigates to Appointment Management screen
    - Displays doctor information
  - **PrescriptionCreated**: New prescription notifications
    - Navigates to Prescription Details screen
    - Shows medication count and doctor name
  
- **Notification Features**:
  - **Custom Notification Content**: Dynamic title and body based on type
  - **Rich Metadata**: Includes IDs, doctor names, dates, counts
  - **Click Actions**: Custom navigation per notification type
  - **Notification Channels** (Android): 4 channels (appointments, medical_records, prescriptions, general)
  - **32-bit ID Generation**: Smart ID generation fitting Android's integer range
  - **Background Handler**: Top-level function for terminated state notifications
  
- **Technical Implementation**:
  - **Models**:
    - `NotificationType` enum: DiagnosisAdded, AppointmentReminder, AppointmentConfirmed, PrescriptionCreated
    - `NotificationClickAction` enum: OPEN_MEDICAL_RECORD, OPEN_APPOINTMENT
    - `NotificationData`: Complete notification data parser with helper methods
  - **Services**:
    - `FirebaseMessagingService`: FCM initialization, token management, message handling
    - `LocalNotificationService`: Local notification display, channel creation, tap handling
    - `NotificationNavigationHandler`: Smart navigation based on notification type and action
  - **Testing Tools**:
    - `NotificationTestHelper`: Test notification generation for all types
    - `notification_data_test.dart`: Unit tests for notification parsing (8 tests, all passing)
  
- **Android Configuration**:
  - Core library desugaring enabled (desugar_jdk_libs: 2.1.4)
  - Notification channels created on app initialization
  - Default notification icon and color configured
  
- **iOS Configuration**:
  - Push Notifications capability enabled
  - Permission requests for alert, badge, and sound
  - APNs integration with Firebase Console
  
- **Documentation**:
  - Complete implementation guide in `NOTIFICATIONS_GUIDE.md`
  - FCM message format examples
  - Backend integration instructions
  - Debugging and troubleshooting tips

### 🎨 UI/UX Features
- **Responsive Design**: Using flutter_screenutil for all dimensions
- **Modern Animations**: Fade, slide, and scale transitions
- **Shimmer Loading**: Professional skeleton screens for all lists
- **Error Handling**: User-friendly error messages
- **Empty States**: Meaningful empty state screens
- **Image Caching**: Optimized image loading with CachedNetworkImage

### 🔄 State Management
- **BLoC Pattern** with Freezed for immutable states
- **Cubits**:
  - `AuthCubit`: Login, signup, profile completion
  - `HomeCubit`: Specialties, doctors with caching system
  - `DetailsCubit`: Doctor details fetching
  - `AppointmentCubit`: Available slots fetching, appointment booking
  - `AppointmentManageCubit`: Appointments list, status updates (cancel)
  - `MainCubit`: Bottom navigation management
  - `ProfileCubit`: User profile data and updates
  - `MedicalRecordsCubit`: Medical records list fetching
  - `PrescriptionsCubit`: Prescription details fetching
  - `SmartCheckupCubit`: AI health analysis (skin & symptom checkups)

- **State Management Patterns**:
  - BlocListener for side effects (navigation, dialogs, snackbars)
  - BlocBuilder for UI updates
  - buildWhen optimization for performance
  - Proper loading, success, error state handling

### 🌐 API Integration
- **Retrofit** with Dio for network calls
- **Generic Response Handler**: Unified API response handling
- **Endpoints**:
  - **Authentication**: 
    - POST `/auth/login` - User login
    - POST `/auth/register` - User registration
    - POST `/auth/complete-profile` - Profile completion with image upload
  - **Specialties**: 
    - GET `/specialties` - List all medical specialties
  - **Doctors**: 
    - GET `/specialties/{specialtyId}/doctors?page={page}&limit={limit}` - Doctors by specialty with pagination
    - GET `/doctors/{doctorId}` - Detailed doctor information
  - **Appointments**:
    - GET `/doctors/{doctorId}/available-slots?date={date}` - Available time slots
    - POST `/appointments` - Book appointment
    - GET `/appointments?page={page}&limit={limit}` - Get patient appointments with pagination
    - PUT `/appointments/{appointmentId}` - Update appointment status (cancel)
  - **Medical Records**:
    - GET `/medical-records?page={page}&limit={limit}` - Get patient medical records with pagination
  - **Prescriptions**:
    - Smart Checkup** (AI Health Analysis):
    - POST `/smart-checkup/skin` - Skin analysis with image upload (FormData)
    - POST `/smart-checkup/symptoms` - Symptom analysis with text description
  - **GET `/prescriptions/appointment/{appointmentId}` - Get prescription details by appointment ID
  - **Profile**: 
    - GET `/profile` - Get user profile
    - POST `/profile/upload-image` - Upload profile image
    - PUT `/profile` - Update profile details

### 🧭 Navigation
- **GoRouter** for declarative routing
- Named routes with type-safe navigation
- Parameter passing (doctor ID, etc.)
- BlocProvider integration at route level

## 🛠️ Technologies & Packages

### Core
- `flutter_bloc` - State management
- `freezed` & `freezed_annotation` - Code generation for models
- `get_it` - Dependency injection
- `injectable` - DI code generation

### Networking
- `retrofit` & `dio` - API calls
- `pretty_dio_logger` - Network logging
- `json_annotation` & `json_serializable` - JSON serialization

### UI
- `flutter_screenutil` - Responsive design
- `cached_network_image` - Image caching
- `shimmer` - Loading animations
- `iconsax_flutter` - Modern icons
- `flutter_svg` - SVG support
- `lottie` - Animation support

### Navigation & Localization
- `go_router` - Routing
- `easy_localization` - Internationalization

### Storage & Security
- `shared_preferences` - Local storage
- `flutter_secure_storage` - Secure storage

### Firebase & Notifications
- `firebase_core` - Firebase initialization
- `firebase_messaging` - FCM push notifications
- `flutter_local_notifications` - Local notification display

### Utilities
- `image_picker` - Image selection
- `intl` - Date formatting

## 📂 Project Structure Details

### Core Services

#### Firebase & Notification Services
```
core/
├── services/
│   ├── firebase_messaging_service.dart      # FCM initialization & handling
│   ├── local_notification_service.dart      # Local notifications display
│   └── notification_navigation_handler.dart # Notification tap navigation
├── models/
│   ├── notification_data.dart               # Notification data parser
│   └── notification_type.dart               # Notification enums
└── helper/
    └── notification_test_helper.dart        # Testing & debugging tools
```

### Features Organization

#### Authentication Feature
```
auth/
├── data/
│   ├── models/          # User models
│   └── repos/           # Auth repository
├── logic/
#### Profile Feature
```
profile/
├── data/
│   ├── apis/             # ProfileApiServices with Retrofit
│   ├── models/           # ProfileResponseModel
│   └── repos/            # ProfileRepos
├── logic/
│   └── cubit/            # ProfileCubit & states
└── ui/
    ├Medical Records & Prescriptions Feature
```
medical-record/
├── data/
│   ├── apis/                              # MedicalRecordsApiServices
│   ├── models/                            # Medical record models
│   │   └── medical_record_list_response.dart  # Response with DiagnosisModel
│   └── repos/                             # MedicalRecordsRepos
├── logic/
│   └── cubit/                             # MedicalRecordsCubit & states
└── ui/
    ├── medical_record_screen.dart         # Main records list screen
    └── widgets/
        ├── medical_record_card.dart       # Individual record card
        ├── medical_record_empty_state.dart
        ├── medical_record_error_state.dart
        └── record_type_chips_bar.dart     # Filter chips

dignoses/
└── ui/
    ├── dignoses_screen.dart               # Diagnosis details screen
    └── widgets/                           # Extracted diagnosis widgets
        ├── diagnosis_header_card.dart
        ├── diagnosis_details_card.dart
        ├── doctor_info_card.dart
        ├── diagnosis_action_buttons.dart
        └── diagnosis_no_data_state.dart

prescriptions/
├── data/
│   ├── apis/                              # PrescriptionsApiServices
│   ├── models/                            # Prescription models
│   │   └── prescription_details_response.dart  # Complete prescription structure
│   │       # Includes: PrescriptionMedicationModel, PatientModel,
│   │       # DoctorModel, DiagnosisModel, AppointmentModel
│   └── repos/                             # PrescriptionsRepos
├── logic/
│   └── cubit/                             # PrescriptionsCubit & states
└── ui/
    ├── prescriptions_screen.dart          # Main prescription screen
    └── widgets/                           # 10 extracted widgets
        ├── prescription_header_card.dart
        ├── prescription_patient_card.dart
        ├── prescription_doctor_card.dart
        ├── prescription_medication_item.dart
        ├── prescription_medications_card.dart
        ├── prescription_notes_card.dart
        ├── prescription_validity_card.dart
        ├── prescription_action_buttons.dart
        ├── prescription_error_state.dart
        └── prescription_shimmer_loading.dart
```

#### ── screens/          # ProfileScreen
    └── widgets/
        ├── custom_action_profile_button.dart
        └── profile_shimmer_loading.dart
```

#### Appointment Feature
```
booking-appointment/
├── data/
│   ├── apis/                                # AppointmentApiServices
│   ├── models/                              # Request/Response models
│   │   ├── appointment_request_body.dart    # Booking request
│   │   ├── appointment_response_body.dart   # Booking response
│   │   └── available_slots_response.dart    # Time slots response
│   └── repos/                               # AppointmentRepos
├── logic/
│   └── cubit/                               # AppointmentCubit & states
└── ui/
    ├── appointment_screen.dart              # Main booking flow screen
    └── widgets/
        ├── app_bar_appointment_screen.dart  # Professional app bar
        ├── custom_step_indicator.dart       # Progress stepper
        ├── appointment_success_screen.dart  # Success confirmation
        ├── date_and_time/                   # Step 1 widgets
        │   ├── date_and_time_content.dart
        │   ├── date_picker_list_view.dart   # Working days filtered
        │   ├── date_picker_appointment_screen.dart
        │   ├── time_picker_grid_view.dart   # API-driven slots
        │   ├── time_appointment_screen.dart
        │   └── appointment_type_list.dart   # Video/Voice/In-Person
        ├── reason/                          # Step 2 widgets
        │   └── reason_consultation_content.dart
        ├── payment/                         # Step 3 widgets
        │   └── payment_appointment_content.dart
        └── summary_booking/                 # Step 4 widgets
            ├── summary_appointment_content.dart
            ├── date_and_time_summary.dart
            ├── appointment_type_summary.dart
            ├── payment_information_summary.dart
            └── payment_type_summary.dart
```

#### Details Feature
```
details/
├── data/
│   ├── models/          # DoctorDetailsModel
│   └── repos/           # DetailsRepos
├── logic/
│   └── cubit/           # DetailsCubit
└── ui/
    ├── screens/         # DetailsScreen
    └── widgets/
        ├── doctor_details_header.dart
        ├── quick_stats_card.dart
        ├── details_shimmer_loading.dart
        └── tab_bar_widgets/
            ├── about_tab_bar_view_body.dart
            ├── location_tab_bar_view_body.dart
            ├── reviews_tab_bar_view_body.dart
            └── tab_bar_details_screen.dart
```
#### Profile Feature
```
profile/
├── data/
│   ├── apis/             # ProfileApiServices with Retrofit
│   ├── models/           # ProfileResponseModel
│   └── repos/            # ProfileRepos
├── logic/
│   └── cubit/            # ProfileCubit & states
└── ui/
    ├── screens/          # ProfileScreen
    └── widgets/
        ├── custom_action_profile_button.dart
        └── profile_shimmer_loading.dart
```

## 🎯 Key Implementation Details
## 🎯 Key Implementation Details

### Caching Strategy
```dart
// HomeCubit - Smart caching for doctors
final Map<String, List<DoctorModel>> _doctorsCache = {};

void getDoctorsBySpecialty({required String specialtyId}) async {
  // Check cache first
  if (_doctorsCache.containsKey(specialtyId)) {
    emit(HomeState.getDoctorsBySpecialtySuccess(
      doctors: _doctorsCache[specialtyId]!,
    ));edical Records** - Patient medical history list
11. **Diagnosis Details** - Detailed diagnosis information
12. **Prescription Details** - Complete prescription with medications
13. **Main Navigation** - Bottom navigation wrapper
14  return;
  }
  
  // Fetch from API and cache
  final result = await _homeRepos.getDoctorsBySpecialty(specialtyId: specialtyId);
  // ... handle response and cache
}
```

### Auto-Selection Pattern
```dart
// Automatically select first specialty on load
if (response.data.isNotEmpty) {
  getDoctorsBySpecialty(specialtyId: response.data.first.id);
}
```

### Responsive Shimmer Loading
All shimmer loading widgets match the exact design of their corresponding cards for seamless transitions.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- iOS Simulator / Android Emulator
**Installation**:

```bash
git clone https://github.com/DoctorMate-Team/doctormate-mobile.git
cd doctormate-mobile
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code** (for Freezed, Injectable, etc.)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
### Current Screens
1. **Splash Screen** - App initialization
2. **Onboarding** - First, doctors listing, and quick actions
6. **Doctor Details** - Comprehensive doctor information
7. **Appointment Booking** - Multi-step booking flow
8. **Appointment Success** - Booking confirmation
9. **Appointment Management** - View/manage appointments with tabs
10. **Medical Records** - Patient medical history list
11. **Diagnosis Details** - Detailed diagnosis information
12. **Prescription Details** - Complete prescription with medications
13. **Smart Checkup** - AI-powered health analysis (symptom/skin)
14. **Smart Checkup Result** - AI analysis results with doctor recommendations
15. **Main Navigation** - Bottom navigation wrapper
16 **Appointment Success** - Booking confirmation
9. **Appointment Management** - View/manage appointments with tabs
10. **Main Navigation** - Bottom navigation wrapper
11. **Profile** - User profile with settings and support

### Recent Updates
- ✅ **Firebase Cloud Messaging** - Complete push notifications system
- ✅ **Flutter Local Notifications** - Custom local notifications with navigation
- ✅ **4 Notification Types** - Diagnosis, Appointments, Prescriptions support
- ✅ Medical Records & Prescriptions system complete
- ✅ Smart Checkup feature with AI analysis (skin & symptoms)
- ✅ Modern Quick Actions redesigned (2 actions in column)
- ✅ Widget extraction for clean architecture

### Latest Milestone: Smart Checkup Feature - AI Health Analysis
- ✅ Details screen redesign finished
- ✅ Shimmer loading for all screens
- Smart Checkup Feature - AI-Powered Health Analysis**:
- ✅ **Smart Checkup Screen** with dual modes (Symptom & Skin Analysis)
- ✅ **Symptom Checkup Mode** with multi-line text input
- ✅ **Skin Analysis Mode** with real image picker and compression
- ✅ **Smart Checkup Result Screen** with dynamic severity display
- ✅ **AI Analysis Display** (diagnosis, confidence, emergency care, risk factors, recommendations)
- ✅ **Recommended Doctors Section** using existing DoctorCard component
- ✅ **FormData integration** for multipart file uploads
- ✅ **8 extracted StatelessWidgets** for clean architecture:
  * CheckupAppBar, CheckupHeaderCard, CheckupDisclaimerCard
  * ResultAppBar, ResultHeaderCard, ResultActionButtons
  * ResultDisclaimerCard, RecommendedDoctorsSection
- ✅ **API Integration**:
  * POST `/smart-checkup/skin` with FormData
  * POST `/smart-checkup/symptoms` with JSON body
- ✅ **SmartCheckResponse model** with @JsonKey annotations for snake_case mapping
- ✅ **BLoC state management** with SmartCheckupCubit
- ✅ **Navigation flow** with query parameters for checkType
- ✅ **Modern Quick Actions redesigned** - 2 actions in column layout:
  * Scan QR (purple gradient)
  * Smart Checkup (red gradient with navigation)
- ✅ **All widgets use** CustomMaterialButton and custom spacing helpers
- ✅ **No SizedBox usage** - verticalSpacing/horizantialSpacing throughout
- ✅ **Professional gradient designs** with color-coded severity states
- ✅ **Real image picker** implementation (no mock data)
- ✅ **Error handling** with user-friendly SnackBars

**Previous Milestone: ✅ Auto-selection of first specialtymedical-records-prescriptions`

### Latest Milestone: Complete Medical Records & Prescriptions System ✨

**Medical Records & Prescriptions - Full Implementation**:
- ✅ **Medical Records Screen** with pagination support
- ✅ **Record type filtering** (All, Diagnosis, Lab Results, Prescriptions)
- ✅ **Diagnosis Details Screen** with complete information display
- ✅ **Prescription Details Screen** with medications list
- ✅ **10 extracted prescription widgets** for clean architecture
- ✅ **Patient and Doctor information cards** with CachedNetworkImage
- ✅ **Medications list** with complete details (drug, dosage, instructions, duration)
- ✅ **Important notes section** with amber warning design
- ✅ **Validity period display** with prescribed date
- ✅ **Action buttons** (Download, Share, Contact Doctor)
- ✅ **Shimmer loading** matching prescription layout
- ✅~~Medical Records & Prescriptions system~~ ✅ DONE
4. ~~Smart Checkup with AI analysis~~ ✅ DONE
5. Implement QR code scanning functionality
6. Implement appointment reschedule functionality
7. Implement appointment details view screen
8. Implement search functionality in appointments
9. Add "Book Again" feature flow
10. Implement prescription download/share functionality
11. Add lab results viewing in medical records
12. Edit profile functionality with image update
13. Real-time chat feature
14. Payment gateway integration
15. Push notifications
16. Advanced search and filters
17
**Previous Milestone: Appointment Management Scree
- ✅ **Smart date picker filtered by doctor's working days**
- ✅ **API-driven time slots with real-time availability**
- ✅ **State persistence across navigation**
- ✅ **Consultation reason with predefined + custom options**
- ✅ **Payment method selection with auto-notification**
- ✅ **Complete booking summary with doctor details**
- ✅ **Success screen with actual API response data**
- ✅ **Booking reference number generation and display**
- ✅ **Appointment Management Screen with 3-tab interface**
- ✅ **Professional appointment cards with status-based gradients**
- ✅ **Filter system with date chips and sort modal**
- ✅ **Cancel appointment with confirmation dialog**
- ✅ **Shimmer loading, empty states, error states for management**
- ✅ **11 extracted reusable widgets for clean architecture**
- ✅ **Pull-to-refresh and pagination support**
- ✅ **Status-based action buttons (Cancel/Reschedule/View/Book Again)**

### Next Steps
1. ~~API integration for appointment booking~~ ✅ DONE
2. ~~Appointment history and management~~ ✅ DONE
3. ~~Push notifications~~ ✅ DONE
4. Implement appointment reschedule functionality
5. Implement appointment details view screen
6. Implement search functionality in appointments
7. Add "Book Again" feature
8. Edit profile functionality
9. Real-time chat feature
10. Payment gateway integration
11. Advanced search and filters
12. Favorites management

## 📝 Coding Standards

### Naming Conventions
- **Files**: snake_case (e.g., `doctor_details_screen.dart`)
- **Classes**: PascalCase (e.g., `DoctorDetailsScreen`)
- **Variables**: camelCase (e.g., `selectedSpecialtyId`)
- **Constants**: camelCase with const (e.g., `const primaryColor`)

### State Management Rules
- Use BLoC pattern for all business logic
- Keep UI widgets pure and stateless when possible
- Use `buildWhen` to optimize rebuilds
- Implement proper error handling in all states

### UI Guidelprescription download/share functionality
2. Add lab results viewing in medical records
3. Implement appointment reschedule functionality
4. Implement appointment details view screen
5. Implement search functionality in appointments
6. Add "Book Again" feature flow
7. Edit profile functionality with image update
8 Use const constructors where possible

## 🧪 Testing Strategy
- Unit tests for cubits and repositories
- Widget tests for UI components
- Integration tests for critical flows
- Mock API responses for testing

## 🎨 Design System

### Colors
- Primary: `ColorsManager.primaryColor`
## 🔄 Current Development Branch: `features/appointment-mangement`

### Latest Milestone: Complete Appointment Management System ✨

**Appointment Management Screen - Full Implementation**:
- ✅ **3-tab interface** (Upcoming, Completed, Cancelled) with Material TabBar
- ✅ **Professional appointment cards** with status-based gradient headers
- ✅ **Filter systeFebruary 4, 2026  
**Current Branch**: features/medical-records-prescriptions  
**Major Feature**: Complete Medical Records & Prescriptions System with Clean Architecture
- ✅ **Pull-to-refresh** for manual data updates
- ✅ **Shimmer loading** matching card design (5 cards)
- ✅ **Empty states** with custom messages per tab
- ✅ **Error states** with retry functionality
- ✅ **Status-based action buttons** (Cancel/Reschedule/View/Book Again)
- ✅ **Pagination support** (page, limit parameters)
- ✅ **Client-side filtering** by appointment status
- ✅ **Real appointment data** from API with proper formatting
**Previous Milestones**:
- ✅ Complete Appointment Management with 3-tab interface
- ✅ Professional appointment cards with status-based gradients
- ✅ Filter system with date chips and sort modal
- ✅ Cancel appointment functionality with confirmation
- ✅ 11 extracted widgets for clean architecture
- ✅ Medical Records & Prescriptions system
- ✅ 10 extracted prescription widgets
- ✅ Diagnosis details with doctor information
- ✅ Medications list with complete detailn

## 📄 License

This project is proprietary software owned by DoctorMate Team.

## 👥 Team

- **Development Team**: DoctorMate-Team
- **Repository**: [doctormate-mobile](https://github.com/DoctorMate-Team/doctormate-mobile)
---

**Version**: 1.0.0+1  
**Last Updated**: February 21, 2026  
**Current Branch**: features/search-appointmentDetails-communication-notification  
**Major Feature**: Firebase Cloud Messaging & Flutter Local Notifications Integration

**Previous Milestones**:
- ✅ Complete Appointment Management with 3-tab interface
- ✅ Professional appointment cards with status-based gradients
- ✅ Filter system with date chips and sort modal
- ✅ Cancel appointment functionality with confirmation
- ✅ Medical Records & Prescriptions system
- ✅ 10 extracted prescription widgets
- ✅ Diagnosis details with doctor information
- ✅ Medications list with complete details
- ✅ Smart Checkup Feature - AI Health Analysis (Symptom & Skin)
- ✅ 8 extracted checkup widgets for clean architecture