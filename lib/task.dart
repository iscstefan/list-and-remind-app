
import 'activity.dart';

class Task {
  String _name;
  List<Activity> activities = [];


  Task(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  String totalChecked() {
    int checkedActivities = 0;
    int total = activities.length;

    for(int i =0 ;i<activities.length; i++)
      if(activities[i].isChecked)
        checkedActivities++;

    return '$checkedActivities/$total';

  }

  void checkAll () {
    for(int i =0 ;i <activities.length;i++)
      activities[i].isChecked = true;
  }

  void uncheckAll () {
    for(int i =0 ;i <activities.length;i++)
      activities[i].isChecked = false;
  }

}
