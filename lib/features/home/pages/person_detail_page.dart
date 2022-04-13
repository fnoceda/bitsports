import 'package:animate_do/animate_do.dart';
import 'package:bitsports/features/home/models/custom_people_model.dart';
import 'package:bitsports/features/home/services/people_service.dart';
import 'package:bitsports/features/home/widgets/loading_widget.dart';
import 'package:bitsports/utils/extensions.dart';
import 'package:bitsports/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PersonDetailPage extends StatelessWidget {
  final CustomPeopleModel person;
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    PeopleService peopleService =
        Provider.of<PeopleService>(context, listen: false);
    // print('building person detail page');

    return Container(
      color: const Color(0xff121212),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xffFFFFFF)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            person.name,
            style: MyStyles.appBarTitleStyle,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              GInformation(person: person),
              Expanded(
                  child: FadeIn(
                      child:
                          _vehicles(context, peopleService, person: person))),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _vehicles(context, PeopleService peopleService,
    {required CustomPeopleModel person}) {
  return FutureBuilder(
    future: peopleService.getVehicles(person: person),
    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
      if (snapshot.hasData) {
        List<String> vehicles = snapshot.data!;
        // print('vehicles=> ' + vehicles.length.toString());
        return VehiclesList(vehicles: vehicles);
      } else if (snapshot.hasError) {
        return Text(
          '${snapshot.error}',
          style: MyStyles.errorTextStyle,
        );
      }

      return SizedBox(
        width: double.infinity,
        height: 80,
        child: Column(children: const [LoadingWidget()]),
      );
    },
  );
}

class VehiclesList extends StatelessWidget {
  final List<String> vehicles;
  const VehiclesList({Key? key, required this.vehicles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int items = 2;
    return Column(
      children: [
        Container(
          // color: Colors.red,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: const ListTile(
              title: Text(
            'Vehicles',
            style: MyStyles.titleStyle,
          )),
        ),
        (() {
          if (vehicles.isEmpty) {
            // print('cero');
            return const Expanded(
                child: ListTile(
              title: Text(
                'No vehicles for this person',
                style: MyStyles.errorTextStyle,
              ),
            ));
          } else {
            // print('NO cero');

            return Expanded(
              child: FadeInLeft(
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: vehicles.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(color: Colors.grey);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          VehicleLisTile(text: vehicles[index]),
                          (() {
                            if (index == items - 1) {
                              return const Divider(color: Colors.grey);
                            } else {
                              return Container();
                            }
                          }()),
                        ],
                      );
                    }),
              ),
            );
          }
        }())
      ],
    );
  }
}

class VehicleLisTile extends StatelessWidget {
  final String text;
  const VehicleLisTile({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: MyStyles.detailGrey,
      ),
    );
  }
}

class GInformation extends StatelessWidget {
  final CustomPeopleModel person;
  const GInformation({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.red,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: const ListTile(
              title: Text(
            'General Information',
            style: MyStyles.titleStyle,
          )),
        ),
        GIDetail(strKey: 'Eye Color', strValue: person.eyeColor),
        const Divider(color: Colors.grey),
        GIDetail(strKey: 'Hair Color', strValue: person.hairColor),
        const Divider(color: Colors.grey),
        GIDetail(strKey: 'Skin Color', strValue: person.skinColor),
        const Divider(color: Colors.grey),
        GIDetail(strKey: 'Birth Year', strValue: person.birthYear),
        const Divider(color: Colors.grey)
      ],
    );
  }
}

class GIDetail extends StatelessWidget {
  final String strKey;
  final String strValue;
  const GIDetail({
    Key? key,
    required this.strKey,
    required this.strValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 49,
      padding: const EdgeInsets.only(left: 16, top: 15, right: 16, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(strKey.capitalize(), style: MyStyles.detailGrey),
          Text(strValue.capitalize(), style: MyStyles.detailBlack),
        ],
      ),
    );
  }
}
