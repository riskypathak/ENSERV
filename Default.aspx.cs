using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class _Default : System.Web.UI.Page
{
    private string divisionCode = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        ConvertDBFToCSV("E://PKR.dbf");

        UploadSBM("E://sbm.sbm");

        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        connection.Open();
        connection.Close();
    }

    private void UploadSBM(string sbmPath)
    {
        string createdBy = "ADMIN";

        IList<SBMOutput> sbmOutputs = new List<SBMOutput>();

        string[] sbmLines = File.ReadAllLines(sbmPath);

        foreach (string sblLine in sbmLines)
        {
            string[] values = sblLine.Split('}');

            SBMOutput smbOutput = new SBMOutput()
            {
                ConsumerNumber = values[0],
                SBMNo = values[1],
                MeterReaderName = values[2],
                MeterReaderID = values[3],
                BillDate = DateTime.Parse(values[4]),
                BillMonth = values[5],
                BillTime = values[6],
                BillPeriod = int.Parse(values[7]),
                CurrentMeterReading = int.Parse(values[8]),
                CurrrentMeterReadingDate = DateTime.Parse(values[9]),
                MDI = double.Parse(values[10]),
                CurrentMeterStatus = values[11],
                CumulativeMeterStatusCounter = int.Parse(values[12]),
                HouseLockAdjumentAmount = double.Parse(values[13]),
                UnitsConsumed = int.Parse(values[14]),
                BillBasis = values[14],
                Slab1Units = int.Parse(values[16]),
                Slab2Units = int.Parse(values[17]),
                Slab3Units = int.Parse(values[18]),
                Slab4Units = int.Parse(values[19]),
                Slab1EC = double.Parse(values[20]),
                Slab2EC = double.Parse(values[21]),
                Slab3EC = double.Parse(values[22]),
                Slab4EC = double.Parse(values[23]),
                TotalEnergyCharge = double.Parse(values[24]),
                MonthlyMinimumCharges = double.Parse(values[25]),
                MeterRent = double.Parse(values[26]),
                ElectricityDutyCharges = double.Parse(values[27]),
                CumulativeProvisionalEnergyCharges = double.Parse(values[28]),
                CumulativeProvisionalElectricityDuty = double.Parse(values[29]),
                CumulativeUnits = int.Parse(values[30]),
                DelayPaymentSurcharge = double.Parse(values[31]),
                CurrentBillTotal = double.Parse(values[32]),
                RoundAmount = double.Parse(values[33]),
                RebateAmount = double.Parse(values[34]),
                AmounttobePaidonRebateDate = double.Parse(values[35]),
                AverageUnitsBilled = int.Parse(values[36]),
                RebateDate = DateTime.Parse(values[37]),
                DueDate = DateTime.Parse(values[38]),
                AveragePFPercentage = int.Parse(values[39]),
                AmountPaidafterRebateDate = double.Parse(values[40]),
                Disconnectiondate = DateTime.Parse(values[41]),
                Remarks = values[42],
                TariffCode = values[43],
                BillNo = values[44],
                //UploadFlag = values[45],
            };

            sbmOutputs.Add(smbOutput);
        }

        string csvString = string.Empty;

        sbmOutputs.ToList().ForEach(sbm => csvString +=
        string.Join("}",
             sbm.AmountPaidafterRebateDate,
    sbm.AmounttobePaidonRebateDate,
            0,// AVGPOWERFACTOR number(32, 16) NOT NULL,
    sbm.AverageUnitsBilled,
    sbm.BillBasis,
    sbm.BillDate.ToString("yyyyMMdd HH.mm.ss"),
    sbm.BillDate.ToString("yyyyMMdd HH.mm.ss"),//Datesbm.BillMonth,
    sbm.BillNo,
    sbm.BillPeriod,
    int.Parse(sbm.BillTime.Replace(":", string.Empty)),
    sbm.ConsumerNumber,
    sbm.CumulativeMeterStatusCounter,
    sbm.CumulativeProvisionalEnergyCharges,
    sbm.CumulativeProvisionalElectricityDuty,
    sbm.CumulativeUnits,
    sbm.CurrentMeterReading,
    sbm.CurrrentMeterReadingDate.ToString("yyyyMMdd HH.mm.ss"),
    sbm.CurrentMeterStatus,
    sbm.CurrentBillTotal,
    sbm.Disconnectiondate.ToString("yyyyMMdd HH.mm.ss"),
    sbm.DelayPaymentSurcharge,
    sbm.DueDate.ToString("yyyyMMdd HH.mm.ss"),
    sbm.ElectricityDutyCharges,
    sbm.HouseLockAdjumentAmount,
    sbm.MDI,
    sbm.MeterReaderID,
    sbm.MeterReaderName,
    sbm.MeterRent,
   sbm.MonthlyMinimumCharges,
    sbm.RebateAmount,
    sbm.RebateDate.ToString("yyyyMMdd HH.mm.ss"),
    sbm.Remarks,
    sbm.RoundAmount,
    sbm.SBMNo,
    sbm.Slab1EC,
    sbm.Slab2EC,
    sbm.Slab3EC,
    sbm.Slab4EC,
    sbm.Slab1Units,
    sbm.Slab2Units,
    sbm.Slab3Units,
    sbm.Slab4Units,
    sbm.TariffCode,
    sbm.TotalEnergyCharge,
    sbm.UnitsConsumed,
    "20010101 00.00.00",        //    MODIFIEDDATETIME Date NOT NULL,
    "NULL",        //  MODIFIEDBY varchar2(8) NOT NULL,
           DateTime.Now.ToString("yyyyMMdd HH.mm.ss"),//CREATEDDATETIME Date NOT NULL,
            createdBy,//CREATEDBY varchar2(8) NOT NULL,
            0,//PROCESSED number NOT NULL,
            0,//INVOICESKIPPED number NOT NULL,
            0,//INVOICEPROCESSED number NOT NULL,
            0,//BATCHID number NOT NULL,
            Path.GetFileName(sbmPath),//FILENAME varchar2(259) NOT NULL,
            0,//ARREARSPROCESSED number NOT NULL,
            0,//INVOICEPOSTED number NOT NULL,
            "20010101 00.00.00",//PROCESSENDDATETIME Date NOT NULL,
            0,//PROCESSENDDATETIMETZID number NOT NULL,
            "20010101 00.00.00",//PROCESSSTARTDATETIME Date NOT NULL,
            0,//PROCESSSTARTDATETIMETZID number NOT NULL,
            0//RECORDUPLOADED number NOT NULL)
        ) + Environment.NewLine
    );

        File.WriteAllText(Server.MapPath("") + "//sbm" + ".csv", csvString);
    }

    private void ConvertDBFToCSV(string dbfPath)
    {
        if (File.Exists(dbfPath))
        {
            OleDbConnectionStringBuilder builder = new OleDbConnectionStringBuilder()
            {
                DataSource = Path.GetDirectoryName(dbfPath),
                Provider = "Microsoft.Jet.OLEDB.4.0"
            };

            builder.Add("Extended Properties", "dBase III");

            using (OleDbConnection connection = new OleDbConnection() { ConnectionString = "Provider=vfpoledb;Data Source=" + dbfPath + ";Collating Sequence=machine;" })
            {
                using (OleDbCommand cmd = new OleDbCommand() { Connection = connection })
                {
                    cmd.CommandText = "SELECT MR_BKNO,CONS_ACC,COL_DATE,COL_DATE,AMT_PAID,MR_RPNO FROM [" + Path.GetFileName(dbfPath) + "] where AMT_PAID<>0.00 and CONS_ACC<>" + (char)34 + " " + (char)34;
                    connection.Open();

                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());

                    string csvData = string.Empty;
                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            csvData +=
                                "NULL" + "}" + //SBM ID
                                "NULL" + "}" + //Collector Name
                                //"NULL" + "}" + //Collector ID
                                row[0].ToString().Trim() + "}" +
                                row[1].ToString().Trim() + "}" +
                                row[2].ToString().Trim().Replace(" 00.00.00", "") + "}" +
                                row[3].ToString().Trim().Replace(" 00.00.00", "") + "}" +
                                row[4].ToString().Trim() + "}" +
                                "NULL" + "}" + //Receipet No.
                                "NULL" + "}" + //Cheque No.
                                "01/01/2001" + "}" + //Cheque Date.
                                "NULL" + "}" + //BankNameCode
                                "NULL" + "}" + //M<anual Book No
                                row[5].ToString().Trim() +
                                "}Cash}0"
                                + Environment.NewLine;
                        }
                    }

                    connection.Close();

                    string csvFilePath = Server.MapPath("Uploads") + "//CSV//" + Path.GetFileNameWithoutExtension(dbfPath) + ".csv";

                    File.WriteAllText(csvFilePath, csvData);

                    UploadCSV(csvFilePath);
                }
            }
        }
    }

    private void UploadCSV(string csvFilePath)
    {
        IList<CSVOutput> csvOutputs = new List<CSVOutput>();

        string[] csvLines = File.ReadAllLines(csvFilePath);

        foreach (string csvLine in csvLines)
        {
            string[] values = csvLine.Split('}');

            CSVOutput csvOutput = new CSVOutput()
            {
                SBMID = values[0],
                CollectorName = values[1],
                CollectorID = values[2],
                ConsumerNo = values[3],
                DateofPayment = DateTime.Parse(values[4]),
                TimeofPayment = values[5],
                AmountCollected = double.Parse(values[6]),
                ReceiptNo = values[7],
                ChequeNo = values[8],
                ChequeDate = DateTime.Parse(values[9]),
                BankNameCode = values[10],
                ManualBookNo = values[11],
                ManualReceiptNo = values[12],
                PaymentType = values[13],
                InstallmentFlag = int.Parse(values[14]),
            };

            csvOutputs.Add(csvOutput);

            string csvString = string.Empty;

            csvOutputs.ToList().ForEach(csv => csvString +=
        string.Join("}",
        csv.ReceiptNo,
        csv.ManualBookNo,
        csv.ManualReceiptNo,
        csv.AmountCollected,
        csv.BankNameCode,
        csv.ChequeDate.ToString("yyyyMMdd"),
        csv.ChequeNo,
        "000000",
        "000000",
        "000000",
        csv.DateofPayment.ToString("yyyyMMdd"),
        csv.PaymentType,
        DateTime.Now.ToString("yyyyMMdd HH.mm.ss"), //Created Time
        "ADMIN" //CreatedBy
        ) + Environment.NewLine
    );

            File.WriteAllText(Server.MapPath("") + "\\csv" + ".csv", csvString);
        }
    }
}