class FAQModel {
  bool? status;
  Null? message;
  Data? data;

  FAQModel({this.status, this.message, this.data});

  FAQModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<FAQItem>? data;


  Data(
      {this.currentPage,
        this.data,
       });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FAQItem>[];
      json['data'].forEach((value) {
        data!.add(new FAQItem.fromJson(value));
      });
    }
  }

}

class FAQItem {
  int? id;
  String? question;
  String? answer;

  FAQItem({this.id, this.question, this.answer});

  FAQItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

}
