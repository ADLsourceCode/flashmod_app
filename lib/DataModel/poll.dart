/// _id : "629cdf792494abfa04461a5b"
/// creatorName : ["SuperWeirdo"]
/// questionText : ["What was the worst thing that happened in India in 2020"]
/// options : [{"id":"187fa28f-c328-4981-88c5-7a0d719551f5","text":["TikTok & PUBG Ban"],"count":2},{"id":"7302f4fa-af3e-4029-a418-3a8b543a68ed","text":["Passing away of celebrities"],"count":1},{"id":"24e11a67-2c61-4242-91a5-68fa43a0c91c","text":["COVID-19 Pandemic"]}]
/// totalVotes : 9

class Poll {
  Poll({
      String? id, 
      List<String>? creatorName, 
      List<String>? questionText, 
      List<Options>? options, 
      int? totalVotes,bool? isAnswered}){
    _id = id;
    _creatorName = creatorName;
    _questionText = questionText;
    _options = options;
    _totalVotes = totalVotes;
    _isAnswered = isAnswered;
}

  Poll.fromJson(dynamic json) {
    _id = json['_id'];
    _isAnswered = false;
    _creatorName = json['creatorName'] != null ? json['creatorName'].cast<String>() : [];
    _questionText = json['questionText'] != null ? json['questionText'].cast<String>() : [];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
    _totalVotes = json['totalVotes']??0;
  }
  String? _id;
  List<String>? _creatorName;
  List<String>? _questionText;
  List<Options>? _options;
  int? _totalVotes;
  bool? _isAnswered;

  String? get id => _id;
  List<String>? get creatorName => _creatorName;
  List<String>? get questionText => _questionText;
  List<Options>? get options => _options;
  int? get totalVotes => _totalVotes;
  bool? get isAnswered => _isAnswered;
  set isAnswered(bool? value) {
    isAnswered = value;
  }

  set totalVotes(int? val) {
    _totalVotes = _totalVotes! + 1;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['creatorName'] = _creatorName;
    map['questionText'] = _questionText;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    map['totalVotes'] = _totalVotes;
    return map;
  }

}

/// id : "187fa28f-c328-4981-88c5-7a0d719551f5"
/// text : ["TikTok & PUBG Ban"]
/// count : 2

class Options {
  Options({
      String? id, 
      List<String>? text, 
      int? count,}){
    _id = id;
    _text = text;
    _count = count;
}

  Options.fromJson(dynamic json) {
    _id = json['id'];
    _text = json['text'] != null ? json['text'].cast<String>() : [];
    _count = json['count']??0;
  }
  String? _id;
  List<String>? _text;
  int? _count;

  String? get id => _id;
  List<String>? get text => _text;
  int? get count => _count;
  set count(int? val) {
    _count = _count! + 1;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['text'] = _text;
    map['count'] = _count;
    return map;
  }

}