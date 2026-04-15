# Flutter Task Manager - MobX & MVVM

A task management application built with Flutter, demonstrating a clean **MVVM (Model-View-ViewModel)** architecture combined with **MobX** for reactive state management.

## 🚀 Features

- **Task Management**: Create, Read, Update, and Delete tasks.
- **Persistent Storage**: Uses **Hive** for fast, local NoSQL database storage.
- **Reactive UI**: State management powered by **MobX** for automatic UI updates.
- **Clean Architecture**: Organized into features and core layers for scalability.
- **Dependency Injection**: Managed via the **Provider** package.
- **Custom Routing**: Centralized route management.

## 🏗 Architecture (MVVM + MobX)

This project follows the MVVM design pattern:

- **Model**: Represents the data layer (Hive objects/JSON models).
- **View**: Flutter widgets that display the UI and observe the ViewModel.
- **ViewModel**: Contains business logic and uses MobX `@observable` and `@action` to manage state.
- **Repository**: Acts as an intermediary between the ViewModel and Data Sources (Hive).

## 📁 Project Structure

```text
lib/
├── app/                  # App-level config (Theme, Router)
├── core/                 # Shared components
│   ├── base/             # Base classes (BaseViewModel)
│   ├── constants/        # App constants (App, Navigation)
│   └── utils/            # Database and UI utilities
└── features/             # Feature-based modules
    └── task/             # Task feature
        ├── model/        # Data models
        ├── repository/   # Data abstraction layer
        ├── view/         # UI screens and widgets
        └── viewmodel/    # MobX stores
```

## 🛠 Tech Stack

- **State Management**: [MobX](https://pub.dev/packages/mobx) & [flutter_mobx](https://pub.dev/packages/flutter_mobx)
- **Dependency Injection**: [Provider](https://pub.dev/packages/provider)
- **Database**: [Hive](https://pub.dev/packages/hive)
- **Code Generation**: [build_runner](https://pub.dev/packages/build_runner), [mobx_codegen](https://pub.dev/packages/mobx_codegen), [hive_generator](https://pub.dev/packages/hive_generator)

## 🚦 Getting Started

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/Sumat-Dev/flutter-mobx-mvvm-task-manager-guide.git
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation**:
    Since this project uses MobX and Hive, you need to generate the necessary files:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app**:
    ```bash
    flutter run
    ```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
