import 'package:flutter/material.dart';

class ProfileData {
  final String title;
  final VoidCallback onPressed;

  const ProfileData({
    required this.title,
    required this.onPressed,
  });
}

final List<ProfileData> profileData = [
  ProfileData(
    title: 'Personal Data',
    onPressed: () {},
  ),
  ProfileData(
    title: 'Settings',
    onPressed: () {},
  ),
  ProfileData(
    title: 'Notifications',
    onPressed: () {},
  ),
  ProfileData(
    title: 'Languages',
    onPressed: () {},
  ),
  ProfileData(
    title: 'Privacy',
    onPressed: () {},
  ),
];
