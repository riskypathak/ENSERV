using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CSVOutput
/// </summary>
public class CSVOutput
{
    public string SBMID { get; set; }
    public string CollectorName { get; set; }
    public string CollectorID { get; set; }
    public string ConsumerNo { get; set; }
    public DateTime DateofPayment { get; set; }
    public string TimeofPayment { get; set; }
    public double AmountCollected { get; set; }
    public string ReceiptNo { get; set; }
    public string ChequeNo { get; set; }
    public DateTime ChequeDate { get; set; }
    public string BankNameCode { get; set; }
    public string ManualBookNo { get; set; }
    public string ManualReceiptNo { get; set; }
    public string PaymentType { get; set; }
    public int InstallmentFlag { get; set; }
    public string UploadFlag { get; set; }
}