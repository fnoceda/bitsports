import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:bitsports/features/home/models/custom_people_model.dart';
import 'package:bitsports/features/home/widgets/loading_widget.dart';
import 'package:bitsports/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:bitsports/features/home/services/people_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Container(
      color: const Color(0xff121212),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'People of Star Wars',
                style: MyStyles.appBarTitleStyle,
              ),
            ),
            body: FadeInDown(
                duration: const Duration(seconds: 1),
                child: const PeopleList())),
        // body: LoadingWidget()),
      ),
    );
  }
}

class PeopleList extends StatefulWidget {
  const PeopleList({
    Key? key,
  }) : super(key: key);

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  final ScrollController _scrollController = ScrollController();
  late PeopleService peopleService;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final bool isEndScroll = (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent)
          ? true
          : false;
      if (isEndScroll) {
        peopleService.getMorePeople();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    // peopleService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('build:_PeopleListState');
    peopleService = Provider.of<PeopleService>(context);

// https://www.youtube.com/watch?v=EXJboDdIpEA

    return LayoutBuilder(builder: (contest, constrains) {
      int peopleLength = peopleService.peoples.length;
      if (peopleLength == 0) {
        return const LoadingWidget();
      }

      return RefreshIndicator(
        onRefresh: _peopleRefresh,
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: peopleService.peoples.length,
          separatorBuilder: (_, i) {
            return const Divider(color: Color(0xff828282));
          },
          itemBuilder: (_, i) {
            final bool isLastWidget = ((i + 1) == peopleLength) ? true : false;

            final CustomPeopleModel person = peopleService.peoples[i];

            if (isLastWidget) {
              return Column(
                children: [
                  _peopleList(person),
                  // PeopleListTile(person: person),
                  const Divider(color: Color(0xff828282)),
                  const LoadingWidget(),
                ],
              );
            } else {
              return _peopleList(person);

              // return PeopleListTile(person: person);
            }
            // return Container();
          },
        ),
      );
    });
  }

  Future<void> _peopleRefresh() async {
    peopleService.refreshData();
  }

  Widget _peopleList(CustomPeopleModel person) {
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: ListTile(
        title: Text(
          person.name,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: _getSubtitle(person),
        trailing: IconButton(
          iconSize: 20,
          icon: const Icon(
            FontAwesomeIcons.chevronRight,
            color: Color(0xff000000),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/detail', arguments: person);
          },
        ),
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: person);
        },
      ),
    );
  }

  Widget _getSubtitle(CustomPeopleModel person) {
    return FutureBuilder(
        future: peopleService.getPersonSubtitle(person: person),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            final String subtitle = snapshot.data!;
            return FadeInLeft(
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(
              '${snapshot.error}',
              style: MyStyles.errorTextStyle,
            );
          }
          return Container();
        });
  }
}
