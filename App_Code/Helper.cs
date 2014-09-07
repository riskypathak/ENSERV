using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Utilities
/// </summary>
public static class Helper
{
    private static string createdBy = "ADMIN";

    public static void MoveToUploads()
    {
    }

    public static IList<SBMOutput> UploadSBM(string sbmPath, string tempFolderPath)
    {
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
                BillDate =DateTime.ParseExact(values[4], "dd-MM-yyyy", CultureInfo.InvariantCulture), //DateTime.Parse(values[4]),
                BillMonth = values[5],
                BillTime = values[6],
                BillPeriod = int.Parse(values[7]),
                CurrentMeterReading = int.Parse(values[8]),
                CurrrentMeterReadingDate =DateTime.ParseExact(values[9], "dd-MM-yyyy", CultureInfo.InvariantCulture),// DateTime.Parse(values[9]),
                MDI = double.Parse(values[10], CultureInfo.InvariantCulture),
                CurrentMeterStatus = values[11],
                CumulativeMeterStatusCounter = int.Parse(values[12]),
                HouseLockAdjumentAmount = double.Parse(values[13], CultureInfo.InvariantCulture),
                UnitsConsumed = int.Parse(values[14]),
                BillBasis = values[14],
                Slab1Units = int.Parse(values[16]),
                Slab2Units = int.Parse(values[17]),
                Slab3Units = int.Parse(values[18]),
                Slab4Units = int.Parse(values[19]),
                Slab1EC = double.Parse(values[20], CultureInfo.InvariantCulture),
                Slab2EC = double.Parse(values[21], CultureInfo.InvariantCulture),
                Slab3EC = double.Parse(values[22], CultureInfo.InvariantCulture),
                Slab4EC = double.Parse(values[23], CultureInfo.InvariantCulture),
                TotalEnergyCharge = double.Parse(values[24], CultureInfo.InvariantCulture),
                MonthlyMinimumCharges = double.Parse(values[25], CultureInfo.InvariantCulture),
                MeterRent = double.Parse(values[26], CultureInfo.InvariantCulture),
                ElectricityDutyCharges = double.Parse(values[27], CultureInfo.InvariantCulture),
                CumulativeProvisionalEnergyCharges = double.Parse(values[28], CultureInfo.InvariantCulture),
                CumulativeProvisionalElectricityDuty = double.Parse(values[29], CultureInfo.InvariantCulture),
                CumulativeUnits = int.Parse(values[30]),
                DelayPaymentSurcharge = double.Parse(values[31], CultureInfo.InvariantCulture),
                CurrentBillTotal = double.Parse(values[32], CultureInfo.InvariantCulture),
                RoundAmount = double.Parse(values[33], CultureInfo.InvariantCulture),
                RebateAmount = double.Parse(values[34], CultureInfo.InvariantCulture),
                AmounttobePaidonRebateDate = double.Parse(values[35], CultureInfo.InvariantCulture),
                AverageUnitsBilled = int.Parse(values[36]),
                RebateDate =DateTime.ParseExact(values[37], "dd-MM-yyyy", CultureInfo.InvariantCulture), //DateTime.Parse(values[37]),
                DueDate =DateTime.ParseExact(values[38], "dd-MM-yyyy", CultureInfo.InvariantCulture), //DateTime.Parse(values[38]),
                AveragePFPercentage = int.Parse(values[39]),
                AmountPaidafterRebateDate = double.Parse(values[40], CultureInfo.InvariantCulture),
                Disconnectiondate =DateTime.ParseExact(values[41], "dd-MM-yyyy", CultureInfo.InvariantCulture), //DateTime.Parse(values[41]),
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

        File.WriteAllText(string.Format("{0}//sbm.csv", tempFolderPath), csvString);

        ImportTODB(tempFolderPath, "sbm");

        return sbmOutputs;
    }

    public static IList<CSVOutput> UploadCSV(string csvPath, string tempFolderPath)
    {
        if (Path.GetExtension(csvPath).ToLower() == ".dbf")
        {
            csvPath = ConvertDBFToCSV(csvPath, tempFolderPath);
        }

        IList<CSVOutput> csvOutputs = new List<CSVOutput>();

        string[] csvLines = File.ReadAllLines(csvPath);

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
        }
        string csvString = string.Empty;

        csvOutputs.ToList().ForEach(csv => csvString +=
    string.Join("}",
    csv.ConsumerNo, //ConnectionID
    (string.IsNullOrEmpty(csv.ReceiptNo) ? csv.ManualReceiptNo : csv.ReceiptNo), //Recipt No.
    csv.ManualBookNo, //Manual Book No
    csv.ManualReceiptNo, //Manual Recipt No.
    csv.AmountCollected, // AMount
    csv.BankNameCode, //Bank Name
    csv.ChequeDate.ToString("yyyyMMdd"), //Cheque date
    csv.ChequeNo, //Cheque No.
    "000000", //Sec Code
    "000000", //Sub Div Code
    "000000", //div Code
    csv.DateofPayment.ToString("yyyyMMdd"), // payment date
    csv.PaymentType, //payment Type
    DateTime.Now.ToString("yyyyMMdd HH.mm.ss"), //Created Time
    "ADMIN" //CreatedBy
    ) + Environment.NewLine
);


        File.WriteAllText(string.Format("{0}//csv.csv", tempFolderPath), csvString);

        ImportTODB(tempFolderPath, "csv");

        return csvOutputs;
    }

    private static string ConvertDBFToCSV(string dbfPath, string tempFolderPath)
    {
        string csvPath = string.Empty;

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
                    cmd.CommandText = "SELECT MR_BKNO,CONS_ACC,COL_DATE,AMT_PAID,MR_RPNO FROM [" + Path.GetFileName(dbfPath) + "] where AMT_PAID<>0.00 and CONS_ACC<>" + (char)34 + " " + (char)34;
                    connection.Open();

                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());

                    string csvString = string.Empty;
                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            csvString +=
                                "NULL" + "}" + //SBM ID
                                "NULL" + "}" + //Collector Name
                                "NULL" + "}" + //Collector ID
                                row[1].ToString().Trim() + "}" + //Consumer No.
                                row[2].ToString().Trim().Replace(" 00.00.00", "") + "}" + //Date Of Payment
                                row[2].ToString().Trim() + "}" + //Time of payment
                                row[3].ToString().Trim() + "}" + //Amount Collected
                                row[4].ToString().Trim() + "}" + //Receipet No. = Manual reciept No.
                                "NULL" + "}" + //Cheque No.
                                "01/01/2001" + "}" + //Cheque Date.
                                "NULL" + "}" + //BankNameCode
                                row[0].ToString().Trim() + "}" + //Manual Book No
                                row[4].ToString().Trim() + "}" + //Manual Reciept No
                                "Cash" + "}" + // Payment Type
                                "0" //Installment Flag
                                + Environment.NewLine;
                        }
                    }

                    connection.Close();

                    csvPath = string.Format("{0}//csv.csv", tempFolderPath);
                    File.WriteAllText(csvPath, csvString);
                }
            }
        }

        return csvPath;
    }

    public static void ImportTODB(string tempFolderPath, string ctlFile)
    {
        try
        {
            ProcessStartInfo process = new ProcessStartInfo();

            process.WorkingDirectory = tempFolderPath;
            process.FileName =@"SQLLDR";
            process.Arguments = @"test/test control=" + ctlFile + ".ctl log=" + ctlFile + ".log bad=" + ctlFile + ".bad bindsize=20971520 readsize=20971520 rows=200000 Errors=25000";
          //  process.Arguments = @"SQLLDR test/test control=" + ctlFile + ".ctl";
            // process.ErrorDialog = true;
            process.CreateNoWindow = true;
            Process myProcess = Process.Start(process);
            myProcess.WaitForExit();
            myProcess.Close();


            //Process p = new Process();
            //string myCommand = @"CMD.EXE";
            //p.StartInfo = new ProcessStartInfo(myCommand);
            ////Provide arguments to CMD.EXE
            //p.StartInfo.Arguments = @"SQLLDR test/test control='" + tempFolderPath + "\\" + ctlFile + ".ctl'";

            ////To read output of process (before error)
            //p.StartInfo.RedirectStandardOutput = true;

            ////To read output of process(after error)
            //p.StartInfo.RedirectStandardError = true;

            //p.StartInfo.UseShellExecute = false;

            //p.StartInfo.WorkingDirectory = tempFolderPath;
            //p.Start();
            //p.WaitForExit();
            //if (p.ExitCode == 0)
            //{ //Success
            //    string standardOutputString = p.StandardOutput.ReadToEnd();
            //    //Show standard output (before error)
            //    // MessageBox.Show(standardOutputString);
            //}
            //else
            //{
            //    string errorString = p.StandardError.ReadToEnd();
            //    //Show output if there is any error
            //    // MessageBox.Show(errorString);
            //}



            //Process proc = new Process();
            //string myCommand = @"CMD.EXE";
            //proc.StartInfo = new ProcessStartInfo(myCommand);

            ////Set up arguments for CMD.EXE
            //proc.StartInfo.Arguments = @"SQLLDR test/test control='" + tempFolderPath + "\\" + ctlFile + ".ctl'";
            //proc.StartInfo.RedirectStandardOutput = true;
            //proc.StartInfo.RedirectStandardError = true;
            //proc.StartInfo.UseShellExecute = false;
            //proc.StartInfo.WorkingDirectory = tempFolderPath;
            //proc.Start();
            //proc.WaitForExit();



        }
        catch (Exception)
        {
            
            throw;
        }
        
    }
}