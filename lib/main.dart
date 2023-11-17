import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(nativeAppKey: '98e0177d9f83da7141899f50cccf9619');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("카카오 로그인 서비스", style: TextStyle(fontSize: 30)),
          ElevatedButton(
              onPressed: () async {
                if (await isKakaoTalkInstalled()) {
                  print("카카오독이 설치되어있습니다");
                  await UserApi.instance.loginWithKakaoTalk();
                } else {
                  print("카카오톡이설치되어있지않습니다");
                  OAuthToken oauthToken =
                      await UserApi.instance.loginWithKakaoAccount();
                  print(oauthToken.accessToken);
                  print(oauthToken.expiresAt);
                  print(oauthToken.scopes![0]);
                }
              },
              child: Text("카카오로그인")),
        ],
      ),
    );
  }
}
