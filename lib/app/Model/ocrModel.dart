class OcrModel {
  String? filename;
  List<PageData>? pageData;

  OcrModel({this.filename, this.pageData});

  OcrModel.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    if (json['page_data'] != null) {
      pageData = <PageData>[];
      json['page_data'].forEach((v) {
        pageData!.add(new PageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    if (this.pageData != null) {
      data['page_data'] = this.pageData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageData {
  int? page;
  Size? size;
  List<Words>? words;
  String? rawText;

  PageData({this.page, this.size, this.words, this.rawText});

  PageData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    if (json['words'] != null) {
      words = <Words>[];
      json['words'].forEach((v) {
        words!.add(new Words.fromJson(v));
      });
    }
    rawText = json['raw_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    if (this.words != null) {
      data['words'] = this.words!.map((v) => v.toJson()).toList();
    }
    data['raw_text'] = this.rawText;
    return data;
  }
}

class Size {
  Size();

  Size.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Words {
  String? text;
  int? xmin;
  int? ymin;
  int? xmax;
  int? ymax;

  Words({this.text, this.xmin, this.ymin, this.xmax, this.ymax});

  Words.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    xmin = json['xmin'];
    ymin = json['ymin'];
    xmax = json['xmax'];
    ymax = json['ymax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['xmin'] = this.xmin;
    data['ymin'] = this.ymin;
    data['xmax'] = this.xmax;
    data['ymax'] = this.ymax;
    return data;
  }
}
