import UIKit
import RxSwift
import RxDataSources

class DetailViewModel {
    let dataChanged: PublishSubject<Int>
    let data: PublishSubject<[DetailDataSource]>
    let newMessage: PublishSubject<String?>
    
    private let disposeBag = DisposeBag()
    private var networkProvider: NetworkProvider

    var recommendations: [RecommendationModel]?
    var order: OrderModel
    var title: Observable<String>
    
    var recommendationsViewModels: [UserCellViewModel] = []
    var reasonsViewModels: [ReasonsCellViewModel] = []

    
    init(order:OrderModel, networkProvider: NetworkProvider) {
        self.data = PublishSubject<[DetailDataSource]>()
        self.networkProvider = networkProvider
        self.order = order
        self.title = Observable.just(String(order.model! + " - " + order.plateNumber!))
        self.dataChanged = PublishSubject()
        self.newMessage = PublishSubject<String?>()
        
        self.dataChanged
            .subscribe(onNext: {index in
                self.getData(index: index)})
            .disposed(by: disposeBag)
        
        self.newMessage.asObservable()
            .subscribe(onNext: {
                if !$0!.isEmpty {
                    self.addMessage(text: $0!)}
            })
            .disposed(by: disposeBag)
        }
    
    
    func getData(index: Int) {
        switch index {
        case 1:
            let request = networkProvider.request(from: .getRecommendations(orderNumber: order.orderNumber!), [RecommendationModel].self)
            request.subscribe(
                onSuccess: {recommendations in
                    self.recommendations = recommendations.sorted(by: {first,second in first.date! < second.date!
                    })
                    self.createRecommendationsCellViewModels(recommendations: self.recommendations!)
                    self.data.onNext([DetailDataSource(detailData: .recommendations(recommendations: self.recommendations!))])
            },
                onError: {_ in})
                .disposed(by: disposeBag)
        default:
            let request = networkProvider.request(from: .getReasons(orderNumber: order.orderNumber!), [ReasonModel].self)
            request.subscribe(
                onSuccess: {reasons in
                    self.createReasonsCellViewModels(reasons: reasons)
                    self.data.onNext([DetailDataSource(detailData: .reasons(reasons: reasons))])
            },
                onError: {error in print(error.localizedDescription)})
                .disposed(by: disposeBag)
            }
    }
    
    func createReasonsCellViewModels(reasons: [ReasonModel]) {
        for reason in reasons {
            self.reasonsViewModels.append(ReasonsCellViewModel(id:reason.id! ,status: .error))
        }
    }
    
    func createRecommendationsCellViewModels(recommendations: [RecommendationModel]) {
        for _ in recommendations {
            self.recommendationsViewModels.append(UserCellViewModel(status: .complete))
        }
    }
    
    func changeStatus (index: Int) -> (){
        let changeStatus = self.networkProvider.request(from: .changeStatus(id: self.reasonsViewModels[index].id), Int.self)
        changeStatus.subscribe(
            onSuccess: {_ in self.dataChanged.onNext(0)
        },
            onError: {_ in})
        .disposed(by: disposeBag)

    }
    
    func addMessage(text: String) {
        self.recommendations!.append(RecommendationModel(text: text))
        self.recommendationsViewModels.append(UserCellViewModel(status: .loading))
        
        self.data.onNext([DetailDataSource(detailData: .recommendations(recommendations: self.recommendations!))])
        
        let messageRequest = self.networkProvider.request(from: .addMessage(text: text, order: self.order.orderNumber!), Int.self)
        messageRequest.subscribe(
            onSuccess: {_ in
                self.recommendationsViewModels.last?.status.onNext(.complete)
        },
            onError: {_ in self.recommendationsViewModels.last?.status.onNext(.error)})
        .disposed(by: disposeBag)
    }
}
