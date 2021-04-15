class ScannedData {
  String id;
  String no;
  String nama;
  String ekspedisi;
  int isSubmitted;
  String tanggal;

  ScannedData(
      {this.id,
      this.no,
      this.nama,
      this.ekspedisi,
      this.isSubmitted,
      this.tanggal});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'no': no,
      'nama': nama,
      'ekspedisi': ekspedisi,
      'isSubmitted': isSubmitted,
      'tanggal': tanggal,
    };
  }

  ScannedData.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        no = map['no'],
        nama = map['nama'],
        ekspedisi = map['ekspedisi'],
        isSubmitted = map['isSubmitted'],
        tanggal = map['tanggal'];

  @override
  String toString() {
    return 'ScannedData{id : $id, no: $no, nama: $nama, ekspedisi: $ekspedisi, isSubmitted: $isSubmitted, tanggal: $tanggal}';
  }
}
