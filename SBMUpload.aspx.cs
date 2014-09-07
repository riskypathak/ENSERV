using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Configuration;


public partial class SBMUpload : System.Web.UI.Page
{
    #region Private Member Variables
    private static string UPLOADFOLDER = "Uploads";

    private string tempUploadFolder;
    private string ctlFolder;

    #endregion

    #region Web Methods
    protected void Page_Load(object sender, EventArgs args)
    {
        if (Session["sesuUserDetails"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        this.Form.Action += "?id=" + Session.SessionID;
        //ctlFolder = Server.MapPath("ctl");

        //if (!this.IsPostBack)
        //{
        //    //Reserve a spot in Session for the UploadDetail object
        //    this.Session["UploadDetail"] = new UploadDetail { IsReady = false };
        //    LoadUploadedFiles(ref gvNewFiles);
        //}
    }
    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public static object GetUploadStatus()
    {
        //Get the length of the file on disk and divide that by the length of the stream
        UploadDetail info = (UploadDetail)HttpContext.Current.Session["UploadDetail"];
        if (info != null && info.IsReady)
        {
            int soFar = info.UploadedLength;
            int total = info.ContentLength;
            int percentComplete = (int)Math.Ceiling((double)soFar / (double)total * 100);
            string message = "Uploading...";
            string fileName = string.Format("{0}", info.FileName);
            string downloadBytes = string.Format("{0} of {1} Bytes", soFar, total);
            return new
            {
                percentComplete = percentComplete,
                message = message,
                fileName = fileName,
                downloadBytes = downloadBytes
            };
        }
        //Not ready yet
        return null;
    }
    #endregion

    #region Web Callbacks
    protected void gvNewFiles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "eventMouseOver(this)");
            e.Row.Attributes.Add("onmouseout", "eventMouseOut(this)");
        }
    }
    //protected void gvNewFiles_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    switch (e.CommandName)
    //    {
    //        case "deleteFile":
    //            DeleteFile(e.CommandArgument.ToString());
    //            LoadUploadedFiles(ref gvNewFiles);
    //            break;
    //        case "downloadFile":
    //            string strFolder = "Uploads";
    //            string filePath = Path.Combine(strFolder, e.CommandArgument.ToString());
    //            DownloadFile(filePath);
    //            break;
    //    }
    //}
    //protected void hdRefereshGrid_ValueChanged(object sender, EventArgs e)
    //{
    //    LoadUploadedFiles(ref gvNewFiles);
    //}
    #endregion

    #region Support Methods
    //public void LoadUploadedFiles(ref GridView gv)
    //{
    //    DataTable dtFiles = new DataTable();

    //    if (Directory.Exists(tempUploadFolder))
    //    {
    //        dtFiles = GetFilesInDirectory(tempUploadFolder);
    //    }
    //    gv.DataSource = dtFiles;
    //    gv.DataBind();
    //    if (dtFiles != null && dtFiles.Rows.Count > 0)
    //    {
    //        double totalSize = Convert.ToDouble(dtFiles.Compute("SUM(Size)", ""));
    //        if (totalSize > 0) lblTotalSize.Text = CalculateFileSize(totalSize);
    //    }
    //}
    public DataTable GetFilesInDirectory(string sourcePath)
    {
        System.Data.DataTable dtFiles = new System.Data.DataTable();
        if ((Directory.Exists(sourcePath)))
        {
            dtFiles.Columns.Add(new System.Data.DataColumn("Name"));
            dtFiles.Columns.Add(new System.Data.DataColumn("Size"));
            dtFiles.Columns["Size"].DataType = typeof(double);
            dtFiles.Columns.Add(new System.Data.DataColumn("ConvertedSize"));
            DirectoryInfo dir = new DirectoryInfo(sourcePath);
            foreach (FileInfo files in dir.GetFiles("*.*"))
            {
                System.Data.DataRow drFile = dtFiles.NewRow();
                drFile["Name"] = files.Name;
                drFile["Size"] = files.Length;
                drFile["ConvertedSize"] = CalculateFileSize(files.Length);
                dtFiles.Rows.Add(drFile);
            }
        }
        return dtFiles;
    }
    public void DownloadFile(string filePath)
    {
        if (File.Exists(Server.MapPath(filePath)))
        {
            string strFileName = Path.GetFileName(filePath).Replace(" ", "%20");
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + strFileName);
            Response.Clear();
            Response.WriteFile(Server.MapPath(filePath));
            Response.End();
        }
    }
    public string DeleteFile(string FileName)
    {
        string strMessage = "";
        try
        {
            string strPath = Path.Combine(tempUploadFolder, FileName);
            if (File.Exists(Server.MapPath(strPath)) == true)
            {
                File.Delete(Server.MapPath(strPath));
                strMessage = "File Deleted";
            }
            else
                strMessage = "File Not Found";
        }
        catch (Exception ex)
        {
            strMessage = ex.Message;
        }
        return strMessage;
    }
    public string CalculateFileSize(double FileInBytes)
    {
        string strSize = "00";
        if (FileInBytes < 1024)
            strSize = FileInBytes + " B";//Byte
        else if (FileInBytes > 1024 & FileInBytes < 1048576)
            strSize = Math.Round((FileInBytes / 1024), 2) + " KB";//Kilobyte
        else if (FileInBytes > 1048576 & FileInBytes < 107341824)
            strSize = Math.Round((FileInBytes / 1024) / 1024, 2) + " MB";//Megabyte
        else if (FileInBytes > 107341824 & FileInBytes < 1099511627776)
            strSize = Math.Round(((FileInBytes / 1024) / 1024) / 1024, 2) + " GB";//Gigabyte
        else
            strSize = Math.Round((((FileInBytes / 1024) / 1024) / 1024) / 1024, 2) + " TB";//Terabyte
        return strSize;
    }
    #endregion

    protected void btnProcess_Click(object sender, EventArgs e)
    {
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
                    string newFilePath = sbmUploadDirectory + "\\" + fileName;

                    if (File.Exists(newFilePath))
                    {
                        fileName = Path.GetFileNameWithoutExtension(fileName) + "_" + DateTime.Now.ToString("ddMMyyyHHmmss") + Path.GetExtension(fileName);
                        newFilePath = sbmUploadDirectory + "\\" + fileName;
                    }

                    File.Copy(filePath, newFilePath);

                    IList<SBMOutput> allSBMS = Helper.UploadSBM(newFilePath, tempUploadFolder);

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
            Path.GetFileName(newFilePath),//FILENAME varchar2(259) NOT NULL,
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
    protected void btnStart_Click(object sender, EventArgs e)
    {

    }
}