import 'package:appfox_test/features/feature/core/platform/network_information.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInformationImpl extends NetworkInformation {
  final InternetConnectionChecker checker;
  NetworkInformationImpl({required this.checker});

  @override
  Future<bool> get isConnected async => await checker.hasConnection;
}
