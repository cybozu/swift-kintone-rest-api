//
//  FetchAppStatusResponse.swift
//
//
//  Created by ky0me22 on 2025/01/31.
//

struct FetchAppStatusResponse: Decodable {
    var appStatusSettings: AppStatusSettings

    init(from decoder: any Decoder) throws {
        appStatusSettings = try AppStatusSettings(from: decoder)
    }
}

/*
{
  "enable": true,
  "states": {
    "未処理": {
      "name": "未処理",
      "index": "0",
      "assignee": {
        "type": "ONE",
        "entities": []
      }
    },
    "処理中": {
      "name": "処理中",
      "index": "1",
      "assignee": {
        "type": "ALL",
        "entities": [
          {
            "entity": {
              "type": "USER",
              "code": "user1"
            },
            "includeSubs": false
          },
          {
            "entity": {
              "type": "FIELD_ENTITY",
              "code": "作成者"
            },
            "includeSubs": false
          },
          {
            "entity": {
              "type": "CUSTOM_FIELD",
              "code": "上司"
            },
            "includeSubs": false
          }
        ]
      }
    },
    "完了": {
      "name": "完了",
      "index": "2",
      "assignee": {
        "type": "ONE",
        "entities": []
      }
    }
  },
  "actions": [
    {
      "name": "処理開始",
      "from": "未処理",
      "to": "処理中",
      "filterCond": "レコード番号 = \"1\""
    },
    {
      "name": "完了する",
      "from": "処理中",
      "to": "完了",
      "filterCond": ""
    }
  ],
  "revision": "3"
}
*/
