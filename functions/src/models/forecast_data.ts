/**
 * 翻訳フィールドを持つデータ型。都市名と天気説明の翻訳を含む。
 */
export interface TranslationFields {
    /**
     * 都市名の翻訳（言語コード → 翻訳文字列のマップ）
     * 例: { "ja": "東京", "en": "Tokyo" }
     */
    city_translations?: Record<string, string>;

    /**
     * 天気説明の翻訳（言語コード → 翻訳文字列のマップ）
     * 例: { "ja": "晴れ", "en": "Sunny" }
     */
    description_translations?: Record<string, string>;
}

/**
   * 天気データを表すデータ構造。
   * 現在または予報の天気情報と、翻訳済みの都市名・説明を含む。
   */
export interface ForecastData extends TranslationFields {
    /**
     * 都市名（翻訳前の原文）
     */
    city: string;

    /**
     * 天気の説明（翻訳前の原文）
     */
    description: string;

    /**
     * 湿度（パーセンテージ）
     */
    humidity: number;

    /**
     * 現在の気温（摂氏）
     */
    temperature: number;

    /**
     * 最低気温（任意、摂氏）
     */
    minTemp?: number;

    /**
     * 最高気温（任意、摂氏）
     */
    maxTemp?: number;

    /**
     * 風速（m/s 単位）
     */
    windSpeed: number;

    /**
     * 天気アイコン（OpenWeatherMapのアイコンIDなど）
     */
    icon: string;

    /**
     * データ取得時のUNIXタイムスタンプ（秒単位）
     */
    timestamp: number;
}
