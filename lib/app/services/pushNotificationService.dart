// import 'dart:convert'; // Import this for jsonEncode
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart' as auth;
//
// import '../../global/log_printer.dart';
//
// class PushNotificationService {
//   static Future<String> getAccessToken() async {
//     // Service Account JSON
//     final serviceAccountJson = {
//       "type": "service_account",
//       "project_id": "shopaholic-f3d48",
//       "private_key_id": "80d68d6d9de955bc0c7b8d5609d50055c62a1335",
//       "private_key":
//           "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDUmzaA8jr+uysr\n3jSJN+iQV/bOP6uW3Yb5dTFV0h52XJSchu6hFaexmIF98RHlficEEXh6X5FVPWIt\n2ZLdI7+fh1ubTKCsqg8ftug7kRfXmT2UaI6llmpvnlLhZgO2XOvOBiQgkpVwfTj/\nMz2rVG5u7KCRG0QIarT9D6HbQJiPIAz3UVnveS9GlN6ep+Xrqpx0+czIzKggbnuh\nn+FabCLfXMwnqwdCAvPTO9h0DLlatntewYInrPbQrOv8l9eUDLrhrvU4wXROYfkZ\nCQ5uf5QoKIJzMMrlm/3lK/aLYKgcBwK0XHsOf56JzB/Nz9ptJnAJq1lgEGLmxkFz\nY0ovLUArAgMBAAECggEAF6hrOOS7hTEAAtJSd5p4ZJIv7Toki+smuTI979Yr0Zvy\nZYtA7pKMUIovOVEkCVeFBpeIbTBJPyT6Jy6jgGbD91UxRRISfGQyvqK0gOcKXNFj\n4CnVBb67z/kxhny67ltfWf5Q8tbyOMxBFWohnfkNONwCmg21/6xwFguGmpvmM2F3\nuPLuRCLZ0zJmx/rlo84vic9VZnKQQQHdjL7Kf/H6xub6LHe8Rn9Pb67R+pIcxVfn\nc525uHItCeAa7h1Lqc0Jpimn4wtL+cnedRvuTYS8/FwvqKQTDMgbP3iEe9GS8pbc\njqVel1rnaj9RiDGffL2WRe3A2Hzzeh2g8suy2X2joQKBgQDrP7WWbxzJFSsGAebs\nvEZWMLJc+qy+mvgpiCLnN3mOPvwGiH9ayWKgk/FUupCbyCU+39uwwyhLDiJQaN0j\ns/F0S8IvK/W/nGaD03tDXHmNvXGE70CafWQRVqGYLiN5wwLqNFovzRisjS0f4rTv\n33tuG7XCxQrd0qdiVt4bZFAq8wKBgQDnXDLgt5M1j5nAeI+5dXcE/03+Z4GF13vY\n+FyXVCVuqPmxZehpiCgb3Y2fFH50miZCSv8XsBCuzOpXrb62V0tXIskbQeC7d58y\nYFwJaR1Q9ksCroRKfob6BzBLQYdFFtclY4HdSPqWiUSOhubhV+vp9X53PNtlhJnc\nc7f6iilz6QKBgBI6T4Gmfl5+S2UdxJzXQcPv5gIaUkQ6kbv2Fm4/+CUzcCe5b9TD\nAedbTzm3cvj/GxOyGL2rgXW/VJ1SYsAfczgFnrg0+cetAKx6OHTRt4FqCl+4ghL2\nYEiPo9m8yXbny1QGVm6Zv62vCq4LzOVBNbkkYIME7YCej+WowXDx5txNAoGAJFKM\nRk1r1h/aYqZK4jH34pf2dbdoVUv0TKcJWlTCn7H1qY03RMI0kdNhtZTxGXtOAGBn\n1h81L0xKikNjypq/4Ek8y4O3NZddLfqE2JFhIeHY+u3NJSjiJgTU5yu9gfJJCryp\nmcUoWlPoqHuzabN0/UEmfq/WPgToZvzf6Hyib2kCgYEAyXb0s9uyQrcRvXKw/9ZA\np6/3rVO202IMg15VkbbWRMlNfVOrmyGiZoliPoPjlXdyOFYYtNw3TxCreHifewKS\nBadLU9f/I+FYT4Kap8il6x9kddMWjJb3+ZofrUNDc9Wh0O/t+/wH3TYmP81OuT0g\nB1V/WgL64M4JeyWylTrGJB8=\n-----END PRIVATE KEY-----\n",
//       "client_email":
//           "shopaholic-arcadexit@shopaholic-f3d48.iam.gserviceaccount.com",
//       "client_id": "105240726136467929811",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url":
//           "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url":
//           "https://www.googleapis.com/robot/v1/metadata/x509/shopaholic-arcadexit%40shopaholic-f3d48.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };
//
//     List<String> scopes = [
//       "https://www.googleapis.com/auth/firebase.messaging"
//     ];
//
//     // Create an authenticated client
//     final client = http.Client();
//     final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
//       auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//       scopes,
//       client,
//     );
//     client.close();
//
//     return credentials.accessToken.data;
//   }
//
//   static Future<void> sendNotificationToSelectedDriver({
//     required String deviceToken,
//     required BuildContext context,
//     required String currentUserName,
//     required String currentUserMsg,
//   }) async {
//     final String serverKey = await getAccessToken();
//     String endpointFirebaseCloudMessaging =
//         'https://fcm.googleapis.com/v1/projects/shopaholic-f3d48/messages:send';
//
//     final Map<String, dynamic> message = {
//       'message': {
//         'token': deviceToken.toString(),
//         'notification': {
//           'title': currentUserName,
//           'body': currentUserMsg,
//         },
//       }
//     };
//
//     try {
//       final http.Response response = await http.post(
//         Uri.parse(endpointFirebaseCloudMessaging),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $serverKey',
//         },
//         body: jsonEncode(message),
//       );
//
//       if (response.statusCode == 200) {
//         Log.i('Notification sent successfully');
//       } else {
//         Log.e(
//             'Failed to send notification: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       Log.e('Error sending notification: $e');
//     }
//   }
// }
