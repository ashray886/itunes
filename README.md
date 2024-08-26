# iTunes App

This Flutter application integrates with the iTunes Media API to fetch and display media content. The app is built to demonstrate the use of RESTful APIs, JSON data handling, and creating a user-friendly interface with strong security measures.

## Features

- **Search Functionality**: Search for music, movies, podcasts, and more.
- **Detailed Media Display**: Show media type, title, artist/author, artwork, and preview link.
- **Grouped GridView**: Organize and display search results efficiently.
- **Responsive UI**: Visually appealing and adaptive design for all screen sizes.
- **Security**: Implemented SSL Public Key Pinning and Root Detection for enhanced security.
- **Integration Tests**: Ensures reliability through automated testing.

## Security Features

This app includes the following security measures:

- **SSL Public Key Pinning**: Ensures that the app only communicates with a trusted server by verifying the server's SSL certificate. This prevents man-in-the-middle attacks.
- **Root Detection**: Detects if the device is rooted or jailbroken, which could compromise the app's security. If a rooted device is detected, the app can restrict access or limit functionality to protect user data.

## Packages Used

This project utilizes the following Dart/Flutter packages:

- **flutter_riverpod: ^2.5.1**: State management solution for Flutter.
- **riverpod_annotation: ^2.3.5**: Annotations for generating Riverpod code.
- **go_router: ^14.2.3**: Declarative routing package for Flutter.
- **dio: ^5.5.0+1**: Powerful HTTP client for Dart, used for network requests.
- **intl: ^0.19.0**: Internationalization and localization support.
- **group_grid_view: ^1.0.1**: Grid view widget for displaying grouped items.
- **cached_network_image: ^3.4.0**: Caches network images for faster loading.
- **url_launcher: ^6.3.0**: Launch URLs in the browser or other apps.
- **webview_flutter: ^4.8.0**: Embeds web content in the app.
- **safe_device: ^1.1.7**: Detects whether the device is rooted for added security.

## Installation

To run this project, follow these steps:

1. **Clone the repository:**
 </br> git clone https://github.com/SabinSajeevan/iTunes.git
</br> cd itunes
  </br> flutter pub get
  </br> flutter run

## Testing


Integration tests have been implemented to ensure the app's reliability.
</br>To run the tests:


flutter test integration_test/itunes_app_test.dart

## Screenshots
<table>
  <tr>
     <td><img src="https://github.com/user-attachments/assets/6c3f9702-0a8a-4e36-8a82-45e79c07b1e9"></td>
<td><img src="https://github.com/user-attachments/assets/89a1b9c7-33eb-4b89-bae2-fedc05e56a8c"></td>
<td><img src="https://github.com/user-attachments/assets/d92d87b3-c733-497e-a7ee-9998d293d26a"></td></tr>
<tr>
   <td><img src="https://github.com/user-attachments/assets/6c933bec-2d31-45f4-bbf4-5708995cdcdd"></td>
   
   <td><img src="https://github.com/user-attachments/assets/91f19587-1eda-48cf-af23-c297141d72d8"></td>

   <td><img src="https://github.com/user-attachments/assets/cdaed869-2ee8-4a50-be19-5d3a99484d7d"></td>
</tr></table>
