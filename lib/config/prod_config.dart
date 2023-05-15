import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get host => 'productionapi.host';
  @override
  String get environment => 'Production';
}
