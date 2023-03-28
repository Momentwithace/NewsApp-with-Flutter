class QP{
  const QP._();

  static Map<String, String> apiQP({required String apikey, required String country}) => {
    'country' : country,
    'apiKey' : apikey
  };
}