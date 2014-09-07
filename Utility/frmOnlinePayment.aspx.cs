using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utility_frmOnlinePayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dt =new DataTable();
            dt.Columns.Add("ReceiptNo");
            dt.Columns.Add("ConsumerNo");
            dt.Columns.Add("Amount");
            dt.Columns.Add("ConnectionId");
            dt.Columns.Add("ConsumerName");
            dt.Columns.Add("PaymentPurpose");
            dt.Columns.Add("PaymentReceipt");
            DataRow dr = dt.NewRow();
            dr["ReceiptNo"] = 123;
            dr["ConsumerNo"] = 0087;
            dr["Amount"] = 70;
            dr["ConnectionId"] = 1;
            dr["ConsumerName"] = "RJ";
            dr["PaymentPurpose"] = "Cash";
            dr["PaymentReceipt"] ="Invoice";
            dt.Rows.Add(dr) ;
            gdvconsumerdetails.DataSource = dt;
            gdvconsumerdetails.DataBind();
        }

        tblbankdetail.Attributes.Add("style", "display:none"); 
    }
}