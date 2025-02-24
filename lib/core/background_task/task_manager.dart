import 'dart:async';

import 'package:aniflow/app/di/env.dart';
import 'package:aniflow/core/background_task/task.dart';
import 'package:aniflow/core/common/util/logger.dart';
import 'package:aniflow/core/data/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:workmanager/workmanager.dart';

const _tag = 'BackgroundTaskManager';

mixin BackgroundTaskName {
  static const sendNotificationTaskName = 'post_platform_notifications_task_2';
  static const syncNewReleasedPlaySourceTaskName =
      'sync_new_released_play_source_task';
}

@Singleton(env: [AfEnvironment.mobile])
class BackgroundTaskManager {
  BackgroundTaskManager(this._authRepository, this._workManager) {
    _authRepository.getAuthedUserStream().distinct().listen((userOrNull) {
      if (userOrNull == null) {
        _cancelTasks(BackgroundTask.allTasks);
      } else {
        _registerBackgroundTasks(BackgroundTask.allTasks);
      }
    });
  }

  final AuthRepository _authRepository;
  final Workmanager _workManager;

  Future _registerBackgroundTasks(List<BackgroundTask> tasks) async {
    logger.d('$_tag tasks is registered $tasks');
    final register = tasks.map((task) {
      switch (task) {
        case PeriodicBackgroundTask(
            name: final name,
            frequency: final freq,
            existingWorkPolicy: final existingWorkPolicy,
            initialDelay: final initialDelay,
            constraints: final constraints,
            inputData: final inputData,
          ):
          return _workManager.registerPeriodicTask(
            name,
            name,
            inputData: inputData,
            initialDelay: initialDelay,
            frequency: freq,
            existingWorkPolicy: existingWorkPolicy,
            constraints: constraints,
          );
      }
    });
    await Future.wait(register);
  }

  Future _cancelTasks(List<BackgroundTask> tasks) async {
    logger.d('$_tag tasks is canceled $tasks');
    final cancelTasks =
        tasks.map((task) => _workManager.cancelByTag(task.name));
    await Future.wait(cancelTasks);
  }
}
