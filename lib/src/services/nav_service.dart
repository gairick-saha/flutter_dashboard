part of './services.dart';

class FlutterDashboardNavService extends GetxService {
  final List<FlutterDashboardItem> navItems;
  final List<FlutterDashboardItem> navFooterItems;

  FlutterDashboardNavService({
    required this.navItems,
    required this.navFooterItems,
  });

  static FlutterDashboardNavService get to =>
      Get.find<FlutterDashboardNavService>();

  List<FlutterDashboardItem> get rawRoutes => navItems;

  List<FlutterDashboardItem> get rawFooterRoutes => navFooterItems;

  final RxList<FlutterDashboardItem> _allRoutes =
      RxList<FlutterDashboardItem>();

  RxList<FlutterDashboardItem> get finalRoutes => _allRoutes;

  final RxList<String> enabledRoutes = RxList<String>();

  void _getAllEnabledRoutes() {
    _allRoutes.addAll(navItems);
    ever(
      enabledRoutes,
      (List<String> _enabledRouteItems) {
        _allRoutes.clear();
        if (_enabledRouteItems.isNotEmpty) {
          for (var _routeItem in rawRoutes) {
            for (var _enabledItem in _enabledRouteItems) {
              if (_routeItem.title == _enabledItem) {
                if (!_allRoutes.contains(_routeItem)) {
                   _allRoutes.add(_routeItem);
                }
              }
            }
          }
        }
      },
    );
  }

  @override
  void onInit() {
    _getAllEnabledRoutes();
    super.onInit();
  }
}
