class SeatMap {
  Seatmaps seatmaps;

  SeatMap({this.seatmaps});

  SeatMap.fromJson(Map<String, dynamic> json) {
    seatmaps = json['seatmaps'] != null?
         new Seatmaps.fromJson(json['seatmaps'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seatmaps != null) {
      data['seatmaps'] = this.seatmaps.toJson();
    }
    return data;
  }
}

class Seatmaps {
  List<Options> options;

  Seatmaps({this.options});

  Seatmaps.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int optionId;
  List<Segments> segments;

  Options({this.optionId, this.segments});

  Options.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) {
        segments.add(new Segments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this.optionId;
    if (this.segments != null) {
      data['segments'] = this.segments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Segments {
  String segmentId;
  List<Decks> decks;

  Segments({this.segmentId, this.decks});

  Segments.fromJson(Map<String, dynamic> json) {
    segmentId = json['segmentId'];
    if (json['decks'] != null) {
      decks = <Decks>[];
      json['decks'].forEach((v) {
        decks.add(new Decks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['segmentId'] = this.segmentId;
    if (this.decks != null) {
      data['decks'] = this.decks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Decks {
  String deckType;
  DeckConfiguration deckConfiguration;
  List<Facilities> facilities;
  List<Seats> seats;

  Decks({this.deckType, this.deckConfiguration, this.facilities, this.seats});

  Decks.fromJson(Map<String, dynamic> json) {
    deckType = json['deckType'];
    deckConfiguration = json['deckConfiguration'] != null?
         new DeckConfiguration.fromJson(json['deckConfiguration'])
        : null;
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities.add(new Facilities.fromJson(v));
      });
    }
    if (json['seats'] != null) {
      seats = <Seats>[];
      json['seats'].forEach((v) {
        seats.add(new Seats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deckType'] = this.deckType;
    if (this.deckConfiguration != null) {
      data['deckConfiguration'] = this.deckConfiguration.toJson();
    }
    if (this.facilities != null) {
      data['facilities'] = this.facilities.map((v) => v.toJson()).toList();
    }
    if (this.seats != null) {
      data['seats'] = this.seats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeckConfiguration {
  int width;
  int length;
  int startSeatRow;
  int endSeatRow;
  int startWingsX;
  int endWingsX;
  int startWingsRow;
  int endWingsRow;
  List<int> exitRowsX;

  DeckConfiguration(
      {this.width,
      this.length,
      this.startSeatRow,
      this.endSeatRow,
      this.startWingsX,
      this.endWingsX,
      this.startWingsRow,
      this.endWingsRow,
      this.exitRowsX});

  DeckConfiguration.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    length = json['length'];
    startSeatRow = json['startSeatRow'];
    endSeatRow = json['endSeatRow'];
    startWingsX = json['startWingsX'];
    endWingsX = json['endWingsX'];
    startWingsRow = json['startWingsRow'];
    endWingsRow = json['endWingsRow'];
    exitRowsX = json['exitRowsX'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['length'] = this.length;
    data['startSeatRow'] = this.startSeatRow;
    data['endSeatRow'] = this.endSeatRow;
    data['startWingsX'] = this.startWingsX;
    data['endWingsX'] = this.endWingsX;
    data['startWingsRow'] = this.startWingsRow;
    data['endWingsRow'] = this.endWingsRow;
    data['exitRowsX'] = this.exitRowsX;
    return data;
  }
}

class Facilities {
  String code;
  String column;
  String position;
  Coordinates coordinates;
  String row;

  Facilities(
      {this.code, this.column, this.position, this.coordinates, this.row});

  Facilities.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    column = json['column'];
    position = json['position'];
    coordinates = json['coordinates'] != null?
         new Coordinates.fromJson(json['coordinates'])
        : null;
    row = json['row'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['column'] = this.column;
    data['position'] = this.position;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    data['row'] = this.row;
    return data;
  }
}

class Coordinates {
  int x;
  int y;

  Coordinates({this.x, this.y});

  Coordinates.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class Seats {
  String cabin;
  String number;
  List<String> characteristicsCodes;
  List<TravelerPricing> travelerPricing;
  Coordinates coordinates;

  Seats(
      {this.cabin,
      this.number,
      this.characteristicsCodes,
      this.travelerPricing,
      this.coordinates});

  Seats.fromJson(Map<String, dynamic> json) {
    cabin = json['cabin'];
    number = json['number'];
    characteristicsCodes = json['characteristicsCodes'].cast<String>();
    if (json['travelerPricing'] != null) {
      travelerPricing = <TravelerPricing>[];
      json['travelerPricing'].forEach((v) {
        travelerPricing.add(new TravelerPricing.fromJson(v));
      });
    }
    coordinates = json['coordinates'] != null?
         new Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cabin'] = this.cabin;
    data['number'] = this.number;
    data['characteristicsCodes'] = this.characteristicsCodes;
    if (this.travelerPricing != null) {
      data['travelerPricing'] =
          this.travelerPricing.map((v) => v.toJson()).toList();
    }
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    return data;
  }
}

class TravelerPricing {
  String travelerId;
  String seatAvailabilityStatus;
  Price price;

  TravelerPricing({this.travelerId, this.seatAvailabilityStatus, this.price});

  TravelerPricing.fromJson(Map<String, dynamic> json) {
    travelerId = json['travelerId'];
    seatAvailabilityStatus = json['seatAvailabilityStatus'];
    price = json['price'] != null?  new Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travelerId'] = this.travelerId;
    data['seatAvailabilityStatus'] = this.seatAvailabilityStatus;
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    return data;
  }
}

class Price {
  String currency;
  String total;
  String base;
  List<Taxes> taxes;

  Price({this.currency, this.total, this.base, this.taxes});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    total = json['total'];
    base = json['base'];
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes.add(new Taxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['total'] = this.total;
    data['base'] = this.base;
    if (this.taxes != null) {
      data['taxes'] = this.taxes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Taxes {
  String amount;
  String code;

  Taxes({this.amount, this.code});

  Taxes.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['code'] = this.code;
    return data;
  }
}
class SeatMaps {
  Seatmaps seatmaps;

  SeatMaps({this.seatmaps});

  SeatMaps.fromJson(Map<String, dynamic> json) {
    seatmaps = json['seatmaps'] != null?
         new Seatmaps.fromJson(json['seatmaps'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seatmaps != null) {
      data['seatmaps'] = this.seatmaps.toJson();
    }
    return data;
  }
}

class Seatmapsq {
  List<Options> options;

  Seatmapsq({this.options});

  Seatmapsq.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionsT {
  int optionId;
  List<Segments> segments;

  OptionsT({this.optionId, this.segments});

  OptionsT.fromJson(Map<String, dynamic> json) {
    optionId = json['optionId'];
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) {
        segments.add(new Segments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this.optionId;
    if (this.segments != null) {
      data['segments'] = this.segments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SegmentsT {
  String segmentId;
  List<Decks> decks;

  SegmentsT({this.segmentId, this.decks});

  SegmentsT.fromJson(Map<String, dynamic> json) {
    segmentId = json['segmentId'];
    if (json['decks'] != null) {
      decks = <Decks>[];
      json['decks'].forEach((v) {
        decks.add(new Decks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['segmentId'] = this.segmentId;
    if (this.decks != null) {
      data['decks'] = this.decks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deckst {
  String deckType;
  DeckConfiguration deckConfiguration;
  List<Facilities> facilities;
  List<Seats> seats;

  Deckst({this.deckType, this.deckConfiguration, this.facilities, this.seats});

  Deckst.fromJson(Map<String, dynamic> json) {
    deckType = json['deckType'];
    deckConfiguration = json['deckConfiguration'] != null?
         new DeckConfiguration.fromJson(json['deckConfiguration'])
        : null;
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities.add(new Facilities.fromJson(v));
      });
    }
    if (json['seats'] != null) {
      seats = <Seats>[];
      json['seats'].forEach((v) {
        seats.add(new Seats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deckType'] = this.deckType;
    if (this.deckConfiguration != null) {
      data['deckConfiguration'] = this.deckConfiguration.toJson();
    }
    if (this.facilities != null) {
      data['facilities'] = this.facilities.map((v) => v.toJson()).toList();
    }
    if (this.seats != null) {
      data['seats'] = this.seats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeckConfigurationT {
  int width;
  int length;
  int startSeatRow;
  int endSeatRow;
  int startWingsX;
  int endWingsX;
  int startWingsRow;
  int endWingsRow;
  List<int> exitRowsX;

  DeckConfigurationT(
      {this.width,
      this.length,
      this.startSeatRow,
      this.endSeatRow,
      this.startWingsX,
      this.endWingsX,
      this.startWingsRow,
      this.endWingsRow,
      this.exitRowsX});

  DeckConfigurationT.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    length = json['length'];
    startSeatRow = json['startSeatRow'];
    endSeatRow = json['endSeatRow'];
    startWingsX = json['startWingsX'];
    endWingsX = json['endWingsX'];
    startWingsRow = json['startWingsRow'];
    endWingsRow = json['endWingsRow'];
    exitRowsX = json['exitRowsX'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['length'] = this.length;
    data['startSeatRow'] = this.startSeatRow;
    data['endSeatRow'] = this.endSeatRow;
    data['startWingsX'] = this.startWingsX;
    data['endWingsX'] = this.endWingsX;
    data['startWingsRow'] = this.startWingsRow;
    data['endWingsRow'] = this.endWingsRow;
    data['exitRowsX'] = this.exitRowsX;
    return data;
  }
}

class FacilitiesT {
  String code;
  String column;
  String position;
  Coordinates coordinates;
  String row;

  FacilitiesT(
      {this.code, this.column, this.position, this.coordinates, this.row});

  FacilitiesT.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    column = json['column'];
    position = json['position'];
    coordinates = json['coordinates'] != null?
         new Coordinates.fromJson(json['coordinates'])
        : null;
    row = json['row'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['column'] = this.column;
    data['position'] = this.position;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    data['row'] = this.row;
    return data;
  }
}

class Coordinatest {
  int x;
  int y;

  Coordinatest({this.x, this.y});

  Coordinatest.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }
}

class SeatsT {
  String cabin;
  String number;
  List<String> characteristicsCodes;
  List<TravelerPricing> travelerPricing;
  Coordinates coordinates;

  SeatsT(
      {this.cabin,
      this.number,
      this.characteristicsCodes,
      this.travelerPricing,
      this.coordinates});

  SeatsT.fromJson(Map<String, dynamic> json) {
    cabin = json['cabin'];
    number = json['number'];
    characteristicsCodes = json['characteristicsCodes'].cast<String>();
    if (json['travelerPricing'] != null) {
      travelerPricing = <TravelerPricing>[];
      json['travelerPricing'].forEach((v) {
        travelerPricing.add(new TravelerPricing.fromJson(v));
      });
    }
    coordinates = json['coordinates'] != null?
         new Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cabin'] = this.cabin;
    data['number'] = this.number;
    data['characteristicsCodes'] = this.characteristicsCodes;
    if (this.travelerPricing != null) {
      data['travelerPricing'] =
          this.travelerPricing.map((v) => v.toJson()).toList();
    }
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    return data;
  }
}

class TravelerPricingt {
  String travelerId;
  String seatAvailabilityStatus;
  Price price;

  TravelerPricingt({this.travelerId, this.seatAvailabilityStatus, this.price});

  TravelerPricingt.fromJson(Map<String, dynamic> json) {
    travelerId = json['travelerId'];
    seatAvailabilityStatus = json['seatAvailabilityStatus'];
    price = json['price'] != null  ?new Price.fromJson(json['price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travelerId'] = this.travelerId;
    data['seatAvailabilityStatus'] = this.seatAvailabilityStatus;
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    return data;
  }
}

class PriceT {
  String currency;
  String total;
  String base;
  List<Taxes> taxes;

  PriceT({this.currency, this.total, this.base, this.taxes});

  PriceT.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    total = json['total'];
    base = json['base'];
    if (json['taxes'] != null) {
      taxes = <Taxes>[];
      json['taxes'].forEach((v) {
        taxes.add(new Taxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['total'] = this.total;
    data['base'] = this.base;
    if (this.taxes != null) {
      data['taxes'] = this.taxes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Taxest {
  String amount;
  String code;

  Taxest({this.amount, this.code});

  Taxest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['code'] = this.code;
    return data;
  }
}

