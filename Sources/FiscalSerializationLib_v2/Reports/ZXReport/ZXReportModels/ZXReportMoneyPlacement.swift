//
//  ZXReportMoneyPlacement.swift
//  FiscalSerializationLib_v2
//
//  Created by Sergey Ivanov on 11.12.2024.
//

import Foundation

struct ZXReportMoneyPlacements {
    static func createZXReportMoneyPlacementsResponse(zXReportMoneyPlacementsCpcr: [Kkm_Proto_ZXReport.MoneyPlacement]) throws -> [ZXReportMoneyPlacementResponse] {
        try zXReportMoneyPlacementsCpcr.map { moneyPlacementCpcr in
            try ZXReportMoneyPlacement.createZXReportMoneyPlacementResponse(zXReportMoneyPlacementCpcr: moneyPlacementCpcr)
        }
    }
}

struct ZXReportMoneyPlacement {
    static func createZXReportMoneyPlacementResponse(zXReportMoneyPlacementCpcr: Kkm_Proto_ZXReport.MoneyPlacement) throws -> ZXReportMoneyPlacementResponse {
        guard zXReportMoneyPlacementCpcr.hasOperation else {
            throw ZXReportErrorEnum.missingMoneyPalcementOperationResponse
        }
        
        guard let operation = MoneyPlacementEnum(rawValue: UInt(zXReportMoneyPlacementCpcr.operation.rawValue)) else {
            throw ZXReportErrorEnum.notValideMoneyPalcementOperationTypeResponse
        }
        
        let operationsTotalCount = zXReportMoneyPlacementCpcr.operationsTotalCount
        let operationsCount = zXReportMoneyPlacementCpcr.operationsCount
        let operationsSum = Money.toDouble(protoMoney: zXReportMoneyPlacementCpcr.operationsSum)
        let offlineCount = zXReportMoneyPlacementCpcr.offlineCount
        
        return ZXReportMoneyPlacementResponse.create(with: (operation, operationsTotalCount, operationsCount, operationsSum, offlineCount))
    }
}
