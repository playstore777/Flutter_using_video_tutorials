class HttpException implements Exception {
  //implements is used for extending abstract classes(in abstract class we are forced to override all the available methods)
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    // return super
    //     .toString(); // default on all the objects of dart, and this returns if printed 'Instance of class_name(here HttpException)'
  }
}
