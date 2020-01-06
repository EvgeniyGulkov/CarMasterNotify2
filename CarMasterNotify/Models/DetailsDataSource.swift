import Foundation
import RxSwift
import RxDataSources

enum DetailDatasourceType {
    case reasons (reasons: [ReasonModel])
    case recommendations (recommendations: [RecommendationModel])
}

struct DetailDataSource {

    var items: [Item]
    var datasourceType: DetailDatasourceType
}
extension DetailDataSource: SectionModelType {
      typealias Item = Detail
    
    init(original: DetailDataSource, items: [Detail]) {
        self = original
        self.items = items
    }

   init(detailData: DetailDatasourceType) {
    self.datasourceType = detailData
    switch detailData {
    case let .reasons(reasons: reasons):
        self.items = reasons
    case let .recommendations(recommendations: recommendations):
        self.items = recommendations
    }
  }
}
