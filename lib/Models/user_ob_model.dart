import 'package:objectbox/objectbox.dart';
import 'package:technoart_monitoring/Models/task_ob_model.dart';

@Entity()
class UserOB {
  int id = 0;
  String name;

  @Backlink()
  final tasks = ToMany<Task>();

  UserOB({
    required this.name,
  });
}
