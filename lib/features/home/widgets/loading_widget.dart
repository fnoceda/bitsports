import 'package:bitsports/features/home/services/people_service.dart';
import 'package:bitsports/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PeopleService peopleService = Provider.of<PeopleService>(context);

    print('build::peopleService.error => ' + peopleService.error);

    if (peopleService.error != '') {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(18),
        child: Text(
          peopleService.error,
          style: MyStyles.errorTextStyle,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      print('build::peopleService.error => ' + peopleService.error);
    }

    return Container(
      margin: const EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            // color: Colors.red,
            width: 50,
            height: 30,
            child: CupertinoTheme(
              data: CupertinoTheme.of(context).copyWith(
                  brightness: Brightness.light,
                  primaryColor: const Color(0xff828282)),
              child: const CupertinoActivityIndicator(),
            ),
          ),
          const SizedBox(
            // color: Colors.yellow,
            height: 30,
            child: Center(
              child: Text(
                'Loading',
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff828282),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
