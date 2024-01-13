import 'package:flutter_svg/svg.dart';
import 'package:ibnziad/export.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});
  static const route = '/contact-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.green, Colors.greenAccent])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Hero(
                    tag: 'contact',
                    child: SvgPicture.asset('assets/svgs/contact.svg')),
                Text(
                  'تواصل معنا',
                  style: TextStyle(fontSize: 30),
                ),
                Divider(
                  color: Colors.white,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      var url = Uri(scheme: 'tel', path: '0991961111');
                      await launchUrl(url);
                    },
                    child: Text(
                      'اتصل بنا',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      final availableMaps = await MapLauncher.installedMaps;
                      print(
                          availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                      await availableMaps.first.showMarker(
                        coords: Coords(37.759392, -122.5107336),
                        title: "Ocean Beach",
                      );
                    },
                    child: Text(
                      ' راسلنا علي البريد  ',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
