import 'base_config.dart';

class DevConfig implements BaseConfig {
  @override
  String get host => 'developmentapi.host';

  @override
  String get environment => 'Development';
}
