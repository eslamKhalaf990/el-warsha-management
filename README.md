# El Warsha ERP - Enterprise Resource Planning System

A sophisticated **cross-platform ERP application** built with Flutter & Dart, designed specifically for managing workshop operations, inventory, orders, and financial transactions with a professional, intuitive interface.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Flutter](https://img.shields.io/badge/flutter-3.24%2B-blue.svg)
![Dart](https://img.shields.io/badge/dart-3.4%2B-blue.svg)
![License](https://img.shields.io/badge/license-Private-red.svg)

---

## Overview

El Warsha is a comprehensive ERP system that streamlines business operations through intelligent data management, real-time analytics, and seamless workflow automation. Perfect for workshops, manufacturing facilities, and service-based businesses operating across multiple regions.

### Platform Support
- **Android** - Optimized mobile experience
- **iOS** - Native iOS support
- **Web** - Fully responsive desktop interface (Firebase hosted)
- **Windows/Desktop** - Native desktop application

---

## Core Features

### 1. Intelligent Dashboard & Analytics
- **Real-time KPI Cards**: Monitor key performance indicators at a glance
  - Total Revenue
  - Order Volume
  - Average Order Value
  - Customer Lifetime Value
- **Revenue Analytics**: Interactive line charts visualizing revenue trends
- **Revenue by Source**: Multi-source revenue breakdown and comparison
- **Customer Segmentation**: Advanced customer grouping and performance analysis
- **Regional Performance**: Top-performing regions with drill-down capability
- **Daily Revenue Table**: Last 30 days revenue tracking with detailed breakdowns
- **Refreshable Insights**: Pull-to-refresh for real-time data updates

### 2. Comprehensive Product Management
- **Product Catalog**: Full CRUD operations for product inventory
- **Inventory Tracking**: Real-time stock level management
- **Batch Operations**: Drag-and-drop file uploads for bulk product imports
- **Product Categories**: Hierarchical category organization
- **Product Variants**: Support for multiple product variations
- **Pricing Control**: Dynamic pricing and discount management
- **File Import/Export**: Excel-based product import for bulk operations

### 3. Advanced Order Management
- **Order Creation**: Intuitive multi-step order creation wizard
  - Customer selection/creation
  - Product selection with quantity management
  - Payment details configuration
  - Delivery & shipping zone assignment
- **Order Tracking**: Complete order lifecycle management
  - Status tracking (Pending, Processing, Completed, Shipped, Delivered)
  - Payment status monitoring
  - Delivery tracking
- **Order Search & Filtering**: 
  - Filter by governorate (25+ Egyptian regions)
  - Filter by payment method
  - Search by customer name
  - Advanced order status filters
- **Order Updates**: Modify order details post-creation
  - Update customer information
  - Modify product selections
  - Adjust payment details
- **Bulk Export**: Export orders to Excel with complete formatting
  - Includes all order metadata
  - Professional styling
  - Currency formatting (EGP)
  - Ready for printing/sharing

### 4. Customer Relationship Management
- **Customer Database**: Centralized customer management
- **Customer Profiles**: 
  - Full contact information
  - Multiple phone numbers
  - Delivery addresses
  - Regional classification
- **Customer Segmentation**: Group customers by governorate
- **Order History**: Complete purchase history per customer
- **Customer Analytics**: Track customer performance metrics
- **CRUD Operations**: Create, read, update, delete customer records

### 5. Vendor & Supply Chain Management
- **Vendor Directory**: Comprehensive vendor database
- **Vendor Performance**: Track vendor reliability and pricing
- **Supply Chain Integration**: Link vendors to product sourcing
- **Multi-vendor Support**: Handle multiple suppliers per product

### 6. Shipping Zones & Logistics
- **Zone Configuration**: Create and manage shipping zones
- **Regional Coverage**: Define delivery areas by governorate
- **Shipping Costs**: Configure zone-based shipping rates
- **Delivery Management**: Track orders by shipping zone
- **Regional Analytics**: Performance metrics by delivery region

### 7. Category Management
- **Product Categories**: Organize products hierarchically
- **Category CRUD**: Full category lifecycle management
- **Inventory Organization**: Improve product discoverability
- **Reporting**: Analyze sales by product category

### 8. Accounting & Financial Management
- **Transaction Tracking**: Record all financial transactions
- **Transaction Categories**: Organize transactions by type
- **Account Balance**: Real-time account balance monitoring
- **Daily Cash Reports**: Track daily cash flow
- **Transaction History**: Complete audit trail of all transactions
- **Financial Analytics**: Visualize financial trends
- **Payment Methods**: Multiple payment method support
  - Cash
  - Credit Card
  - Bank Transfer
  - Digital Payment

### 9. Report Generation & Export
- **Excel Export**: 
  - Multi-format workbook generation
  - Professional styling with headers
  - Currency formatting
  - Batch export capability
- **PDF Invoices**: Generate professional invoices
  - Order details
  - Customer information
  - Payment summaries
  - Print-ready format
- **Data Visualization**: Charts and graphs for presentations

### 10. Authentication & Security
- **Secure Login**: Username/password authentication
- **Session Management**: Maintain user sessions
- **User Profiles**: Store user information
- **Role-based Access**: Different permission levels (ready for expansion)

---

## Architecture & Design Patterns

### Architecture Highlights
- **MVVM (Model-View-ViewModel)**: Clean separation of concerns
- **Provider Pattern**: State management using Provider package
- **Service Layer**: Abstracted business logic with API integration
- **Controller Pattern**: Specialized controllers for complex operations
- **Responsive Design**: Adaptive layouts for all screen sizes

### Technology Stack
```dart
// State Management
provider: ^6.1.2

// UI Components
flutter_spinkit: ^5.2.1           // Loading indicators
iconsax_flutter: ^1.0.0            // Professional icons
shimmer: ^3.0.0                    // Skeleton loaders

// Data Export
syncfusion_flutter_xlsio: ^31.2.10 // Excel generation
syncfusion_flutter_charts: ^31.1.23 // Advanced charts
printing: ^5.14.2                  // Print/PDF support
pdfrx: ^2.2.12                     // PDF rendering
file_saver: ^0.3.1                 // File export
file_picker: ^8.3.2                // File selection

// File Management
flutter_dropzone: ^4.2.1           // Drag-drop uploads
desktop_drop: ^0.6.0               // Desktop drag-drop

// Network & Storage
http: ^1.3.0                       // API communication
cached_network_image: ^3.4.1       // Image caching
shared_preferences: ^2.5.4         // Local storage

// Localization
intl: ^0.20.2                      // Date/number formatting
```

---

## User Interface Features

### Responsive Design
- **Desktop Layout**: Professional side navigation with full-featured content area
- **Tablet Layout**: Optimized 2-column layout
- **Mobile Layout**: Bottom navigation bar with swipe support
- **Breakpoint**: 720px threshold for layout switching

### Design System
- **Color Scheme**: Professional onyx theme (black, white, gray)
- **Typography**: Cairo Arabic font for consistent styling
- **Components**:
  - Data tables with sorting and selection
  - Expandable accordions
  - Drag-drop widgets
  - Modal dialogs
  - Toast notifications
  - Loading states with shimmer effects
  - Error handling with user-friendly messages

### Navigation
- **Multi-level Navigation**: 8 main sections + subsections
  1. Dashboard
  2. Products
  3. Orders
  4. Customers
  5. Categories
  6. Vendors
  7. Shipping Zones
  8. Accounting

---

## Getting Started

### Prerequisites
- Flutter SDK ≥ 3.24.4
- Dart SDK ≥ 3.4.4
- Android SDK (for Android builds)
- Xcode (for iOS builds)
- Node.js (for web builds with Firebase)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/eslamKhalaf990/el-warsha-management.git
   cd el-warsha-management
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (optional for web deployment)
   ```bash
   firebase init
   ```

4. **Run the app**
   ```bash
   # Mobile/Desktop
   flutter run
   
   # Web
   flutter run -d chrome
   ```

### Build Releases

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows Desktop
flutter build windows --release
```

---

## Data Models

### Core Entities
- **Order**: Contains customer, items, payment, and status
- **Product**: Inventory items with pricing and categories
- **Customer**: Contact and address information
- **Transaction**: Financial records with categorization
- **Vendor**: Supplier information and relationships
- **Category**: Product organization hierarchy
- **ShippingZone**: Regional delivery configuration

### Analysis Models
- **RevenueSummary**: Daily/monthly revenue aggregations
- **AverageBasketSize**: Customer purchase analysis
- **GovernoratePerformance**: Regional sales metrics
- **TopProducts**: Best-selling items tracking
- **AccountBalance**: Financial position tracking
- **DailyCash**: Daily cash flow reporting

---

## Configuration

### Environment Setup
The application is configured to use the production Cloudflare API endpoint:

```dart
const String baseUrl = 'https://gloves-checks-census-ascii.trycloudflare.com/';
```

Configuration is managed in `lib/services/base_url.dart` with support for multiple environments:
- **Production**: https://gloves-checks-census-ascii.trycloudflare.com/
- **Local Development**: http://localhost:8080/
- **Additional Dev**: https://mice-arrested-certificates-vocabulary.trycloudflare.com/

### API Integration
All API calls are abstracted through service classes:
- `ProductService`
- `OrdersService`
- `CustomerService`
- `AccountingService`
- `HomeService`
- And more...

---

## Performance Optimizations

- **Caching**: Image caching with `cached_network_image`
- **Lazy Loading**: On-demand data fetching
- **State Optimization**: Provider-based state management eliminates unnecessary rebuilds
- **Asset Optimization**: Compressed images and fonts
- **Web Optimization**: Firebase hosting with CDN

---

## Code Quality

- **Lint Configuration**: Enabled via `analysis_options.yaml`
- **Architecture**: Clean code principles with SOLID design patterns
- **Naming Conventions**: Consistent Dart naming standards
- **Comments**: Comprehensive code documentation
- **Error Handling**: Graceful error management with user feedback

---

## UI/UX Highlights

- Professional Dashboard: Executive-level analytics visualization
- Intuitive Forms: Multi-step wizards with validation
- Data Tables: Sortable, filterable tables with selection
- Real-time Updates: Live data synchronization
- Loading States: Skeleton screens and progress indicators
- Responsive Layouts: Mobile-first adaptive design
- Dark Mode Ready: Theme system prepared for expansion
- Arabic Support: RTL support for Arabic text (governorates)
- Print Optimization: Professional print-ready layouts
- Accessibility: Semantic HTML and proper contrast ratios

---

## Advanced Features

### Drag & Drop Operations
- Bulk import of products and orders
- Drag files directly onto the application
- Automatic file validation and processing

### Data Export Pipeline
- Multi-format support (Excel, PDF)
- Batch export operations
- Scheduled exports (ready for implementation)
- Email delivery integration (ready for implementation)

### Real-time Analytics
- Live dashboard updates
- Automatic data refresh on screen focus
- Pull-to-refresh capability
- Real-time data aggregation

### Search & Filter Engine
- Full-text search across customers
- Multi-criteria filtering
- Saved filter preferences (ready for implementation)
- Advanced query builder

---

## Support & Maintenance

### Project Structure
```
lib/
├── main.dart                 # App entry point with theme config
├── controllers/              # Business logic controllers
├── services/                 # API integration layer
├── models/                   # Data models
├── views/                    # UI screens and widgets
├── view_models/              # ViewModel classes
└── utils/                    # Helper functions and utilities
```

### Extensibility
The application is designed for easy expansion:
- Add new modules by creating new service + view model + view
- Extend existing features without affecting core functionality
- Plugin-ready architecture for third-party integrations

---

## Learning & Development

This project demonstrates:
- Advanced Flutter development patterns
- State management at scale (Provider pattern)
- API integration best practices
- Responsive design implementation
- ERP system architecture
- Data visualization techniques
- File export/import handling
- Cross-platform development

Perfect for:
- Portfolio showcasing
- Interview preparation
- Learning advanced Flutter patterns
- Production ERP implementation

---

## License

Private project. All rights reserved.

---

## Development Notes

### Recent Implementations
- Modern MVVM architecture
- Multi-platform responsive design
- Advanced analytics dashboard
- Comprehensive data export system
- Cairo font integration for Arabic support
- Shimmer loading effects
- Comprehensive error handling

### Future Enhancements
- [ ] Role-based access control (RBAC)
- [ ] Email notifications
- [ ] SMS alerts for important orders
- [ ] Advanced reporting suite
- [ ] Mobile app push notifications
- [ ] Dark mode theme
- [ ] Multi-language support
- [ ] Advanced forecasting analytics
- [ ] Automated backup system
- [ ] Mobile offline support

---

## Key Metrics Tracked

- Total Revenue & Daily Revenue
- Total Customers & New Customers
- Total Orders & Order Status Distribution
- Payment Methods & Success Rates
- Regional Performance & Top Governorates
- Average Basket Size & Customer Lifetime Value
- Revenue Trends & Forecasts

---

## Quick Links

- [Flutter Documentation](https://flutter.dev)
- [Dart Packages](https://pub.dev)
- [Provider Package](https://pub.dev/packages/provider)
- [Firebase Console](https://console.firebase.google.com)

---

**Built with passion using Flutter & Dart | Version 1.0.0**















