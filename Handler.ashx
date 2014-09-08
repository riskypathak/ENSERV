<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Data;
using System.Globalization;

using System.Configuration;


public class Handler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";//"application/json";
        
        if (context.Request.UrlReferrer.ToString().ToLower().Contains("sbmupload.aspx"))
        {
            try
            {
                UploadSBMFile(context);
            }
            catch (Exception)
            {
                
                
            }
            //string tempUploadFolder = context.Server.MapPath("Uploads") + string.Format("\\Temp\\{0}", context.Request.QueryString["id"]);
           
           
             
           
        }
        else if (context.Request.UrlReferrer.ToString().ToLower().Contains("csvupload.aspx"))
        {
            try
            {
                UploadCSVFile(context);
               
            }
            catch (Exception)
            {


            }
        }


    }

    private void UploadSBMFile(HttpContext context)
    {
        //string date = "0.000";
        //double dt = 0;
        //NumberStyles styles = NumberStyles.AllowParentheses | NumberStyles.AllowTrailingSign |
        //    NumberStyles.Float | NumberStyles.AllowThousands;
        //double.Parse("0.000", styles);

        //return;
        Guid folderId = Guid.NewGuid();
        string tempUploadFolder = context.Server.MapPath("Uploads") + string.Format("\\Temp\\{0}", folderId); //context.Request.QueryString["id"]
        string ctlFolder = context.Server.MapPath("ctl");

        if (!Directory.Exists(tempUploadFolder))
        {
            Directory.CreateDirectory(tempUploadFolder);
        }

        var r = new System.Collections.Generic.List<ViewDataUploadFilesResult>();
        System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
        foreach (string file in context.Request.Files)
        {
            HttpPostedFile hpf = context.Request.Files[file] as HttpPostedFile;
            string FileName = string.Empty;
            if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
            {
                string[] files = hpf.FileName.Split(new char[] { '\\' });
                FileName = files[files.Length - 1];
            }
            else
            {
                FileName = hpf.FileName;
            }
            if (hpf.ContentLength == 0)
                continue;
            string savedFileName = string.Format("{0}\\{1}", tempUploadFolder, FileName);
            hpf.SaveAs(savedFileName);



            try
            {
                //Copy ctl files to temp path
                string checkFile = tempUploadFolder + "\\sbm.ctl";
                if (!File.Exists(checkFile))
                {
                    File.Copy(string.Format("{0}\\sbm.ctl", ctlFolder), string.Format("{0}\\sbm.ctl", tempUploadFolder));
                }

                string sbmUploadDirectory = System.Web.HttpContext.Current.Server.MapPath(System.Configuration.ConfigurationSettings.AppSettings["SBMUploadPath"]);

                //foreach (string filePath in System.IO.Directory.GetFiles(savedFileName))
                //{
                try
                {
                    string fileName = Path.GetFileName(savedFileName);

                    string newFilePath = sbmUploadDirectory + "\\" + fileName;

                    if (File.Exists(newFilePath))
                    {
                        fileName = System.IO.Path.GetFileNameWithoutExtension(fileName) + "_" + DateTime.Now.ToString("ddMMyyyHHmmss") + Path.GetExtension(fileName);
                        newFilePath = sbmUploadDirectory + "\\" + fileName;
                    }

                    File.Copy(savedFileName, newFilePath);

                    Helper.UploadSBM(newFilePath, tempUploadFolder);
                    Directory.Delete(tempUploadFolder, true);
                }
                catch (Exception ex)
                {
                    System.Data.IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
                    connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                    connection.Open();

                    System.Data.IDbCommand cmdInsertError = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                    cmdInsertError.CommandText = string.Format("INSERT INTO .... VALUES()");
                    cmdInsertError.Connection = connection;

                    cmdInsertError.ExecuteNonQuery();

                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                Directory.Delete(tempUploadFolder, true);
            }



            r.Add(new ViewDataUploadFilesResult()
            {
                //Thumbnail_url = savedFileName,
                Name = FileName,
                Length = hpf.ContentLength,
                Type = hpf.ContentType
            });
            var uploadedFiles = new
            {
                files = r.ToArray()
            };
            var jsonObj = js.Serialize(uploadedFiles);
            //jsonObj.ContentEncoding = System.Text.Encoding.UTF8;
            //jsonObj.ContentType = "application/json;";
            // context.Response.Redirect("Demo.aspx");
           // context.Response.Write("");
            context.Response.Write(jsonObj.ToString());
        }

    }
    private void UploadCSVFile(HttpContext context)
    {
        Guid FolderID = Guid.NewGuid();
        string tempUploadFolder = context.Server.MapPath("Uploads") + string.Format("\\Temp\\{0}", FolderID);
        string ctlFolder = context.Server.MapPath("ctl");
        if (!Directory.Exists(tempUploadFolder))
        {
            Directory.CreateDirectory(tempUploadFolder);
        }
        var r = new System.Collections.Generic.List<ViewDataUploadFilesResult>();
        System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
        foreach (string file in context.Request.Files)
        {
            HttpPostedFile hpf = context.Request.Files[file] as HttpPostedFile;
            string FileName = string.Empty;
            if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
            {
                string[] files = hpf.FileName.Split(new char[] { '\\' });
                FileName = files[files.Length - 1];
            }
            else
            {
                FileName = hpf.FileName;
            }
            if (hpf.ContentLength == 0)
                continue;
            string savedFileName = string.Format("{0}//{1}", tempUploadFolder, FileName);
            hpf.SaveAs(savedFileName);

            try
            {
                string csvUploadDirectory = context.Server.MapPath(System.Configuration.ConfigurationSettings.AppSettings["CSVUploadPath"]);

                //foreach (string filePath in Directory.GetFiles(tempUploadFolder))
                //{
                //Copy ctl files to temp path
                // File.Copy(string.Format("{0}\\csv.ctl", ctlFolder), string.Format("{0}\\csv.ctl", tempUploadFolder));
                string fileName = Path.GetFileName(savedFileName);

                try
                {
                    string newFilePath = csvUploadDirectory + "\\" + fileName;

                    if (File.Exists(newFilePath))
                    {
                        fileName = Path.GetFileNameWithoutExtension(fileName) + "_" + DateTime.Now.ToString("ddMMyyyHHmmss") + Path.GetExtension(fileName);
                        newFilePath = csvUploadDirectory + "\\" + fileName;
                    }

                    File.Copy(savedFileName, newFilePath);

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
                    Directory.Delete(tempUploadFolder, true);
                }


            }
            catch (Exception) { }
            r.Add(new ViewDataUploadFilesResult()
            {
                //Thumbnail_url = savedFileName,
                Name = FileName,
                Length = hpf.ContentLength,
                Type = hpf.ContentType
            });
            var uploadedFiles = new
            {
                files = r.ToArray()
            };
            var jsonObj = js.Serialize(uploadedFiles);
            //jsonObj.ContentEncoding = System.Text.Encoding.UTF8;
            //jsonObj.ContentType = "application/json;";
            // context.Response.Redirect("Demo.aspx");
            context.Response.Write(jsonObj.ToString());
        }
        
    
    }
   
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public class ViewDataUploadFilesResult
    {
        public string Thumbnail_url { get; set; }
        public string Name { get; set; }
        public int Length { get; set; }
        public string Type { get; set; }
    }

}