This is the firebase implementation for the login interface. 

## Features

The ability to log in through firebase.
The ability to send a password forget email.

## Getting started

In order to use this service you need to add this package and the service to your app as dependency.

add the following to your pubspec.yaml:
```yaml
  flutter_login_firebase:
    git:
      url: https://github.com/Iconica-Development/flutter_login_service.git
      path: packages/flutter_login_interface
  flutter_login_service:
    git:
      url: https://github.com/Iconica-Development/flutter_login_service.git
      path: packages/flutter_login_service
```

You also require the firebase core package:

`flutter pub get firebase_core`

Then in your code, import the service

`import 'package:flutter_login_service/flutter_login_service.dart'`

and the firebase data source

`import 'package:flutter_login_firebase/flutter_login_firebase.dart'`


## Usage

You can find an example of how to use this package in the `/example` folder.

In that folder, you can use the `flutter create .` to create the platform specific implementations for this project.
Then you can use `flutterfire configure` from the fluttterfire cli to set up firebase.

When you have done that you can include the firebase service as follows:



```dart
void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// in your app
final _service = LoginService.forDatasource(dataSource: FirebaseLogin(Firebase.app()));


Future<void> _login() async {
    var form = _formKey.currentState!;
    if (form.validate()) {
        form.save();
        await _service.loginWithEmailAndPassword(email, password);
    }
}

```

