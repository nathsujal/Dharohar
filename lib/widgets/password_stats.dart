import 'package:flutter/material.dart';

Container passwordStats(Map<String, bool> passwordHas) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password must include:",
          style: TextStyle(
            fontFamily: 'Monsterrat',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                eachPasswordStat('length', passwordHas),
                eachPasswordStat('upperCase', passwordHas),
                eachPasswordStat('lowerCase', passwordHas),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                eachPasswordStat('number', passwordHas),
                eachPasswordStat('character', passwordHas),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Row eachPasswordStat(String statName, Map<String, bool> passwordHas) {
  return Row(
    children: [
      iconPasswordStats(passwordHas[statName] ?? false),
      const SizedBox(width: 5),
      Text(
        textToBeDisplayed(statName),
        style: TextStyle(
          color: (passwordHas[statName] ?? false) ? Colors.green : Colors.red,
          fontFamily: 'Monsterrat',
          fontSize: 12,
        ),
      ),
    ],
  );
}

String textToBeDisplayed(String statName) {
  if (statName == 'length') {
    return "6 characters";
  } else if (statName == 'uppercase') {
    return "Uppercase";
  } else if (statName == 'lowercase') {
    return "Lowercase";
  } else if (statName == 'number') {
    return "Number";
  }
  return "Special character";
}

Icon iconPasswordStats(bool exists) {
  if (exists) {
    return const Icon(
      Icons.check_box,
      color: Colors.green,
      size: 14,
    );
  }
  return const Icon(
    Icons.check_box_outline_blank,
    color: Colors.red,
    size: 14,
  );
}
