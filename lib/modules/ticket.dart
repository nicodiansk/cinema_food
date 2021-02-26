import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Ticket>> fetchTicketList() async {
  List<Ticket> ticketList;
  String token;
  //HttpHeaders.authorizationHeader: token
  //"Authorization": 'Bearer $token'
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  var idToken = await user.getIdToken();
  token = idToken.token;
  print(token);
  final response = await http.get(
      'http://138.197.176.151/api/ticket/gettickets',
      headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    print('response getall' + response.body.toString());
    // If the server did return a 200 OK response,
    // then parse the JSON.
    ticketList = (json.decode(response.body) as List)
        .map((i) => Ticket.fromJson(i))
        .toList();

    return ticketList;
    //Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load album');
  }
}

class Ticket {
  final int ticketId;
  final String showTime;
  final String filmId;
  final String seat;
  final int room;

  Ticket({this.ticketId, this.showTime, this.filmId, this.seat, this.room});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      ticketId: json['Ticket_ID'],
      showTime: json['showTime'],
      filmId: json['Film_ID'],
      seat: json['seat'],
      room: json['room'],
    );
  }
}
