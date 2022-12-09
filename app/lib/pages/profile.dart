import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';
import 'package:app/pages/viewRecord.dart';

class ProfilePage extends StatefulWidget {
  final Patient patient;
  const ProfilePage(this.patient);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 24,
          title: const Text('Patient Information'),
          backgroundColor: Colors.indigo[400],
        ),
        body: SizedBox.expand(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* This container contains the upper part of profile page */
              Container(
                  height: SizeConfig.screenHeight * 0.3,
                  width: SizeConfig.screenWidth,
                  color: Colors.indigo[400],
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.patient.pfp),
                          radius: 40,
                        ),
                      ),
                      Text(widget.patient.name,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      /* Record page navigation button */
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RecordPage(widget.patient.id, true)));
                        },
                        child: const Text(
                          'View List of Records',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.indigo[500],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(5.0),
                        ),
                      ),
                    ],
                  )),
              /* End of the upper part of profile page */

              /* 
                This padding contains Patient Information 
              */
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Patient Information',
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    /* The padding below contains info */
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* The row below contains ID info */
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Icon(
                                    Icons.mail,
                                    size: 45.0,
                                    color: Colors.indigo[400],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Patient ID',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('P${widget.patient.id}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[800])),
                                  ],
                                )
                              ],
                            ),
                            /* End of ID info */
                            SizedBox(height: 20),
                            /* The row below contains role info */
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Icon(
                                    Icons.work,
                                    size: 45.0,
                                    color: Colors.indigo[400],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Role',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('${widget.patient.usertype}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[800])),
                                  ],
                                )
                              ],
                            ),
                            /* End of role info */
                            SizedBox(height: 20),
                            /* The row below contains gender info */
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Icon(
                                    Icons.person,
                                    size: 45.0,
                                    color: Colors.indigo[400],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Gender',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('${widget.patient.gender}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[800])),
                                  ],
                                )
                              ],
                            ),
                            /* End of gender info */
                            SizedBox(height: 20),
                            /* The row below contains Birthdate info */
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Icon(
                                    Icons.calendar_month,
                                    size: 45.0,
                                    color: Colors.indigo[400],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Birthdate',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('${widget.patient.birthdate}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[800])),
                                  ],
                                )
                              ],
                            ),
                            /* End of Birthdate info */
                            SizedBox(height: 20),
                            /* The row below contains Birthdate info */
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Icon(
                                    Icons.mail,
                                    size: 45.0,
                                    color: Colors.indigo[400],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('${widget.patient.email}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[800])),
                                  ],
                                )
                              ],
                            ),
                            /* End of Birthdate info */
                          ]),
                    )
                  ],
                )),
              )
            ],
          )),
        ));
  }
}
