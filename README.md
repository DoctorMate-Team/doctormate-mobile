# DoctorMate - Medical Appointment Booking App

A professional Flutter application for booking medical appointments with doctors across various specialties.

## 📱 Project Overview

DoctorMate is a comprehensive medical appointment booking platform that connects patients with healthcare professionals. The app features a modern, user-friendly interface with real-time data integration and advanced state management.

## 🏗️ Architecture

The project follows **Clean Architecture** principles with **BLoC Pattern** for state management:

```
lib/
├── core/
│   ├── di/                 # Dependency Injection (GetIt)
│   ├── functions/          # Utility functions
│   ├── helper/             # Helper classes
│   ├── models/             # Core models
│   ├── networking/         # API configuration (Retrofit, Dio)
│   ├── routing/            # Navigation (GoRouter)
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

### 📅 Appointment Booking Feature
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
  - `HomeCubit`: Specialties, doctors with caching
  - `DetailsCubit`: Doctor details fetching
  - `MainCubit`: Bottom navigation management
  - `ProfileCubit`: User profile data and updates

### 🌐 API Integration
- **Retrofit** with Dio for network calls
- **Generic Response Handler**: Unified API response handling
- **Endpoints**:
  - Authentication (login, signup, complete profile)
  - Specialties listing
  - Doctors by specialty
  - Doctor details
  - Profile management (get profile, upload image, update details)cialty
  - Doctor details

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

### Utilities
- `image_picker` - Image selection
- `intl` - Date formatting

## 📂 Project Structure Details

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
    ├── screens/          # ProfileScreen
    └── widgets/
        ├── custom_action_profile_button.dart
        └── profile_shimmer_loading.dart
```

#### Appointment Feature
```
appointment/
├── ui/
│   ├── appointment_screen.dart              # Main booking flow screen
│   └── widgets/
│       ├── app_bar_appointment_screen.dart  # Professional app bar
│       ├── custom_step_indicator.dart       # Progress stepper
│       ├── appointment_success_screen.dart  # Success confirmation
│       ├── date_and_time/                   # Step 1 widgets
│       │   ├── date_and_time_content.dart
│       │   ├── date_picker_list_view.dart
│       │   ├── date_picker_appointment_screen.dart
│       │   ├── time_picker_grid_view.dart
│       │   ├── time_appointment_screen.dart
│       │   └── appointment_type_list.dart
│       ├── reason/                          # Step 2 widgets
│       │   └── reason_consultation_content.dart
│       ├── payment/                         # Step 3 widgets
│       │   └── payment_appointment_content.dart
│       └── summary_booking/                 # Step 4 widgets
│           ├── summary_appointment_content.dart
│           ├── booking_information_appointment_summary.dart
│           ├── date_and_time_summary.dart
│           ├── appointment_type_summary.dart
│           ├── payment_information_summary.dart
│           └── payment_type_summary.dart
``` ui/
    ├── screens/         # HomeScreen
    └── widgets/
        ├── modern_specialists_list.dart
        ├── doctors_list_for_specialist.dart
        ├── specialists_bloc_builder.dart
        ├── doctors_bloc_builder.dart
        ├── specialists_shimmer_loading.dart
        ├── doctors_shimmer_loading.dart
        └── section_header.dart
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
    ));
    return;
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

### Installation

1. **Clone the repository**
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
2. **Onboarding** - First-time user experience
3. **Login** - User authentication
4. **Sign Up** - New user registration
5. **Home** - Specialties and doctors listing
6. **Doctor Details** - Comprehensive doctor information
7. **Appointment Booking** - Multi-step booking flow
8. **Appointment Success** - Booking confirmation
9. **Main Navigation** - Bottom navigation wrapper
10. **Profile** - User profile with settings and support

### Recent Updates
- ✅ Home screen API integration complete
- ✅ Doctor caching system implemented
- ✅ Details screen redesign finished
- ✅ Shimmer loading for all screens
- ✅ Auto-selection of first specialty
- ✅ Complete profile image picker
- ✅ Profile screen with API integration
- ✅ **Appointment booking feature complete**
- ✅ **4-step booking flow with professional UI**
- ✅ **Date picker with month navigation**
- ✅ **Time slots with Morning/Afternoon/Evening sections**
- ✅ **Consultation reason selection step**
- ✅ **Payment method selection**
- ✅ **Booking summary and success screens**

### Next Steps
1. API integration for appointment booking
2. Edit profile functionality
3. Real-time chat feature
4. Payment gateway integration
5. Push notifications
6. Advanced search and filters
7. Favorites management
8. Appointment history and managementrunner build --delete-conflicting-outputs
```

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

### UI Guidelines
- Use ScreenUtil for all dimensions (.w, .h, .sp, .r)
- Follow Material Design principles
- Maintain consistent spacing and padding
- Implement proper loading and error states
- Use const constructors where possible

## 🧪 Testing Strategy
- Unit tests for cubits and repositories
- Widget tests for UI components
- Integration tests for critical flows
- Mock API responses for testing

## 🎨 Design System

### Colors
- Primary: `ColorsManager.primaryColor`
## 🔄 Current Development Branch: `features/appointment-ui`

### Recent Milestone: Appointment Booking Feature ✨
Complete redesign and implementation of the appointment booking system with professional UI/UX:

**Completed Components**:
- ✅ 4-step booking wizard with progress indicator
- ✅ Interactive calendar date picker with month navigation
- ✅ Time slot selection with Morning/Afternoon/Evening sections
- ✅ Appointment type selection (Video/Voice/In-Person)
- ✅ Consultation reason step with 5 predefined options
- ✅ Payment method selection (Cash/Card/Wallet)
- ✅ Booking summary with all details
- ✅ Success screen with animations
- ✅ Navigation integration from Home and Details screens

**Technical Highlights**:
- Responsive GridView with optimized childAspectRatio (2.2)
- AnimatedContainer and AnimatedScale for smooth transitions
- Professional card-based design throughout
- Custom step indicator with gradient progress
- Proper text overflow handling in time slots

### Next Priority
1. **API Integration** for appointment booking (POST request)
2. Edit profile functionality
3. Real-time appointment tracking
4. Payment gateway integration

### Next Steps
1. Edit profile functionality
2. Profile image upload from profile screen
3. Appointment booking functionality
4. Real-time chat feature
5. Payment gateway integration
6. Push notifications
7. Advanced search and filters
- Search and filters
- Favorites management

## 🔄 Current Development Branch: `features/appointment-ui`

### Recent Updates
- ✅ Home screen API integration complete
- ✅ Doctor caching system implemented
- ✅ Details screen redesign finished
- ✅ Shimmer loading for all screens
- ✅ Auto-selection of first specialty
- ✅ Complete profile image picker

### Next Steps
1. Appointment booking functionality
2. Real-time chat feature
3. Payment gateway integration
4. Push notifications
5. Advanced search and filters

## 🤝 Contributing

1. Create a feature branch from `development`
2. Follow the coding standards
3. Write meaningful commit messages
4. Test your changes thoroughly
5. Create a pull request with detailed description

## 📄 License

This project is proprietary software owned by DoctorMate Team.

## 👥 Team

- **Development Team**: DoctorMate-Team
- **Repository**: [doctormate-mobile](https://github.com/DoctorMate-Team/doctormate-mobile)
---

**Version**: 1.0.0+1  
**Last Updated**: December 2, 2025  
**Current Branch**: features/appointment-ui
