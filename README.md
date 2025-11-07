# VIGIATECH

**Industrial IoT Monitoring Platform** - A mobile application for predictive maintenance and real-time industrial machine monitoring.

## 📱 About

VIGIATECH is a Flutter-based mobile application designed for industrial IoT monitoring. It serves as the primary interface for a predictive maintenance platform, allowing operators to monitor machine health, receive real-time alerts, and prevent equipment failures before they occur.

### Key Features

- 🔐 **Secure Authentication** - User login and password recovery
- 📊 **Real-time Monitoring** - Live machine status and vibration data
- 📈 **Data Visualization** - Historical charts and trends
- 🔔 **Push Notifications** - Instant alerts for anomalies
- 🔧 **Device Provisioning** - Easy sensor setup via Bluetooth
- ⚙️ **Settings Management** - Account and notification configuration

## 🎨 Design

The app features a modern dark mode interface with an industrial color palette:

| Color | Hex Code | Usage |
|-------|----------|-------|
| Industrial Dark Blue | `#24324F` | Main background |
| Neutral Dark Gray | `#1A1F2C` | Navigation, panels, input fields |
| Ice White | `#E6F7F4` | Primary text, titles, labels |
| Tech Light Green | `#ADFBED` | Primary buttons, "Normal" status |
| Vibrant Light Blue | `#3DB3C7` | Warning tags, alert icons, links |
| Soft Cyan Blue | `#6EE7E7` | Chart lines, secondary icons |

## 🏗️ Architecture

The project follows the **MVP (Model-View-Presenter)** architecture pattern:

```
lib/
├── core/
│   ├── constants/      # App-wide constants (colors, strings, routes)
│   ├── theme/          # Theme configuration
│   └── utils/          # Utility functions
├── models/             # Data models (Machine, Alert, User)
├── views/              # UI screens
│   ├── auth/           # Authentication screens
│   ├── devices/        # Device monitoring screens
│   └── alerts/         # Alerts and settings screens
├── presenters/         # Business logic layer
│   ├── auth/
│   ├── devices/
│   └── alerts/
└── widgets/            # Reusable widgets
    └── common/
```

## 🗺️ Development Roadmap

### ✅ Phase 1: Authentication
- [x] Login screen
- [x] Forgot password screen
- [ ] Firebase Authentication integration

### ✅ Phase 2: Device Provisioning
- [x] Add device screen
- [ ] Bluetooth scanning (BLE)
- [ ] Wi-Fi configuration

### ✅ Phase 3: Dashboard & Monitoring
- [x] Devices list screen
- [x] Machine details screen with charts
- [ ] Real-time data integration
- [ ] Backend API integration

### ✅ Phase 4: Alerts & Settings
- [x] Alerts list screen
- [x] Settings screen
- [ ] Push notifications (FCM)
- [ ] Account management
- [ ] Notification preferences

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.9.2`
- Dart SDK: `>=3.0.0`
- Android Studio / VS Code
- iOS: Xcode (for iOS development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/softwarePredador/vigiatech.git
cd vigiatech
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 📦 Dependencies

Current dependencies include:
- `flutter` - Flutter SDK
- `cupertino_icons` - iOS style icons

Future integrations:
- Firebase Authentication
- Firebase Cloud Messaging
- Bluetooth Low Energy (flutter_blue_plus)
- Charts library (fl_chart)
- State management (Provider/Riverpod)

## 🧪 Testing

```bash
flutter test
```

## 📄 License

This project is proprietary software developed for industrial IoT monitoring.

## 👥 Contact

For support or inquiries, please contact the development team.

---

**Version**: 1.0.0  
**Last Updated**: 2025
