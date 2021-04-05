
// The MIT License (MIT)
//
// Copyright (c) 2016 Michael Ackley (ackleymi@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.


import UIKit
import Alamofire

// MARK: - StockSearchResult
struct StockSearchResult: Codable {
    let bestMatches: [BestMatch]
}

// MARK: - BestMatch
struct BestMatch: Codable {
    let symbol, name, assetType, exchange: String
  //TODO:
    let the5MarketOpen, the6MarketClose, the7Timezone, the8Currency: String
    let the9MatchScore: String

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case assetType = "3. type"
        case exchange = "4. region"
        case the5MarketOpen = "5. marketOpen"
        case the6MarketClose = "6. marketClose"
        case the7Timezone = "7. timezone"
        case the8Currency = "8. currency"
        case the9MatchScore = "9. matchScore"
    }
}


// MARK: - QuoteDetailResult
struct QuoteDetailResult: Codable {
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDaily]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
  let information, symbol, the3LastRefreshed :String
    let the5TimeZone: String
  let the4OutputSize: String?

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case the3LastRefreshed = "3. Last Refreshed"
        case the4OutputSize = "4. Output Size"
        case the5TimeZone = "5. Time Zone"
    }
}

// MARK: - TimeSeriesDaily
struct TimeSeriesDaily: Codable {
    let open, high, low, close: String
    let volume: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}


struct Stock {
    
  
  
  
  
  //TODO:
    var ask: String?
    var averageDailyVolume: String?
    var bid: String?
    var bookValue: String?
    var changeNumeric: String?
    var changePercent: String?
    var dayHigh: String?
    var dayLow: String?
    var dividendShare: String?
    var dividendYield: String?
    var ebitda: String?
    var epsEstimateCurrentYear: String?
    var epsEstimateNextQtr: String?
    var epsEstimateNextYr: String?
    var eps: String?
    var fiftydayMovingAverage: String?
    var lastTradeDate: String?
    var last: String?
    var lastTradeTime: String?
    var marketCap: String?
    var companyName: String?
    var oneYearTarget: String?
    var open: String?
    var pegRatio: String?
    var peRatio: String?
    var previousClose: String?
    var priceBook: String?
    var priceSales: String?
    var shortRatio: String?
    var stockExchange: String?
    var symbol: String?
    var twoHundreddayMovingAverage: String?
    var volume: String?
    var yearHigh: String?
    var yearLow: String?
    
    var dataFields: [[String : String]]
    
}

struct ChartPoint {
    var date: Date?
    var volume: Int
    var open: CGFloat
    var close: CGFloat
    var low: CGFloat
    var high: CGFloat
}

enum ChartTimeRange {
    case OneDay, FiveDays, TenDays, OneMonth, ThreeMonths, OneYear, FiveYears
}


let searchURL = "https://www.alphavantage.co/query"
let apikey = "G1025EJ8D78XF2RV"
class SwiftStockKit {
    
  class func fetchStocksFromSearchTerm(term: String, completion:  @escaping (_ stockInfoArray: [BestMatch]) -> Void) {
      print("=========================FetchStocksFromSearchTerm==========================================")
      
      
      AF.request(searchURL, method: .get, parameters: ["function": "SYMBOL_SEARCH", "keywords": term, "apikey": apikey]).responseDecodable(of: StockSearchResult.self) { response in
        
        if let result = response.value {
          
          DispatchQueue.main.async {
            completion(result.bestMatches)
          }
        }
      }
  }

    
//    class func fetchStockForSymbol(symbol symbol: String, completion:(stock: Stock) -> ()) {
//
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//
//            let stockURL = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22\(symbol)%22)&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json"
//
//            Alamofire.request(.GET, stockURL).responseJSON { response in
//
//                if let resultJSON = response.result.value as? [String : AnyObject]  {
//
//                    if let stockData = ((resultJSON["query"] as! [String : AnyObject])["results"] as! [String : AnyObject])["quote"] as? [String : AnyObject] {
//
//                        // lengthy creation, yeah
//                        var dataFields = [[String : String]]()
//
//                        dataFields.append(["Ask" : stockData["Ask"] as? String ?? "N/A"])
//                        dataFields.append(["Average Daily Volume" : stockData["AverageDailyVolume"] as? String ?? "N/A"])
//                        dataFields.append(["Bid" : stockData["Bid"] as? String ?? "N/A"])
//                        dataFields.append(["Book Value" : stockData["BookValue"] as? String ?? "N/A"])
//                        dataFields.append(["Change" : stockData["Change"] as? String ?? "N/A"])
//                        dataFields.append(["Percent Change" : stockData["ChangeinPercent"] as? String ?? "N/A"])
//                        dataFields.append(["Day High" : stockData["DaysHigh"] as? String ?? "N/A"])
//                        dataFields.append(["Day Low" : stockData["DaysLow"] as? String ?? "N/A"])
//                        dataFields.append(["Div/Share" : stockData["DividendShare"] as? String ?? "N/A"])
//                        dataFields.append(["Div Yield" : stockData["DividendYield"] as? String ?? "N/A"])
//                        dataFields.append(["EBITDA" : stockData["EBITDA"] as? String ?? "N/A"])
//                        dataFields.append(["Current Yr EPS Estimate" : stockData["EPSEstimateCurrentYear"] as? String ?? "N/A"])
//                        dataFields.append(["Next Qtr EPS Estimate" : stockData["EPSEstimateNextQuarter"] as? String ?? "N/A"])
//                        dataFields.append(["Next Yr EPS Estimate" : stockData["EPSEstimateNextYear"] as? String ?? "N/A"])
//                        dataFields.append(["Earnings/Share" : stockData["EarningsShare"] as? String ?? "N/A"])
//                        dataFields.append(["50D MA" : stockData["FiftydayMovingAverage"] as? String ?? "N/A"])
//                        dataFields.append(["Last Trade Date" : stockData["LastTradeDate"] as? String ?? "N/A"])
//                        dataFields.append(["Last" : stockData["LastTradePriceOnly"] as? String ?? "N/A"])
//                        dataFields.append(["Last Trade Time" : stockData["LastTradeTime"] as? String ?? "N/A"])
//                        dataFields.append(["Market Cap" : stockData["MarketCapitalization"] as? String ?? "N/A"])
//                        dataFields.append(["Company" : stockData["Name"] as? String ?? "N/A"])
//                        dataFields.append(["One Yr Target" : stockData["OneyrTargetPrice"] as? String ?? "N/A"])
//                        dataFields.append(["Open" : stockData["Open"] as? String ?? "N/A"])
//                        dataFields.append(["PEG Ratio" : stockData["PEGRatio"] as? String ?? "N/A"])
//                        dataFields.append(["PE Ratio" : stockData["PERatio"] as? String ?? "N/A"])
//                        dataFields.append(["Previous Close" : stockData["PreviousClose"] as? String ?? "N/A"])
//                        dataFields.append(["Price-Book" : stockData["PriceBook"] as? String ?? "N/A"])
//                        dataFields.append(["Price-Sales" : stockData["PriceSales"] as? String ?? "N/A"])
//                        dataFields.append(["Short Ratio" : stockData["ShortRatio"] as? String ?? "N/A"])
//                        dataFields.append(["Stock Exchange" : stockData["StockExchange"] as? String ?? "N/A"])
//                        dataFields.append(["Symbol" : stockData["Symbol"] as? String ?? "N/A"])
//                        dataFields.append(["200D MA" : stockData["TwoHundreddayMovingAverage"] as? String ?? "N/A"])
//                        dataFields.append(["Volume" : stockData["Volume"] as? String ?? "N/A"])
//                        dataFields.append(["52w High" : stockData["YearHigh"] as? String ?? "N/A"])
//                        dataFields.append(["52w Low" : stockData["YearLow"] as? String ?? "N/A"])
//
//                        let stock = Stock(
//                            ask: dataFields[0].values.first,
//                            averageDailyVolume: dataFields[1].values.first,
//                            bid: dataFields[2].values.first,
//                            bookValue: dataFields[3].values.first,
//                            changeNumeric: dataFields[4].values.first,
//                            changePercent: dataFields[5].values.first,
//                            dayHigh: dataFields[6].values.first,
//                            dayLow: dataFields[7].values.first,
//                            dividendShare: dataFields[8].values.first,
//                            dividendYield: dataFields[9].values.first,
//                            ebitda: dataFields[10].values.first,
//                            epsEstimateCurrentYear: dataFields[11].values.first,
//                            epsEstimateNextQtr: dataFields[12].values.first,
//                            epsEstimateNextYr: dataFields[13].values.first,
//                            eps: dataFields[14].values.first,
//                            fiftydayMovingAverage: dataFields[15].values.first,
//                            lastTradeDate: dataFields[16].values.first,
//                            last: dataFields[17].values.first,
//                            lastTradeTime: dataFields[18].values.first,
//                            marketCap: dataFields[19].values.first,
//                            companyName: dataFields[20].values.first,
//                            oneYearTarget: dataFields[21].values.first,
//                            open: dataFields[22].values.first,
//                            pegRatio: dataFields[23].values.first,
//                            peRatio: dataFields[24].values.first,
//                            previousClose: dataFields[25].values.first,
//                            priceBook: dataFields[26].values.first,
//                            priceSales: dataFields[27].values.first,
//                            shortRatio: dataFields[28].values.first,
//                            stockExchange: dataFields[29].values.first,
//                            symbol: dataFields[30].values.first,
//                            twoHundreddayMovingAverage: dataFields[31].values.first,
//                            volume: dataFields[32].values.first,
//                            yearHigh: dataFields[33].values.first,
//                            yearLow: dataFields[34].values.first,
//                            dataFields: dataFields
//                        )
//                        dispatch_async(dispatch_get_main_queue()) {
//                            completion(stock: stock)
//                        }
//                    }
//                }
//            }
//        }
//    }
  class func convertStringToCGFloat(_ str: String) -> CGFloat {
    if let n = NumberFormatter().number(from: str) {
      return CGFloat(truncating: n)
    } else {
      return CGFloat.zero
    }
  }
  class func convertStringToInt(_ str: String) -> Int {
    if let n = NumberFormatter().number(from: str) {
      return Int(truncating: n)
    } else {
      return 0
    }
  }
  
  class func fetchChartPoints(symbol: String, range: ChartTimeRange,  completion:@escaping( _ chartPoints: [ChartPoint]) -> ()) {
    
    //An Alamofire regular responseJSON wont parse the JSONP with a callback wrapper correctly, so lets work around that.
    let chartURL = SwiftStockKit.chartUrlForRange(symbol: symbol, range: range)
    
    AF.request(chartURL, method: .get).responseDecodable(of: QuoteDetailResult.self) { response in
      var chartPoints = [ChartPoint]()
      if let Series = response.value?.timeSeriesDaily {
        for s in Series {
          let value = s.value

          let newPoint: ChartPoint = ChartPoint(date: nil, volume: convertStringToInt(value.volume), open: convertStringToCGFloat(value.open), close: convertStringToCGFloat(value.close), low: convertStringToCGFloat(value.low), high: convertStringToCGFloat(value.high))
          
          chartPoints.append(newPoint)
      
      }
      }
      DispatchQueue.main.async {
        completion(chartPoints)
      }
    }
  }
    
class func chartUrlForRange(symbol: String, range: ChartTimeRange) -> String {
    
        var timeString = String()
        
        switch (range) {
        case .OneDay:
            timeString = "TIME_SERIES_DAILY"
        case .FiveDays:
            timeString = "TIME_SERIES_WEEKLY"
        case .TenDays:
            timeString = "TIME_SERIES_WEEKLY"
        case .OneMonth:
            timeString = "TIME_SERIES_MONTHLY"
        case .ThreeMonths:
            timeString = "TIME_SERIES_WEEKLY"
        case .OneYear:
            timeString = "TIME_SERIES_WEEKLY"
        case .FiveYears:
            timeString = "TIME_SERIES_WEEKLY"
        }
        
        return "https://www.alphavantage.co/query?function=\(timeString)&symbol=\(symbol)&apikey=G1025EJ8D78XF2RV"
    }

}


















