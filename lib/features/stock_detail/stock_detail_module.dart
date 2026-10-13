import 'package:agentfolio/features/learn/presentation/view_models/learn_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:get_it/get_it.dart';

/// Screens over the research domain: Stock Detail (per symbol) and Learn.
void registerStockDetailFeature(GetIt sl) {
  sl
    ..registerFactoryParam<StockDetailViewModel, String, void>(
      (symbol, _) =>
          StockDetailViewModel(symbol: symbol, research: sl(), portfolio: sl(), telemetry: sl()),
    )
    ..registerFactory(() => LearnViewModel(research: sl(), telemetry: sl()));
}
