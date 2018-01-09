//
//  WXKDarkSkyResponse.swift
//  WXKDarkSky
//
//  Created by Jonathan Thornton on 1/3/18.
//

import Foundation

/// The `WXKDarkSkyResponse` struct contains support for quick Swift-based encoding/decoding of responses from the Dark Sky API.
public struct WXKDarkSkyResponse : Codable {
	/// The requested point's latitude.
	public var latitude: Double
	/// The requested point's longitude.
	public var longitude: Double
	/// The requested point's timezone.
	public var timezone: String
	/// Current conditions for the requested point.
	public var currently: WXKDarkSkyDataPoint?
	/// Minute-by-minute forecast for the next hour at the requested point.
	public var minutely: WXKDarkSkyDataBlock?
	/// Hourly forecast for the next 48 hours at the requested point.
	public var hourly: WXKDarkSkyDataBlock?
	/// Daily forecast for the next week at the requested point.
	public var daily: WXKDarkSkyDataBlock?
	/// Any active alerts for the requested point.
	public var alerts: [WXKDarkSkyAlert]?
	/// Metadata about the data returned for the requested point.
	public var flags: WXKDarkSkyFlags?
}

/// The `WXKDarkSkyDataPoint` struct encapsulates information about the weather at a given time from the Dark Sky API. All properties except `time` are optional.
public struct WXKDarkSkyDataPoint : Codable {
	/// The UNIX time representing the beginning of the data point. For example, for current data points, this is the current time, and for daily data points, it's midnight. This property is required.
	public var time: Date
	/// The apparent temperature (heat index or wind chill) for the data point.
	public var apparentTemperature: Double?
	/// For daily data points, the daytime high apparent temperature.
	public var apparentTemperatureHigh: Double?
	/// For daily data points, the UNIX time at which the daytime high apparent temperature occurs.
	public var apparentTemperatureHighTime: Date?
	/// For daily data points, the overnight low apparent temperature.
	public var apparentTemperatureLow: Double?
	/// For daily data points, the UNIX time at which the overnight low apparent temperature occurs.
	public var apparentTemperatureLowTime: Date?
	/// A decimal number between 0 and 1 (inclusive) indicating the percentage of sky covered by clouds.
	public var cloudCover: Double?
	/// The dewpoint temperature in degrees Fahrenheit.
	public var dewPoint: Double?
	/// The relative humidity as a decimal number between 0 and 1 (inclusive).
	public var humidity: Double?
	/// A string with an icon name provided by Dark Sky representing the conditions for this data point.
	public var icon: String?
	/// A decimal number representing the moon phase, where `0.0` is a new moon, `0.25` is first quarter, `0.5` is a full moon, and `0.75` is last quarter.
	public var moonPhase: Double?
	/// The nearest storm's bearing in degrees, with `0` being north and progressing clockwise.
	public var nearestStormBearing: Int?
	/// The nearest storm's distance in miles.
	public var nearestStormDistance: Int?
	/// The columnar density of atmospheric ozone in Dobson units, a proxy for air quality.
	public var ozone: Double?
	/// For hourly and daily data points, the amount of snowfall accumulation expected in inches.
	public var precipAccumulation: Double?
	/// For all data points, this describes precipitation intensity as inches of **liquid water** per hour.
	public var precipIntensity: Double?
	/// For daily data points, the maximum precipitation intensity expected for the day.
	public var precipIntensityMax: Double?
	/// For daily data points, the UNIX time at which precipitation is expected to be heaviest.
	public var precipIntensityMaxTime: Date?
	/// The probability of precipitation as a decimal number between 0 and 1, inclusive.
	public var precipProbability: Double?
	/// The precipitation type, if precipitation is occurring.
	public var precipType: String?
	/// The sea-level atmospheric pressure in millibars.
	public var pressure: Double?
	/// A human-readable summary of this data points.
	public var summary: String?
	/// For daily data points, the UNIX time at which sunrise will occur.
	public var sunriseTime: Date?
	/// For daily data points, the UNIX time at which sunset will occur.
	public var sunsetTime: Date?
	/// The temperature for the data point.
	public var temperature: Double?
	/// For daily data points, the daytime high temperature.
	public var temperatureHigh: Double?
	/// For daily data points, the UNIX time representing when the daytime high temperature occurs.
	public var temperatureHighTime: Date?
	/// For daily data points, the overnight low temperature.
	public var temperatureLow: Double?
	/// For daily data points, the UNIX time representing when the overnight low temperature occurs.
	public var temperatureLowTime: Date?
	/// The UV index for the data point.
	public var uvIndex: Int?
	/// For daily data points, the UNIX time for the maximum expected UV index.
	public var uvIndexTime: Date?
	/// Visibility in miles, capped at 10 miles.
	public var visibility: Double?
	/// The wind bearing in degrees, indicating the direction the wind is coming **from**, with 0° being north and progressing clockwise.
	public var windBearing: Int?
	/// The wind gust in miles per hour.
	public var windGust: Double?
	/// For daily data points, the UNIX time for the maximum expected wind gust for the day.
	public var windGustTime: Date?
	/// The wind speed in miles per hour.
	public var windSpeed: Double?
	
	enum CodingKeys: String, CodingKey {
		case time
		case apparentTemperature
		case apparentTemperatureHigh
		case apparentTemperatureHighTime
		case apparentTemperatureLow
		case apparentTemperatureLowTime
		case cloudCover
		case dewPoint
		case humidity
		case icon
		case moonPhase
		case nearestStormBearing
		case nearestStormDistance
		case ozone
		case precipAccumulation
		case precipIntensity
		case precipIntensityMax
		case precipIntensityMaxTime
		case precipProbability
		case precipType
		case pressure
		case summary
		case sunriseTime
		case sunsetTime
		case temperature
		case temperatureHigh
		case temperatureHighTime
		case temperatureLow
		case temperatureLowTime
		case uvIndex
		case uvIndexTime
		case visibility
		case windBearing
		case windGust
		case windGustTime
		case windSpeed
	}
	
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		let decodedTime = try values.decode(Int.self, forKey: .time)
		time = Date(timeIntervalSince1970: Double(decodedTime))
		apparentTemperature = try values.decodeIfPresent(Double.self, forKey: .apparentTemperature)
		apparentTemperatureHigh = try values.decodeIfPresent(Double.self, forKey: .apparentTemperatureHigh)
		if let decodedApparentTemperatureHighTime = try values.decodeIfPresent(Int.self, forKey: .apparentTemperatureHighTime) {
			apparentTemperatureHighTime = Date(timeIntervalSince1970: Double(decodedApparentTemperatureHighTime))
		}
		apparentTemperatureLow = try values.decodeIfPresent(Double.self, forKey: .apparentTemperatureLow)
		if let decodedApparentTemperatureLowTime = try values.decodeIfPresent(Int.self, forKey: .apparentTemperatureLowTime) {
			apparentTemperatureLowTime = Date(timeIntervalSince1970: Double(decodedApparentTemperatureLowTime))
		}
		cloudCover = try values.decodeIfPresent(Double.self, forKey: .cloudCover)
		dewPoint = try values.decodeIfPresent(Double.self, forKey: .dewPoint)
		humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		moonPhase = try values.decodeIfPresent(Double.self, forKey: .moonPhase)
		nearestStormBearing = try values.decodeIfPresent(Int.self, forKey: .nearestStormBearing)
		nearestStormDistance = try values.decodeIfPresent(Int.self, forKey: .nearestStormDistance)
		ozone = try values.decodeIfPresent(Double.self, forKey: .ozone)
		precipAccumulation = try values.decodeIfPresent(Double.self, forKey: .precipAccumulation)
		precipIntensity = try values.decodeIfPresent(Double.self, forKey: .precipIntensity)
		precipIntensityMax = try values.decodeIfPresent(Double.self, forKey: .precipIntensityMax)
		if let decodedPrecipIntensityMaxTime = try values.decodeIfPresent(Int.self, forKey: .precipIntensityMaxTime) {
			precipIntensityMaxTime = Date(timeIntervalSince1970: Double(decodedPrecipIntensityMaxTime))
		}
		precipProbability = try values.decodeIfPresent(Double.self, forKey: .precipProbability)
		precipType = try values.decodeIfPresent(String.self, forKey: .precipType)
		pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		if let decodedSunriseTime = try values.decodeIfPresent(Int.self, forKey: .sunriseTime) {
			sunriseTime = Date(timeIntervalSince1970: Double(decodedSunriseTime))
		}
		if let decodedSunsetTime = try values.decodeIfPresent(Int.self, forKey: .sunsetTime) {
			sunsetTime = Date(timeIntervalSince1970: Double(decodedSunsetTime))
		}
		temperature = try values.decodeIfPresent(Double.self, forKey: .temperature)
		temperatureHigh = try values.decodeIfPresent(Double.self, forKey: .temperatureHigh)
		if let decodedTemperatureHighTime = try values.decodeIfPresent(Int.self, forKey: .temperatureHighTime) {
			temperatureHighTime = Date(timeIntervalSince1970: Double(decodedTemperatureHighTime))
		}
		temperatureLow = try values.decodeIfPresent(Double.self, forKey: .temperatureLow)
		if let decodedTemperatureLowTime = try values.decodeIfPresent(Int.self, forKey: .temperatureLowTime) {
			temperatureLowTime = Date(timeIntervalSince1970: Double(decodedTemperatureLowTime))
		}
		uvIndex = try values.decodeIfPresent(Int.self, forKey: .uvIndex)
		if let decodedUVIndexTime = try values.decodeIfPresent(Int.self, forKey: .uvIndexTime) {
			uvIndexTime = Date(timeIntervalSince1970: Double(decodedUVIndexTime))
		}
		visibility = try values.decodeIfPresent(Double.self, forKey: .visibility)
		windBearing = try values.decodeIfPresent(Int.self, forKey: .windBearing)
		windGust = try values.decodeIfPresent(Double.self, forKey: .windGust)
		if let decodedWindGustTime = try values.decodeIfPresent(Int.self, forKey: .windGustTime) {
			windGustTime = Date(timeIntervalSince1970: Double(decodedWindGustTime))
		}
		windSpeed = try values.decodeIfPresent(Double.self, forKey: .windSpeed)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		let encodableTime = time.unixTime
		try container.encode(encodableTime, forKey: .time)
		try container.encodeIfPresent(apparentTemperature, forKey: .apparentTemperature)
		try container.encodeIfPresent(apparentTemperatureHigh, forKey: .apparentTemperatureHigh)
		if let apparentTemperatureHighTime = apparentTemperatureHighTime {
			let encodableTime = apparentTemperatureHighTime.unixTime
			try container.encode(encodableTime, forKey: .apparentTemperatureHighTime)
		}
		try container.encodeIfPresent(apparentTemperatureLow, forKey: .apparentTemperatureLow)
		if let apparentTemperatureLowTime = apparentTemperatureLowTime {
			let encodableTime = apparentTemperatureLowTime.unixTime
			try container.encode(encodableTime, forKey: .apparentTemperatureLowTime)
		}
		try container.encodeIfPresent(cloudCover, forKey: .cloudCover)
		try container.encodeIfPresent(dewPoint, forKey: .dewPoint)
		try container.encodeIfPresent(humidity, forKey: .humidity)
		try container.encodeIfPresent(icon, forKey: .icon)
		try container.encodeIfPresent(moonPhase, forKey: .moonPhase)
		try container.encodeIfPresent(nearestStormBearing, forKey: .nearestStormBearing)
		try container.encodeIfPresent(nearestStormDistance, forKey: .nearestStormDistance)
		try container.encodeIfPresent(ozone, forKey: .ozone)
		try container.encodeIfPresent(precipAccumulation, forKey: .precipAccumulation)
		try container.encodeIfPresent(precipIntensity, forKey: .precipIntensity)
		try container.encodeIfPresent(precipIntensityMax, forKey: .precipIntensityMax)
		if let precipIntensityMaxTime = precipIntensityMaxTime {
			let encodableTime = precipIntensityMaxTime.unixTime
			try container.encode(encodableTime, forKey: .precipIntensityMaxTime)
		}
		try container.encodeIfPresent(precipProbability, forKey: .precipProbability)
		try container.encodeIfPresent(precipType, forKey: .precipType)
		try container.encodeIfPresent(pressure, forKey: .pressure)
		try container.encodeIfPresent(summary, forKey: .summary)
		if let sunriseTime = sunriseTime {
			let encodableTime = sunriseTime.unixTime
			try container.encode(encodableTime, forKey: .sunriseTime)
		}
		if let sunsetTime = sunsetTime {
			let encodableTime = sunsetTime.unixTime
			try container.encode(encodableTime, forKey: .sunsetTime)
		}
		try container.encodeIfPresent(temperature, forKey: .temperature)
		try container.encodeIfPresent(temperatureHigh, forKey: .temperatureHigh)
		if let temperatureHighTime = temperatureHighTime {
			let encodableTime = temperatureHighTime.unixTime
			try container.encode(encodableTime, forKey: .temperatureHighTime)
		}
		try container.encodeIfPresent(temperatureLow, forKey: .temperatureLow)
		if let temperatureLowTime = temperatureLowTime {
			let encodableTime = temperatureLowTime.unixTime
			try container.encode(encodableTime, forKey: .temperatureLowTime)
		}
		try container.encodeIfPresent(uvIndex, forKey: .uvIndex)
		if let uvIndexTime = uvIndexTime {
			let encodableTime = uvIndexTime.unixTime
			try container.encode(encodableTime, forKey: .uvIndexTime)
		}
		try container.encodeIfPresent(visibility, forKey: .visibility)
		try container.encodeIfPresent(windBearing, forKey: .windBearing)
		try container.encodeIfPresent(windGust, forKey: .windGust)
		if let windGustTime = windGustTime {
			let encodableTime = windGustTime.unixTime
			try container.encode(encodableTime, forKey: .windGustTime)
		}
		try container.encodeIfPresent(windSpeed, forKey: .windSpeed)
	}
}

/// The `WXKDarkSkyDataBlock` struct contains an array of data points for a period of time, such as hourly forecasts for the next 2 days or daily forecasts for the next week.
public struct WXKDarkSkyDataBlock : Codable {
	/// An array of data points for the data block. This is required (but could be empty).
	public var data: [WXKDarkSkyDataPoint]
	/// A string summarizing the data block.
	public var summary: String?
	/// An icon name from Dark Sky summarizing the data block.
	public var icon: String?
}

/// The `WXKDarkSkyFlags` struct contains metadata about your forecast request.
public struct WXKDarkSkyFlags : Codable {
	/// If this value is present, there was an issue getting data for the request.
	public var darkSkyUnavailable: Bool?
	/// An array of strings with identifiers for data sources used in fulfilling the request.
	///
	/// See [Dark Sky's API documentation](https://darksky.net/dev/docs/sources) for more details.
	public var sources: [String]
	/// The units supplied in the request.
	public var units: String
}

/// The `WXKDarkSkyAlert` struct contains information about a hypothetical alert in effect at the time of the forecast request.
public struct WXKDarkSkyAlert : Codable {
	/// A detailed description of the alert, usually the product text.
	public var description: String
	/// The expiration time as a UNIX time, which may possibly be undefined.
	public var expires: Int?
	/// Regions covered by the alert.
	public var regions: [String]
	/// The severity of the product.
	public var severity: String
	/// The UNIX time at which the product was issued.
	public var time: Int
	/// A title for the alert.
	public var title: String
	/// A URI for detailed information about the product.
	public var uri: String
}