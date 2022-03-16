class DigitalLibrary {
  Output? output;

  DigitalLibrary({this.output});

  DigitalLibrary.fromJson(Map<String, dynamic> json) {
    output =
    json['output'] != null ? new Output.fromJson(json['output']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.output != null) {
      data['output'] = this.output!.toJson();
    }
    return data;
  }
}

class Output {
  Result? result;

  Output({this.result});

  Output.fromJson(Map<String, dynamic> json) {
    result =
    json['Result'] != null ? new Result.fromJson(json['Result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['Result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? status;
  List<BookDet>? bookDet;

  Result({this.status, this.bookDet});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['BookDet'] != null) {
      bookDet = <BookDet>[];
      json['BookDet'].forEach((v) {
        bookDet!.add(new BookDet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.bookDet != null) {
      data['BookDet'] = this.bookDet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookDet {
  String? id;
  var contentType;
  var contentCode;
  String? name;
  String? imagePath;
  String? fileType;
  String? status;

  BookDet(
      {this.id,
        this.contentType,
        this.contentCode,
        this.name,
        this.imagePath,
        this.fileType,
        this.status});

  BookDet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['content_type'];
    contentCode = json['content_code'];
    name = json['name'];
    imagePath = json['image_path'];
    fileType = json['file_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content_type'] = this.contentType;
    data['content_code'] = this.contentCode;
    data['name'] = this.name;
    data['image_path'] = this.imagePath;
    data['file_type'] = this.fileType;
    data['status'] = this.status;
    return data;
  }
}