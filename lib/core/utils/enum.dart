enum StatusReprint { initial, loading, failed, success }

enum StatusPrinter { initial, loading, failed, success }

enum StatusCount { CREATED, ONPROCESS, COMPLETED }

enum StatusAssetCount {
  initial,
  loading,
  loaded,
  exported,
  updated,
  created,
  failed,
}

enum StatusAssetCountDetail {
  initial,
  loading,
  failed,
  loaded,
  created,
  updated,
  deleted,
}
