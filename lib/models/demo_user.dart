import 'package:flutter/material.dart';

@immutable
class DemoUser{
  final String id;
  final String name;
  final String image;

  const DemoUser({required this.id, required this.name, required this.image});


}

const users = [
  userLoc,
  userKiet,
];

const userLoc = DemoUser(id: 'loc', name: 'Vo Tran Tan Loc', image: 'https://scontent.fsgn2-7.fna.fbcdn.net/v/t39.30808-6/434026140_378754348371877_1469988307814121208_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_ohc=O-3AXuAhGkwAX80OxSG&_nc_ht=scontent.fsgn2-7.fna&oh=00_AfDjIIa0i9WKitz2_DQx-OQCSmv6Y9VxU-6rIdSKa9f-jA&oe=660061C2');
const userKiet = DemoUser(id: 'kiet', name: 'Nguyen Anh Kiet', image: 'https://scontent.fsgn2-3.fna.fbcdn.net/v/t39.30808-6/434060400_979768683513194_9094907417999270972_n.jpg?stp=dst-jpg_s640x640&_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_ohc=Ilcfl2nEncgAX9FraeY&_nc_ht=scontent.fsgn2-3.fna&oh=00_AfCUjOqXnlT9NUNKUP3s70IzwafnyA-4eWdX6VpaZ8Lpfg&oe=66011250');