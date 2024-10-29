import 'package:appwrite/models.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/containers/format_datetime.dart';
import 'package:event_management_app/database.dart';
import 'package:event_management_app/saved_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  final Document data;
  const EventDetails({super.key, required this.data});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool isRSVPedEvent = false;
  String id = "";

  bool? isUserPresent(List<dynamic> participants, String userId) {
    return participants.contains(userId);
  }

  @override
  void initState() {
    id = SavedData.getUserId();
    isRSVPedEvent = isUserPresent(widget.data.data["participants"], id)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 300,
              width: double.infinity,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.darken),
                child: Image.network(
                  "https://cloud.appwrite.io/v1/storage/buckets/671d47e1003a59c0224d/files/671d5ac5000a2f1ddc18/view?project=671d2814003e482dc9f3&project=671d2814003e482dc9f3&mode=admin",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 25,
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.white,
                  )),
            ),
            Positioned(
              bottom: 45,
              left: 8,
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${formatDate(widget.data.data["datetime"])}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Icon(
                    Icons.access_time_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${formatTime(widget.data.data["datetime"])}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 8,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${widget.data.data["location"]}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.data["name"],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Icon(Icons.share)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.data.data["description"],
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.data.data["participants"].length} people are attending.",
                  style: TextStyle(
                      color: kLightGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Special Guests ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.data.data["guests"] == "" ? "None" : widget.data.data["guests"]}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Sponsers ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.data.data["sponsers"] == "" ? "None" : widget.data.data["sponsers"]}",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "More Info ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Event Type : ${widget.data.data["isInPerson"] == true ? "In Person" : "Virtual"}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Time : ${formatTime(widget.data.data["datetime"])}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Location : ${widget.data.data["location"]}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      _launchUrl(
                          "https://www.google.com/maps/search/?api=1&query=${widget.data.data["location"]}");
                    },
                    icon: const Icon(Icons.map),
                    label: const Text("Open in Google Maps")),
                SizedBox(
                  height: 8,
                ),
                isRSVPedEvent
                    ? SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: MaterialButton(
                          color: kLightGreen,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("You are attending this event.")));
                          },
                          child: Text(
                            "Attending Event",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 20),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: MaterialButton(
                          color: kLightGreen,
                          onPressed: () {
                            rsvpEvent(widget.data.data["participants"],
                                    widget.data.$id)
                                .then((value) {
                              if (value) {
                                setState(() {
                                  isRSVPedEvent = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("RSVP Successful !!!")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Something went worng. Try Agian.")));
                              }
                            });
                          },
                          child: Text(
                            "RSVP Event",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 20),
                          ),
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}
