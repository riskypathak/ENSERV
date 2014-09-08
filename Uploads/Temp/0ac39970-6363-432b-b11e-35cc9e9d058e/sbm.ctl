load data
 infile 'sbm.csv'
 APPEND
 into table SBMUPLOADED
 fields terminated by "}"
 (
  AMNTPAIDAFTERREBATEDATE,
    AMNTTOBEPAIDONREBATEDATE,
    AVGPOWERFACTOR,
    AVGUNITBILLED,
    BILLBASIS,
    BILLDATE DATE 'yyyymmdd hh24:mi:ss',
    BILLMONTH DATE 'yyyymmdd hh24:mi:ss',
    BILLNO,
    BILLPERIOD,
    BILLTIME,
    CONSUMERNO,
    CUMULATIVEMETERSTATUSCOUNTER,
    CUMULATIVEPROVISIONALEC,
    CUMULATIVEPROVISIONALED,
    CUMULATIVEUNITS,
    CURRENTMETERREADING,
    CURRENTMETERREADINGDATE DATE 'yyyymmdd hh24:mi:ss',
    CURRENTMETERSTATUS,
    CURRENTTOTALBILL,
    DISCONNECTIONDATE DATE 'yyyymmdd hh24:mi:ss',
    DPS,
    DUEDATE DATE 'yyyymmdd hh24:mi:ss',
    ED,
    HOUSELOCKADJUSTMENTAMOUNT,
    MDI,
    METERREADERID,
    METERREADERNAME,
    METERRENT,
    MMFCORDC,
    REBATEAMOUNT,
    REBATEDATE DATE 'yyyymmdd hh24:mi:ss',
    REMARKS,
    ROUNDAMOUNT,
    SBMNO,
    SLABEC1,
    SLABEC2,
    SLABEC3,
    SLABEC4,
    SLABUNITS1,
    SLABUNITS2,
    SLABUNITS3,
    SLABUNITS4,
    TARIFFCODE,
    TOTALECCHARGES,
    UNITCONSUMED,
    MODIFIEDDATETIME DATE 'yyyymmdd hh24:mi:ss',
    MODIFIEDBY,
    CREATEDDATETIME DATE 'yyyymmdd hh24:mi:ss',
    CREATEDBY,
    PROCESSED,
    INVOICESKIPPED,
    INVOICEPROCESSED,
    BATCHID,
    FILENAME,
    ARREARSPROCESSED,
    INVOICEPOSTED,
    PROCESSENDDATETIME DATE 'yyyymmdd hh24:mi:ss',
    PROCESSENDDATETIMETZID,
    PROCESSSTARTDATETIME DATE 'yyyymmdd hh24:mi:ss',
    PROCESSSTARTDATETIMETZID,
    RECORDUPLOADED
)