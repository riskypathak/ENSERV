using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Configuration;

public partial class CSVUpload : System.Web.UI.Page
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
        tempUploadFolder = Server.MapPath("Uploads") + string.Format("//Temp//{0}", Session.SessionID);
        ctlFolder = Server.MapPath("ctl");

        if (!this.IsPostBack)
        {
            //Reserve a spot in Session for the UploadDetail object
            this.Session["UploadDetail"] = new UploadDetail { IsReady = false };
            //LoadUploadedFiles(ref gvNewFiles);
        }
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
    protected void gvNewFiles_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //switch (e.CommandName)
        //{
        //    case "deleteFile":
        //        DeleteFile(e.CommandArgument.ToString());
        //        LoadUploadedFiles(ref gvNewFiles);
        //        break;
        //    case "downloadFile":
        //        string strFolder = "Uploads";
        //        string filePath = Path.Combine(strFolder, e.CommandArgument.ToString());
        //        DownloadFile(filePath);
        //        break;
        //}
    }
    protected void hdRefereshGrid_ValueChanged(object sender, EventArgs e)
    {
       // LoadUploadedFiles(ref gvNewFiles);
    }
    #endregion

    #region Support Methods
    public void LoadUploadedFiles(ref GridView gv)
    {
        //DataTable dtFiles = new DataTable();

        //if (Directory.Exists(tempUploadFolder))
        //{
        //    dtFiles = GetFilesInDirectory(tempUploadFolder);
        //}
        //gv.DataSource = dtFiles;
        //gv.DataBind();
        //if (dtFiles != null && dtFiles.Rows.Count > 0)
        //{
        //    double totalSize = Convert.ToDouble(dtFiles.Compute("SUM(Size)", ""));
        //    if (totalSize > 0) lblTotalSize.Text = CalculateFileSize(totalSize);
        //}
    }
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
            string csvUploadDirectory = Server.MapPath(ConfigurationSettings.AppSettings["CSVUploadPath"]);

            foreach (string filePath in Directory.GetFiles(tempUploadFolder))
            {
                //Copy ctl files to temp path
                File.Copy(string.Format("{0}\\csv.ctl", ctlFolder), string.Format("{0}\\csv.ctl", tempUploadFolder));
                string fileName = Path.GetFileName(filePath);

                try
                {
                    string newFilePath = csvUploadDirectory + "\\" + fileName;

                    if (File.Exists(newFilePath))
                    {
                        fileName = Path.GetFileNameWithoutExtension(fileName) + "_" + DateTime.Now.ToString("ddMMyyyHHmmss") + Path.GetExtension(fileName);
                        newFilePath = csvUploadDirectory + "\\" + fileName;
                    }

                    File.Copy(filePath, newFilePath);

                    IList<CSVOutput> allCSVs = Helper.UploadCSV(newFilePath, tempUploadFolder);

                    //Read Bad File
                    string badFilePath = tempUploadFolder + "\\csv.bad";

                    if (File.Exists(badFilePath))
                    {
                        IList<string> badLines = File.ReadLines(badFilePath).ToList();

                        foreach (string badLine in badLines)
                        {
                            string badRecieptNo = badLine.Split('}')[7];

                            CSVOutput badCSV = allCSVs.SingleOrDefault(s => s.ReceiptNo.Equals(badRecieptNo));

                            if (badCSV != null)
                            {
                                IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
                                connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                                connection.Open();

                                IDbCommand cmdInsertCSVPayment = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                                cmdInsertCSVPayment.CommandText = string.Format("INSERT INTO tbl_Payment(ConnectionID,RECEIPTNUMBER,MANUALBOOKNO,MANUALRECEIPTNO,AMOUNT,BANKID,CHEQUEDATE,CHEQUENO,SEC_CODE,SUB_DIV_CODE,DIV_CODE,PAYMENTDATETIME,PAYMENTMODES,CREATEDDATETIME,CREATEDBY) " +
                                    "VALUES('{0}', '{1}', '{2}', '{3}', {4}, '{5}', '{6}', '{7}', {8}, {9}, {10}, '{11}', '{12}', '{13}', '{14}')"
                                    , badCSV.ConsumerNo, //ConnectionID
    (string.IsNullOrEmpty(badCSV.ReceiptNo) ? badCSV.ManualReceiptNo : badCSV.ReceiptNo), //Recipt No.
    badCSV.ManualBookNo, //Manual Book No
    badCSV.ManualReceiptNo, //Manual Recipt No.
    badCSV.AmountCollected, // AMount
    badCSV.BankNameCode, //Bank Name
    badCSV.ChequeDate.ToString("yyyyMMdd"), //Cheque date
    badCSV.ChequeNo, //Cheque No.
    "000000", //Sec Code
    "000000", //Sub Div Code
    "000000", //div Code
    badCSV.DateofPayment.ToString("yyyyMMdd"), // payment date
    badCSV.PaymentType, //payment Type
    DateTime.Now.ToString("yyyyMMdd HH.mm.ss"), //Created Time
    "ADMIN" //CreatedBy
            );
                                cmdInsertCSVPayment.Connection = connection;

                                try
                                {
                                    cmdInsertCSVPayment.ExecuteNonQuery();
                                }
                                catch (Exception ex)
                                {
                                    IDbCommand cmdInsertError = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                                    cmdInsertError.CommandText = string.Format("INSERT INTO ErrorDetails(ConsumerName , Error, FileName, ErrorDateTime) VALUES('{0}', '{1}', '{2}', '{3}')"
                                        , badCSV.ConsumerNo, ex.Message, fileName, DateTime.Now.ToString("yyyyMMdd HH.mm.ss"));
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
                                         .Where(p => p.Extension != ".csv" || p.Extension != ".dbf").ToArray();
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
}