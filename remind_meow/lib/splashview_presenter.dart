abstract class SplashViewContract {
  void onLoadComplete();
}

class SplashViewPresenter {
  SplashViewContract _view;

  SplashViewPresenter(this._view);

  void load() {
    assert(_view != null);
    _view.onLoadComplete();
  }
}