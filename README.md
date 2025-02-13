📞 Phone Dialer App

A modern and feature-rich Phone Dialer App built with Flutter, offering functionalities like contact management, call history, number blocking, and international dialing with country flags. The app also supports dark mode for a seamless user experience.

✨ Features

Dial Pad – Intuitive dialer interface for quick dialing.
Call History – View recent call logs with timestamps.
Contacts Integration – Syncs with Google Contacts API.
International Dialing – Select country codes with flags.
Number Blocking – Block and unblock contacts easily.
Dark Mode Support – UI adjusts based on theme preferences.
🛠️ Tech Stack
Flutter – Frontend framework.
Dart – Programming language.
Google Contacts API – Contacts synchronization.
call_log & contacts_service – Managing call logs and contacts.
provider – State management.

📦 Dependencies

Add the following to your pubspec.yaml:



dependencies:

flutter:

  sdk: flutter
  
  call_log: ^4.0.0
  
  contacts_service: ^0.6.3

  provider: ^6.0.5


  
  flutter_localizations:
    


🚀 Getting Started

Clone the Repository

git clone https://github.com/ShivangChoudhary/Phone-Dialer-App.git

cd phone_dialer_app

Install Dependencies

flutter pub get

Run the App

flutter run
