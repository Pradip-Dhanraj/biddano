const String devUrl = 'https://harshveersingh.github.io';
const String prodUrl = '';

environment appEnvironment = environment.DEV;

String get base_url {
  if (environment.DEV == appEnvironment) {
    return devUrl;
  } else {
    return prodUrl;
  }
}

enum environment {
  // ignore: constant_identifier_names
  PROD,
  // ignore: constant_identifier_names
  DEV,
}
