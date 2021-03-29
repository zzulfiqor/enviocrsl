

class ScannedData {
  String no;
  String nama;
  String ekspedisi;
  int isSubmitted;

  ScannedData({this.no, this.nama, this.ekspedisi, this.isSubmitted});

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'nama': nama,
      'ekspedisi': ekspedisi,
      'isSubmitted': isSubmitted,
    };
  }

  @override
  String toString() {
    return 'ScannedData{no: $no, nama: $nama, ekspedisi: $ekspedisi, isSubmitted: $isSubmitted}';
  }
}
