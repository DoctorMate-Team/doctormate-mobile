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
│   ├── onBoarding/         # Onboarding screens
│   └── splash/             # Splash screen
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

### 🌐 API Integration
- **Retrofit** with Dio for network calls
- **Generic Response Handler**: Unified API response handling
- **Error Models**: Structured error handling
- **Endpoints**:
  - Authentication (login, signup, complete profile)
  - Specialties listing
  - Doctors by specialty
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
│   └── cubit/           # AuthCubit & states
└── ui/
    ├── screens/         # Login, SignUp, CompleteProfile
    └── widgets/         # Reusable auth widgets
```

#### Home Feature
```
home/
├── data/
│   ├── models/          # DoctorModel, SpecialtyModel
│   └── repos/           # HomeRepos
├── logic/
│   └── cubit/           # HomeCubit with caching
└── ui/
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
```

4. **Run the app**
```bash
flutter run
```

## 🔧 Development Commands

### Code Generation
```bash
# Generate once
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate on file changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Clean Build
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
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
- Background: White, Light Gray shades
- Text: Dark Green, Gray variations
- Accent: Green, Blue, Purple

### Typography
- `TextStyles.font18DarkGreenBold`
- `TextStyles.font16DarkGreenBold`
- `TextStyles.font14GrayRegular`
- `TextStyles.font12DarkGreenSemiBold`
- Custom font weights via `FontWeightHelper`

### Spacing
- Consistent use of `verticalSpacing()` and `horizantialSpacing()`
- Standard padding: 16.w, 20.w
- Standard margins: 12.h, 16.h

## 📱 Screens Overview

### Current Screens
1. **Splash Screen** - App initialization
2. **Onboarding** - First-time user experience
3. **Login** - User authentication
4. **Sign Up** - New user registration
5. **Complete Profile** - Profile setup with image
6. **Home** - Specialties and doctors listing
7. **Doctor Details** - Comprehensive doctor information
8. **Main Navigation** - Bottom navigation wrapper

### Upcoming Features
- Appointment booking flow
- Payment integration
- Chat with doctors
- Medical records
- Notifications
- User profile management
- Search and filters
- Favorites management

## 🔄 Current Development Branch: `features/home-logic`

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

## 📞 Support

For any questions or issues, please contact the development team.

---

**Version**: 1.0.0+1  
**Last Updated**: November 20, 2025  
**Current Branch**: features/home-logic
