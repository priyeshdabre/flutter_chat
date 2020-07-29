# chat_app

A chat application build on flutter.

## Libraries Used

- [flutter_bloc](https://pub.dev/packages/flutter_bloc): v6.0.1 (For state management)
- [equatable](https://pub.dev/packages/equatable): v1.2.3 (For equating objects)
- [hive_flutter](https://pub.dev/packages/hive_flutter): v0.3.1 (For storing data locally)
- [flutter_hooks](https://pub.dev/packages/flutter_hooks): v0.12.0 (This library itself manages the state of controllers)
- [firebase_auth](https://pub.dev/packages/firebase_auth): v0.16.1 (Used Firebase Authentication for Sign Up and Sign In)
- [google_sign_in](https://pub.dev/packages/google_sign_in): v4.5.1 (Used Google Sign In)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore): v0.13.7 (Used Firebase Cloud Storage)

## Features

- This App uses Flutter Bloc to efficently emit states based on events.
- This App contains Sign In and Sign Up functionality for which it uses Firebase Authentication.
- This App uses Firebase Cloud Storage to save user data. 
- Sign in with google is also implemented.
- Also used Hive Database to efficently store data on Local Device.
