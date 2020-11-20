import 'package:package_info/package_info.dart';

Future<PackageInfo> version() async {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  PackageInfo info = await PackageInfo.fromPlatform();
  _packageInfo = info;

  return _packageInfo;
}
