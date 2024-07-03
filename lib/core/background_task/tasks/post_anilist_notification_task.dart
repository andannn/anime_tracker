import 'package:aniflow/core/background_task/task.dart';
import 'package:aniflow/core/background_task/task_manager.dart';
import 'package:workmanager/workmanager.dart';

class PostAnilistNotificationTask extends PeriodicBackgroundTask {
  const PostAnilistNotificationTask()
      : super(
          frequency: const Duration(hours: 1),
        );

  @override
  Constraints? get constraints =>
      Constraints(networkType: NetworkType.connected);

  @override
  Duration get initialDelay => const Duration(seconds: 10);

  @override
  String get name => BackgroundTaskName.sendNotificationTaskName;
}
