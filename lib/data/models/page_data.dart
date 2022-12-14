class PageData<T> {
  String? code;
  String? message;
  int? indexMessageLast;
  List<T>? data;
  int? numNewMessage;
  PageData(
      {this.code,
        this.message,
        this.indexMessageLast,
        this.data,
        this.numNewMessage
      });
}