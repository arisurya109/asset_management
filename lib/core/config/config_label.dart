class ConfigLabel {
  // ignore: non_constant_identifier_names
  static AssetId(String assetId) {
    return '''
      ^XA
      ^PW530
      ^LL530
      ^MD30
      ^PS3

      // Barcode atas
      ^FO30,20
      ^BY2,3,150
      ^BCN,90,N,N,N
      ^FD$assetId^FS

      // Text di bawah barcode atas
      ^FO130,120
      ^A0N,25,25
      ^FD$assetId^FS

      // Barcode tengah
      ^FO30,200
      ^BY2,3,150
      ^BCN,90,N,N,N
      ^FD$assetId^FS

      // Text di tengah barcode tengah
      ^FO130,305
      ^A0N,25,25
      ^FD$assetId^FS

      // Barcode bawah
      ^FO30,380
      ^BY2,3,150
      ^BCN,90,N,N,N
      ^FD$assetId^FS

      // Text di bawah barcode bawah
      ^FO130,485
      ^A0N,25,25
      ^FD$assetId^FS

      ^XZ
      ''';
  }

  // ignore: non_constant_identifier_names
  static Location(String location) {
    return '''
      ^XA
      ^PW530
      ^LL530
      ^MD30
      ^PS3

      // Barcode atas
      ^FO30,20
      ^BY3,3,150
      ^BCN,450,N,N,N
      ^FD$location^FS

      // Text di bawah barcode atas
      ^FO135,490
      ^A0N,50,50
      ^FD$location^FS

      ^XZ
      ''';
  }
}
