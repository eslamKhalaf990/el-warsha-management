# El Warsha ERP - Enterprise-Grade Workshop Management System

A sophisticated **Full-Stack ERP solution** built with Flutter & Dart. This project demonstrates advanced cross-platform development, complex state management, and deep business intelligence integration designed to manage high-volume workshop operations and financial ecosystems.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Flutter](https://img.shields.io/badge/flutter-3.24%2B-blue.svg)
![Architecture](https://img.shields.io/badge/architecture-MVVM-green.svg)
![State Management](https://img.shields.io/badge/state-Provider-orange.svg)

---

## Why This Project Stands Out

This isn't just a CRUD application. El Warsha ERP implements real-world enterprise requirements:
- **Advanced Business Intelligence (BI)**: Features a robust analytics engine tracking **Customer Lifetime Value (CLV)**, **Retention Metrics (At-Risk)**, and regional performance across 25+ Egyptian governorates.
- **Complex State Management**: Orchestrates 15+ Providers and complex object builders, including a multi-step **Order Engineering Wizard**.
- **Enterprise Design System**: Implements the custom **"Onyx" Design System**—a high-contrast, data-dense UI optimized for professional productivity and reduced eye strain.
- **Production-Ready Architecture**: Strict adherence to **MVVM**, **Service-Oriented Architecture (SOA)**, and **Dependency Injection (DI)** principles.
- **Data Engineering**: Robust Excel/PDF export pipeline using the Syncfusion engine for professional reporting.

---

## Key Modules & Technical Implementation

### 1. Business Intelligence & Analytics Dashboard
*The brain of the operation. Transforms raw data into actionable insights.*
- **Predictive Retention**: Identification of "At-Risk" customers based on activity algorithms.
- **Customer Segmentation**: Automated categorization into Loyal, VIP, and Discount-Seeker groups.
- **Financial KPIs**: Real-time monitoring of **Average Basket Size**, Revenue by Source, and Daily Cash Flow.
- **Regional Performance**: Performance heatmaps for all Egyptian governorates.

### 2. Professional Order Engineering
*A multi-step builder pattern designed for speed and accuracy.*
- **Stateful Wizard**: Maintains complex order state (Customer + Products + Shipping + Payment) across multiple screens using a builder pattern.
- **Dynamic Inventory Sync**: Real-time quantity adjustments and price calculations within the cart.
- **Advanced Query Engine**: Multi-criteria filtering (Region, Payment Status, Source) to manage thousands of records efficiently.

### 3. Financial & Accounting Engine
*Complete transparency and auditability.*
- **Transaction Ledger**: Full audit trail for every EGP in the system.
- **Multi-Channel Tracking**: Monitoring balances across Cash, Bank, and Digital payments.
- **Category-Based Accounting**: Automatic categorization of expenses and revenue streams.

### 4. Inventory & Supply Chain
- **Hierarchical Cataloging**: Multi-level product categories for intuitive navigation.
- **Vendor Lifecycle Management**: Comprehensive sourcing and performance tracking for suppliers.
- **Bulk Operations**: Drag-and-drop Excel processing for massive inventory updates.

---

## Technical Architecture

### Design Patterns
- **MVVM (Model-View-ViewModel)**: Decouples UI from business logic, ensuring the codebase is testable and maintainable.
- **Service Layer Pattern**: All external API communications are abstracted into dedicated services (`OrdersService`, `AccountingService`, etc.) with built-in timeout and error handling.
- **Dependency Injection**: Services are injected into ViewModels using Provider, facilitating easy mocking for unit tests.
- **Immutable State Updates**: Using `copyWith` patterns for predictable state transitions (see `AddOrderVM`).

### Technology Stack
| Layer | Technology |
| :--- | :--- |
| **Framework** | Flutter (Dart 3.x) |
| **State Management** | Provider / ChangeNotifier |
| **Reporting** | Syncfusion Excel/Charts |
| **Data Export** | Printing / PDF Library |
| **Networking** | HTTP with Custom Service Interceptors |
| **UI/UX** | Iconsax, Shimmer Effects, Cairo Typography |

---

## The "Onyx" Design System
Designed for **power users**, the Onyx UI focuses on:
- **Data Density**: Maximizing information visibility without cluttering.
- **Professional Aesthetic**: A high-contrast palette of Black, White, and Slate Grey.
- **Responsive Adaptability**: Seamless transition between Mobile Bottom-Nav and Desktop Side-Rail layouts.
- **Micro-interactions**: Reactive feedback loops, shimmer loading states, and smooth transitions.

---

## Installation & Setup

```bash
# Clone the repository
git clone https://github.com/eslamKhalaf990/el-warsha-management.git

# Install dependencies
flutter pub get

# Run the project
flutter run
```

---

**Developed by [Eslam Khalaf]**  
*Focused on building scalable, maintainable, and high-impact enterprise applications.*
