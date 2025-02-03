/// アプリの実行環境を表すenum
enum Flavor {
  dev,
  stg,
  prod;

  /// dart-defineからFLAVORを取得し、Flavorを決定する
  static Flavor get fromEnvironment {
    const value = String.fromEnvironment('FLAVOR');

    try {
      return Flavor.values.byName(value);
    } catch (_) {
      return Flavor.dev; // デフォルトをdevにする
    }
  }

  /// 開発環境かどうか
  bool get isDev => this == Flavor.dev;

  /// ステージング環境かどうか
  bool get isStg => this == Flavor.stg;

  /// 本番環境かどうか
  bool get isProd => this == Flavor.prod;
}

/// グローバルでFlavorを取得する
final Flavor flavor = Flavor.fromEnvironment;
