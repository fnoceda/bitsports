// import 'dart:io';

// import 'package:bitsports/features/home/models/custom_people_model.dart';
// import 'package:bitsports/features/home/models/specie_model.dart';
// import 'package:bitsports/features/home/models/planet_model.dart';
// import 'package:bitsports/features/home/models/success_response_model.dart';
// import 'package:bitsports/features/home/models/vehicle_model.dart';
// import 'package:bitsports/features/home/pages/home_page.dart';
// import 'package:bitsports/features/home/repositories/starwars_repository.dart';
// import 'package:bitsports/features/home/services/people_service.dart';
// import 'package:bitsports/models/response_model.dart';
// import 'package:bitsports/routes/routes.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart';
// import 'package:http/testing.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// mixin MockStarWarsData implements MockStarWarsRepository {
//   @override
//   Future<Either<SuccessResponseModel, String>> getPeople(
//       {required String page, required http.Client http}) async {
//     String error = 'Some String';
//     ResponseModel response = await getFileData(filePath: page);

//     if (response.success) {
//       SuccessResponseModel rta = SuccessResponseModel.fromMap(response.data);
//       return Left(rta);
//     } else {
//       return Right(error);
//     }
//   }

//   @override
//   Future<Either<PlanetModel, String>> getPlanet(
//       {required String page, required http.Client http}) async {
//     String error = 'Some String';
//     ResponseModel response = await getFileData(filePath: page);

//     if (response.success) {
//       final PlanetModel data = PlanetModel.fromMap(response.data);
//       return Left(data);
//     } else {
//       return Right(error);
//     }
//   }

//   @override
//   Future<Either<SpecieModel, String>> getSpecies(
//       {required String page, required http.Client http}) async {
//     String error = 'Some String';
//     ResponseModel response = await getFileData(filePath: page);

//     if (response.success) {
//       final SpecieModel data = SpecieModel.fromMap(response.data);
//       return Left(data);
//     } else {
//       return Right(error);
//     }
//   }

//   @override
//   Future<Either<VehicleModel, String>> getVehicle(
//       {required String page, required http.Client http}) async {
//     String error = 'Some String';
//     ResponseModel response = await getFileData(filePath: page);

//     if (response.success) {
//       final VehicleModel data = VehicleModel.fromMap(response.data);
//       return Left(data);
//     } else {
//       return Right(error);
//     }
//   }

//   Future<ResponseModel> getFileData({required String filePath}) async {
//     late ResponseModel response;

//     if (File(filePath).existsSync()) {
//       final fileContents = await File(filePath)
//           .readAsString(); //await rootBundle.loadString(filePath);
//       final decodedJson = convert.jsonDecode(fileContents);

//       response = ResponseModel(success: true, message: 'OK', data: decodedJson);
//     } else {
//       // print('MocStarWarsRepository:: [$filePath] does not exist');
//       response =
//           ResponseModel(success: false, message: 'File not found', data: null);
//     }
//     return response;
//   }
// }

// class MockStarWarsRepository extends Mock implements StarWarsRepository {}

// class MockPeopleService extends Mock implements PeopleService {}

// void main() {
//   late MockStarWarsRepository mockStarWarsRepository;
//   late MockClient peopleHttp;
//   late MockPeopleService mockPeopleService;


//   MockClient getMokClient({required filePath, int responseCode = 200}) {
//     final mockHTTPClient = MockClient((request) async {
//       final content = await File(filePath).readAsString();
//       return Response(content, responseCode);
//     });

//     return mockHTTPClient;
//   }

//   setUp(() {
//     mockStarWarsRepository = MockStarWarsRepository();
//     peopleHttp = getMokClient(
//         filePath: 'test/features/home/data/people_data.json',
//         responseCode: 200);
//     //   sut = NewsChangeNotifier(mockNewsService);
//     mockPeopleService = PeopleService();
//   });

//   Widget createWidgetUnderTest() {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//             create: (_) => PeopleService(mockStarWarsRepository, peopleHttp)),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'BitSports',
//         theme: ThemeData.dark().copyWith(
//             primaryColor: Colors.black,
//             scaffoldBackgroundColor: Colors.white,
//             appBarTheme: const AppBarTheme(
//               color: Color(0xff121212),
//               elevation: 0,
//               iconTheme: IconThemeData(color: Colors.white),
//             ),
//             textTheme: const TextTheme(
//               bodyText1: TextStyle(color: Colors.white),
//               headline2: TextStyle(color: Color(0xffEC5757)),
//             )),
//         home: const HomePage(),
//         onGenerateRoute: RouteGenerator.generateRoute,
//       ),
//     );
//   }

//   group("home page widgets tests", () {
//     testWidgets(
//       "title is displayed",
//       (WidgetTester tester) async {
//         await tester.runAsync(() async {
//           await tester.pumpWidget(createWidgetUnderTest());

//           Future.delayed(Duration.zero, () {
//             // tester.tap(find.text('GO'));
//             expect(find.text('People of Star Wars'), findsOneWidget);
//           });
//         });
//       },
//     );
//   });
// }
