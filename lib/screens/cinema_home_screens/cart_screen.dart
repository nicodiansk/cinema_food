import 'package:cinema_food/modules/cart_card.dart';
import 'package:cinema_food/modules/food.dart';
import 'package:cinema_food/modules/ticket.dart';
import 'package:cinema_food/shared/page_title.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<List<CartCard>> futureFoodList;
  Future<List<Ticket>> futureTicketList;
  double totalPrice;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode;
  bool _enabled;
  String tick;
  Ticket currentTicket;
  @override
  void initState() {
    super.initState();
    totalPrice = 0;
    futureFoodList = fetchCartList();
    futureTicketList = fetchTicketList();
    autovalidateMode = AutovalidateMode.disabled;
    _enabled = false;
  }

  Future<double> updatePrice(double value, bool isAdd) async {
    if (isAdd) {
      totalPrice += value;
    } else {
      totalPrice -= value;
    }
    return totalPrice;
  }

  void removeFullProduct(int productId) async {
    String token;
    //HttpHeaders.authorizationHeader: token
    //"Authorization": 'Bearer $token'
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var idToken = await user.getIdToken();
    token = idToken.token;
    print(token);
    final response = await http.post(
        'http://159.203.88.177/api/cart/removeallproduct',
        headers: {'Authorization': 'Bearer $token'},
        body: {'productId': '$productId'});
    if (response.statusCode == 200) {
      print('Prodotto $productId rimosso');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load album');
    }
  }

  void sendOrder(int ticketId) async {
    String token;
    //HttpHeaders.authorizationHeader: token
    //"Authorization": 'Bearer $token'
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var idToken = await user.getIdToken();
    token = idToken.token;
    print(token);
    final response = await http.post(
        'http://159.203.88.177/api/order/placeorder',
        headers: {'Authorization': 'Bearer $token'},
        body: {'ticket_id': '$ticketId'});
    if (response.statusCode == 200) {
      print('Ordine $ticketId inviato');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Invio ordine fallito');
    }
  }

  switchAutoValidate(bool enabled) {
    if (enabled == false) {
      autovalidateMode = AutovalidateMode.always;
      _enabled = true;
    } else {
      autovalidateMode = AutovalidateMode.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          autovalidateMode: autovalidateMode,
          key: _formKey,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: PageTitle(
                      title: 'Il tuo carrello',
                    ),
                  ),
                  FutureBuilder<List<Ticket>>(
                    future: futureTicketList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Ticket> ticketList = snapshot.data;

                        return SizedBox(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: cardBoxDecoration,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Container(
                                    width: 300,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: Colors.purple[100],
                                        hint: Text(
                                          'Seleziona un biglietto',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        value: tick,
                                        elevation: 16,
                                        isDense: true,
                                        style: TextStyle(color: Colors.black),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            tick = newValue;
                                          });
                                          for (var film in ticketList) {
                                            if (film.filmId == tick) {
                                              currentTicket = film;
                                            }
                                          }
                                        },
                                        validator: (value) => value == null
                                            ? 'field required'
                                            : null,
                                        items: snapshot.data.map((ticket) {
                                          return DropdownMenuItem<String>(
                                            child: Text(
                                                '${ticket.filmId}\n${ticket.showTime}'),
                                            value: ticket.filmId,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<List<CartCard>>(
                    future: futureFoodList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<CartCard> foods = snapshot.data;
                        if (snapshot.data.length == 0) {
                          return Expanded(
                            child: Center(
                              heightFactor: 15,
                              widthFactor: 10,
                              child: Text(
                                'Il tuo carrello è vuoto 😣',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          );
                        }

                        return Expanded(
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: foods.length,
                              itemBuilder: (context, index) {
                                CartCard fc = foods[index];
                                return Dismissible(
                                    key: Key(fc.title),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      //reducePrice(fc.price);
                                      setState(() {
                                        double currentPrice =
                                            fc.price * fc.quantity;
                                        updatePrice(currentPrice, false);
                                        foods.removeAt(index);
                                        removeFullProduct(fc.productId);
                                      });
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              "${fc.title} x ${fc.quantity} rimosso dal carrello!")));
                                    },
                                    background: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFE6E6),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          Icon(Icons.remove_shopping_cart),
                                        ],
                                      ),
                                    ),
                                    child: fc);
                              },
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Expanded(
                            child: Center(
                                child: Text("Errore: ${snapshot.error}")));
                      } else {
                        return Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ],
              ),
              FutureBuilder(
                  future: futureFoodList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      List<CartCard> myList = snapshot.data;
                      totalPrice = 0;
                      for (var value in myList) {
                        double currentPrice = value.price * value.quantity;
                        updatePrice(currentPrice, true);
                      }
                      return SizedBox(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: cardBoxDecoration,
                              child: Material(
                                  child: new InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                splashColor: Colors.lightBlue[100],
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    sendOrder(currentTicket.ticketId);
                                    Navigator.pushNamed(
                                        context, '/refreshcart');
                                  } else {
                                    setState(() {
                                      switchAutoValidate(_enabled);
                                    });
                                  }
                                  // TODO: sendOrder
                                },
                                child: new Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Text('Fai tap qui per ordinare!'),
                                        SizedBox(width: 50),
                                        Text('Totale: $totalPrice €')
                                      ],
                                    )),
                              ))));
                    }
                  }),
              /*SizedBox(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: cardBoxDecoration,
                child: Material(
                  child: new InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    splashColor: Colors.lightBlue[100],
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        //form is valid, proceed further
                        print(
                            'valido'); //save once fields are valid, onSaved method invoked for every form fields

                      } else {
                        setState(() {
                          switchAutoValidate(
                              _enabled); //enable realtime validation
                        });
                      }
                      // TODO: sendOrder
                    },
                    child: new Container(
                      padding: EdgeInsets.all(10),
                      child: FutureBuilder(
                        future: futureFoodList,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            List<CartCard> myList = snapshot.data;
                            totalPrice = 0;
                            for (var value in myList) {
                              double currentPrice =
                                  value.price * value.quantity;
                              updatePrice(currentPrice, true);
                            }
                            return Row(
                              children: [
                                Text('Fai tap qui per ordinare!'),
                                SizedBox(width: 50),
                                Text('Totale: $totalPrice €')
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
              ))*/
            ],
          ),
        ),
      ),
    );
  }
}

/*SizedBox(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: cardBoxDecoration,
                child: Material(
                  child: new InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    splashColor: Colors.lightBlue[100],
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        //form is valid, proceed further
                        print(
                            'valido'); //save once fields are valid, onSaved method invoked for every form fields

                      } else {
                        setState(() {
                          switchAutoValidate(
                              _enabled); //enable realtime validation
                        });
                      }
                      // TODO: sendOrder
                    },
                    child: new Container(
                      padding: EdgeInsets.all(10),
                      child: FutureBuilder(
                        future: futureFoodList,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            List<CartCard> myList = snapshot.data;
                            totalPrice = 0;
                            for (var value in myList) {
                              double currentPrice =
                                  value.price * value.quantity;
                              updatePrice(currentPrice, true);
                            }
                            return Row(
                              children: [
                                Text('Fai tap qui per ordinare!'),
                                SizedBox(width: 50),
                                Text('Totale: $totalPrice €')
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
              ))
*/
