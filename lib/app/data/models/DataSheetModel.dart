class DataSheetModel {
  int no;
  String nama;
  String ekspedisi;

  DataSheetModel({this.no, this.nama, this.ekspedisi});

  DataSheetModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    nama = json['nama'];
    ekspedisi = json['ekspedisi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['nama'] = this.nama;
    data['ekspedisi'] = this.ekspedisi;
    return data;
  }
}