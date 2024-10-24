# Notes App - Hacktoberfest Edition

Welcome to the Notes App! This application allows users to create, manage, and organize notes efficiently. It’s built with Flutter, making it compatible across various platforms. Whether you're participating in Hacktoberfest or just looking for a notes app, we’re glad you’re here!

## Table of Contents
- [Features](#features)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Installing Flutter](#installing-flutter)
    - [macOS](#macos)
    - [Linux](#linux)
- [Running the App](#running-the-app)
- [Contributing](#contributing)
- [License](#license)

## Installation

### Prerequisites
Before you begin, ensure you have the following installed:
- Git
- An IDE (like VS Code or Android Studio)

### Installing Flutter

#### macOS
1. **Download Flutter SDK:**
   Visit the [Flutter installation page](https://flutter.dev/docs/get-started/install/macos) and download the latest stable release.

2. **Extract the zip file:**
   Open your terminal and run:
   ```bash
   cd ~/Downloads
   unzip flutter_macos_<version>.zip
   ```

3. **Move Flutter to a desired location:**
   ```bash
   mv flutter /Users/<your-username>/development
   ```

4. **Update your path:**
   Add the following line to your `~/.zshrc` or `~/.bash_profile`:
   ```bash
   export PATH="$PATH:/Users/<your-username>/development/flutter/bin"
   ```
   Then run:
   ```bash
   source ~/.zshrc
   ```

5. **Run Flutter doctor:**
   ```bash
   flutter doctor
   ```
   Follow any additional instructions to complete the setup.

#### Linux
1. **Download Flutter SDK:**
   Visit the [Flutter installation page](https://flutter.dev/docs/get-started/install/linux) and download the latest stable release.

2. **Extract the tar file:**
   Open your terminal and run:
   ```bash
   cd ~/Downloads
   tar xf flutter_linux_<version>.tar.xz
   ```

3. **Move Flutter to a desired location:**
   ```bash
   sudo mv flutter /usr/local/flutter
   ```

4. **Update your path:**
   Add the following line to your `~/.bashrc` or `~/.profile`:
   ```bash
   export PATH="$PATH:/usr/local/flutter/bin"
   ```
   Then run:
   ```bash
   source ~/.bashrc
   ```

5. **Run Flutter doctor:**
   ```bash
   flutter doctor
   ```
   Follow any additional instructions to complete the setup.

## Running the App
1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/notes-app.git
   cd notes-app
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## Contributing
We welcome contributions! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## **Note:** People could create their own issues and start working on it. The issues created however would be considered under Hack-The-Week only if the issues is considered worthy enough. 

Happy coding, and thanks for contributing to the Notes App during Hacktoberfest! 🎉
