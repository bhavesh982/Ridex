import 'package:firebase_database/firebase_database.dart';

import 'dart:ui';

bool empty=true;
String ownerUID="";
String username="";
var userReffed;
List mapItems=[];
String spaceLineName="";//SpaceShip Companies
String spaceShipName="";//Space Ship Details
int indexLocTapped=0;//planets index
int spaceIndexLocTapped=0;//spaceship company index
int spaceShipSelected=0;//selected space ship index
Future<String> downloadRef="" as Future<String>;
const double fontSc=18;
const double fontTitle=22;


String useruid="";

//Current planet
String currentPlanetDetails="";
String currentPlanetImage="";
String currentPlanetName="";//current location
int currentPlanetx=0;
int currentPlanety=0;

// SPACESHIP VARS
int requestNo=0;
String userLoc="";
String userDest="";
String spaceShipImage="";
int spaceShipLevel=0;
int spaceShipSeat=0;
int spaceShipThrust=0;
String spaceShipType="";
int spaceShipBase =0;
int spaceShipRate =0;

//Destination Planet Vars
String destinationPlanetName="";//Destination Planet
int destinationPlanetx=0;
int destinationPlanety=0;
String destinationPlanetImage="";
String destinationPlanetDetails="";


//UI Theme
Color mainTheme=const Color(0xff103232);
Color buttonTheme =const Color(0xff0A7F7F);

//user Auth

int generatedOtp=0;
int indexOfSeatSelected=-1;
String ridestatus="";
