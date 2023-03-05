import 'package:objectbox/objectbox.dart';
import 'package:technoart_monitoring/Models/user_ob_model.dart';

import 'grp_ob_model.dart';

@Entity()
class Task {
  int id = 0;
  String description;
  bool completed = false;

  final group = ToOne<Group>();
  final user = ToOne<UserOB>();

  Task({
    required this.description,
  });
}
