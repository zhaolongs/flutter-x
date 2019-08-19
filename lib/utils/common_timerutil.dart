import 'dart:async';

///timer callback.(millisUntilFinished 毫秒).
typedef void OnTimerTickCallback(int millisUntilFinished);


class CommonTimerUtil {
  CommonTimerUtil({this.mInterval = Duration.millisecondsPerSecond, this.mStartTime});

  /// Timer.
  Timer _mTimer;
  /// Is Timer active.
  /// Timer是否启动.
  bool _isActive = false;

  /// Timer interval (unit millisecond，def: 1000 millisecond).
  /// Timer间隔 单位毫秒，默认1000毫秒(1秒).
  int mInterval;

  /// countdown totalTime.
  /// 计时开始时间 单位毫秒，默认0 开始.
  int mStartTime; //单位毫秒

  OnTimerTickCallback _onTimerTickCallback;

  /// set Timer interval. (unit millisecond).
  /// 设置Timer间隔.
  void setInterval(int interval) {
    if (interval <= 0) interval = Duration.millisecondsPerSecond;
    mInterval = interval;
  }

  /// set countdown totalTime. (unit millisecond).
  /// 设置计时开始时间
  void setStartTime(int totalTime) {
    if (totalTime <= 0) return;
    mStartTime = totalTime;
  }

  /// start Timer.
  /// 启动定时Timer.
  void startTimer() {
    if (_isActive || mInterval <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(0);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      _doCallback(timer.tick);
    });
  }

  /// start countdown Timer.
  /// 启动计时器Timer.
  void startCountDown() {
    if (_isActive || mInterval <= 0 || mStartTime < 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInterval);
    _doCallback(mStartTime);
    _mTimer = Timer.periodic(duration, (Timer timer) {
      _doCallback(duration.inMilliseconds);
    });
  }

  void _doCallback(int time) {
    if (_onTimerTickCallback != null) {
      _onTimerTickCallback(time);
    }
  }

  /// update countdown totalTime.
  /// 重设开始时间.
  void updateTotalTime(int totalTime) {
    cancel();
    mStartTime = totalTime;
    startCountDown();
  }

  /// timer is Active.
  /// Timer是否启动.
  bool isActive() {
    return _isActive;
  }

  /// Cancels the timer.
  /// 取消计时器.
  void cancel() {
    if (_mTimer != null) {
      _mTimer.cancel();
      _mTimer = null;
    }
    _isActive = false;
  }

  /// set timer callback.
  void setOnTimerTickCallback(OnTimerTickCallback callback) {
    _onTimerTickCallback = callback;
  }
}
