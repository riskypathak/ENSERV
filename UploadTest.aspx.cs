using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UploadTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Form.Action += "?id=" + Session.SessionID;
    }

    protected void btnStart_Click(object sender, EventArgs e)
    {


    }


    public void Test()
    {
    }
    protected void test_Click(object sender, EventArgs e)
    {

    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        string tempUploadFolder = HttpContext.Current.Server.MapPath("Uploads") + string.Format("//Temp//{0}", HttpContext.Current.Session.SessionID);
        string ctlFolder = Server.MapPath("ctl");
        try
        {
            string sbmUploadDirectory = Server.MapPath(ConfigurationSettings.AppSettings["SBMUploadPath"]);

            foreach (string filePath in Directory.GetFiles(tempUploadFolder))
            {
                //Copy ctl files to temp path
                File.Copy(string.Format("{0}\\sbm.ctl", ctlFolder), string.Format("{0}\\sbm.ctl", tempUploadFolder));

                string fileName = Path.GetFileName(filePath);

                try
                {
                    IList<SBMOutput> allSBMS = Helper.UploadSBM(filePath, tempUploadFolder);

                    ProcessbadRecords(tempUploadFolder, filePath, fileName, allSBMS);

                    fileName = UploadToUploadFolder(sbmUploadDirectory, filePath, fileName);

                }
                catch (Exception ex)
                {
                    IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
                    connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                    connection.Open();

                    IDbCommand cmdInsertError = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                    cmdInsertError.CommandText = string.Format("INSERT INTO ErrorDetails(Error, FileName, ErrorDateTime) VALUES('{0}', '{1}', '{2}')"
                        , ex.Message, fileName, DateTime.Now.ToString("yyyyMMdd HH.mm.ss"));
                    cmdInsertError.Connection = connection;

                    cmdInsertError.ExecuteNonQuery();

                    connection.Close();
                }
                finally
                {
                    // Delete all files apart from sbm files
                    DirectoryInfo di = new DirectoryInfo(tempUploadFolder);
                    FileInfo[] files = di.GetFiles()
                                         .Where(p => p.Extension != ".sbm").ToArray();
                    foreach (FileInfo file in files)
                    {
                        File.Delete(file.FullName);
                    }
                }
            }
        }
        finally
        {
            File.Delete(tempUploadFolder);
        }
    }

    private static string UploadToUploadFolder(string sbmUploadDirectory, string filePath, string fileName)
    {
        string newFilePath = sbmUploadDirectory + "\\" + fileName;

        if (File.Exists(newFilePath))
        {
            fileName = Path.GetFileNameWithoutExtension(fileName) + "_" + DateTime.Now.ToString("ddMMyyyHHmmss") + Path.GetExtension(fileName);
            newFilePath = sbmUploadDirectory + "\\" + fileName;
        }

        File.Copy(filePath, newFilePath);
        return fileName;
    }

    private static void ProcessbadRecords(string tempUploadFolder, string filePath, string fileName, IList<SBMOutput> allSBMS)
    {
        //Read Bad File
        string badFilePath = tempUploadFolder + "\\sbm.bad";

        if (File.Exists(badFilePath))
        {
            IList<string> badLines = File.ReadLines(badFilePath).ToList();

            foreach (string badLine in badLines)
            {
                string badConsumerNo = badLine.Split('}')[0];

                SBMOutput badSBM = allSBMS.SingleOrDefault(s => s.ConsumerNumber.Equals(badConsumerNo));

                if (badSBM != null)
                {
                    IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
                    connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                    connection.Open();

                    IDbCommand cmdInsertSBMPayment = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                    cmdInsertSBMPayment.CommandText = string.Format("INSERT INTO sbmUploaded VALUES({0}, {1}, {2}, {3}, {4}, '{5}', '{6}', '{7}', {8}, {9}, '{10}', {11}, {12}, {13}, {14}, {15}, '{16}', {17}, {18}, '{19}', {20}, '{21}', {22}, {23}, {24}, '{25}', '{26}', {27}, {28}, {29}, '{30}', '{31}', {32}, {33}, {34}, '{35}', '{36}', {37}, '{38}', {39}, {40}, {41}, {42}, {43}, {44}, {45}, {46}, '{47}', {48}, {49}, '{50}', '{51}', '{52}', '{53}', {54}, {55}, {56}, {57}, '{58}', {59}, {60}, '{61}', {62}, '{63}')"
                        , badSBM.AmountPaidafterRebateDate,
badSBM.AmounttobePaidonRebateDate,
0,// AVGPOWERFACTOR number(32, 16) NOT NULL,
badSBM.AverageUnitsBilled,
badSBM.BillBasis,
badSBM.BillDate.ToString("yyyyMMdd HH.mm.ss"),
badSBM.BillDate.ToString("yyyyMMdd HH.mm.ss"),//Datesbm.BillMonth,
badSBM.BillNo,
badSBM.BillPeriod,
int.Parse(badSBM.BillTime.Replace(":", string.Empty)),
badSBM.ConsumerNumber,
badSBM.CumulativeMeterStatusCounter,
badSBM.CumulativeProvisionalEnergyCharges,
badSBM.CumulativeProvisionalElectricityDuty,
badSBM.CumulativeUnits,
badSBM.CurrentMeterReading,
badSBM.CurrrentMeterReadingDate.ToString("yyyyMMdd HH.mm.ss"),
badSBM.CurrentMeterStatus,
badSBM.CurrentBillTotal,
badSBM.Disconnectiondate.ToString("yyyyMMdd HH.mm.ss"),
badSBM.DelayPaymentSurcharge,
badSBM.DueDate.ToString("yyyyMMdd HH.mm.ss"),
badSBM.ElectricityDutyCharges,
badSBM.HouseLockAdjumentAmount,
badSBM.MDI,
badSBM.MeterReaderID,
badSBM.MeterReaderName,
badSBM.MeterRent,
badSBM.MonthlyMinimumCharges,
badSBM.RebateAmount,
badSBM.RebateDate.ToString("yyyyMMdd HH.mm.ss"),
badSBM.Remarks,
badSBM.RoundAmount,
badSBM.SBMNo,
badSBM.Slab1EC,
badSBM.Slab2EC,
badSBM.Slab3EC,
badSBM.Slab4EC,
badSBM.Slab1Units,
badSBM.Slab2Units,
badSBM.Slab3Units,
badSBM.Slab4Units,
badSBM.TariffCode,
badSBM.TotalEnergyCharge,
badSBM.UnitsConsumed,
"20010101 00.00.00",        //    MODIFIEDDATETIME Date NOT NULL,
"NULL",        //  MODIFIEDBY varchar2(8) NOT NULL,
DateTime.Now.ToString("yyyyMMdd HH.mm.ss"),//CREATEDDATETIME Date NOT NULL,
"ADMIN",//CREATEDBY varchar2(8) NOT NULL,
0,//PROCESSED number NOT NULL,
0,//INVOICESKIPPED number NOT NULL,
0,//INVOICEPROCESSED number NOT NULL,
0,//BATCHID number NOT NULL,
Path.GetFileName(filePath),//FILENAME varchar2(259) NOT NULL,
0,//ARREARSPROCESSED number NOT NULL,
0,//INVOICEPOSTED number NOT NULL,
"20010101 00.00.00",//PROCESSENDDATETIME Date NOT NULL,
0,//PROCESSENDDATETIMETZID number NOT NULL,
"20010101 00.00.00",//PROCESSSTARTDATETIME Date NOT NULL,
0,//PROCESSSTARTDATETIMETZID number NOT NULL,
0//RECORDUPLOADED number NOT NULL));
);
                    cmdInsertSBMPayment.Connection = connection;

                    try
                    {
                        cmdInsertSBMPayment.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        IDbCommand cmdInsertError = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                        cmdInsertError.CommandText = string.Format("INSERT INTO ErrorDetails(ConsumerName , Error, FileName, ErrorDateTime) VALUES('{0}', '{1}', '{2}', '{3}')"
                            , badSBM.ConsumerNumber, ex.Message, fileName, DateTime.Now.ToString("yyyyMMdd HH.mm.ss"));
                        cmdInsertError.Connection = connection;

                        cmdInsertError.ExecuteNonQuery();
                    }
                    finally
                    {
                        connection.Close();
                    }
                }
                else
                {
                    //Insert Error
                }
            }
        }
    }




}