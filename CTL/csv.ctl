load data
 infile 'csv.csv'
 APPEND
 into table tbl_Payment
 fields terminated by "}"
 (
  ConnectionID,
  RECEIPTNUMBER,
  MANUALBOOKNO,
  MANUALRECEIPTNO,
  AMOUNT,
  BANKID,
  CHEQUEDATE DATE 'yyyymmdd',
  CHEQUENO,
  SEC_CODE,
  SUB_DIV_CODE,
  DIV_CODE,
  PAYMENTDATETIME  DATE 'yyyymmdd',
  PAYMENTMODES,
  CREATEDDATETIME  DATE 'yyyymmdd hh24:mi:ss',
  CREATEDBY 
)