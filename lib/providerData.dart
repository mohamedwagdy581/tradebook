import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderData extends ChangeNotifier {
  String sectionID = '';

  String subSectionID = '';

  String activityID = '';

  void setSectionID({
    required String val,
  }) {
    sectionID = val;
    notifyListeners();
  }

  void setSubSectionID({
    required String val,
  }) {
    subSectionID = val;
    notifyListeners();
  }

  void setActivityID({
    required String val,
  }) {
    activityID = val;
    notifyListeners();
  }
}

// Write to SectionID
setSectionID({
  required context,
  required String val,
}) {
  Provider.of<ProviderData>(context, listen: false).setSectionID(val: val);
}

// Read SectionID method
String getSectionID({
  required context,
}) {
  String sectionID =
      Provider.of<ProviderData>(context, listen: false).sectionID;
  return sectionID;
}

// Write to subSectionID
setSubSectionID({
  required context,
  required String val,
}) {
  Provider.of<ProviderData>(context, listen: false).setSubSectionID(val: val);
}

// Read SectionID method
String getSubSectionID({
  required context,
}) {
  String subSectionID =
      Provider.of<ProviderData>(context, listen: false).subSectionID;
  return subSectionID;
}

// Write to SectionID
setActivityID({
  required context,
  required String val,
}) {
  Provider.of<ProviderData>(context, listen: false).setActivityID(val: val);
}

// Read SectionID method
String getActivityID({
  required context,
}) {
  String activityID =
      Provider.of<ProviderData>(context, listen: false).activityID;
  return activityID;
}
