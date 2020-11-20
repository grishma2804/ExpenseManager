
enum Environment { DEV, STAGING, PROD }

class AppConstants {
  static String placeholder = "https://via.placeholder.com/800x400?text=No+Image";
  static double screenWidth = 375;
  static double screenHeight = 812;

  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.qaConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get baseURLVersion {
    return _config[_Config.BASE_URL] + "v1/";
  }
  static get baseURL {
    return _config[_Config.BASE_URL];
  }

  static get publicKey {
    return _config[_Config.PAYSTACK_PUBLIC_KEY];
  }
  static get envName {
    return _config[_Config.ENV_NAME];
  }
}

class _Config {
  static const BASE_URL = "BASE_URL";
  static const PAYSTACK_PUBLIC_KEY = "PAYSTACK_PUBLIC_KEY";
  static const ENV_NAME = "ENV_NAME";

  static Map<String, dynamic> debugConstants = {
    BASE_URL: "https://dev.getsash.com/",
    PAYSTACK_PUBLIC_KEY:  "pk_test_31b3f00693d3ae1ae5adfdf5e27cc3ccae3b3523",
    ENV_NAME: "dev"
  };

  static Map<String, dynamic> qaConstants = {
    BASE_URL: "https://stg.getsash.com/",
    PAYSTACK_PUBLIC_KEY:  "pk_test_3c4df4ca5563730b0aa2fabfe2c3d5e4cb538a62",
    ENV_NAME: "staging"
  };

  static Map<String, dynamic> prodConstants = {
    BASE_URL: "https://api.getsash.com/",
    PAYSTACK_PUBLIC_KEY:  "pk_live_521cfe36097644ccb731b164d48e10d4e344f2b0",
    ENV_NAME: ""
  };
}