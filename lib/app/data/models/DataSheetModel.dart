class DataSheetModel {
  int no;
  String nama;
  String ekspedisi;
  String tanggal;

  DataSheetModel({this.no, this.nama, this.ekspedisi, this.tanggal});

  DataSheetModel.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    nama = json['nama'];
    ekspedisi = json['ekspedisi'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['nama'] = this.nama;
    data['ekspedisi'] = this.ekspedisi;
    data['tanggal'] = this.tanggal;

    return data;
  }
}
