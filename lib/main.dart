// import 'package:chat/screens/auth/auth.dart';
// import 'package:chat/screens/chat/chat.dart';
// import 'package:chat/screens/splash.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiper_test/providers/card_provider.dart';
import 'package:swiper_test/screens/swiper.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

import 'package:swiper_test/screens/swiper/widgets/card.dart';

void main() async {
  // needed if you want to use async methods in main()
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 68, 177, 17)),
        ),
        // // home: AuthScreen(),
        // // is like FeatureBuilder but takes a stream instead of a Future
        // home: StreamBuilder(
        //   // this tream handled by firebase sdk notify us about auth state changes
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (ctx, userSnapshot) {
        //     // if is loading session, show splash screen
        //     if (userSnapshot.connectionState == ConnectionState.waiting) {
        //       return const SplashScreen();
        //     }
        //     if (userSnapshot.hasData) {
        //       return const ChatScreen();
        //     }
        //     return AuthScreen();
        //   },
        // ),
        home: const SwiperScreen(),
      ),
    );
  }
}




// card
// import 'package:flutter/material.dart';

// import 'package:card_swiper/card_swiper.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Swiper(
//         itemBuilder: (BuildContext context, int index) {
//           return Image(
//             image: AssetImage(
//               "assets/images/player-${index + 1}.jpeg",
//               // fit: BoxFit.fill,
//             ),
//           );
//           // },
//           // itemBuilder: (BuildContext context, int index) {
//           //   return Image.network(
//           //     "https://via.placeholder.com/350x150",
//           //     fit: BoxFit.fill,
//           //   );
//         },
//         itemCount: 4,
//         // pagination: SwiperPagination(),
//         // control: SwiperControl(),
//       ),
//     );
//   }
// }
