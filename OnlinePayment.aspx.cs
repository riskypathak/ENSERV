using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PrintReceipt;

public partial class OnlinePayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           // PopulateConsumerDetails();
            PopulateBankDetails();
            PopulatePaymentPurpose();
            PopulatePaymentMode();
            //ddlConsumerNo_SelectedIndexChanged(null, null);
        }

        txtPaymentDateTime.Text = DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt");
    }

    private void PopulatePaymentPurpose()
    {
        IList<string> purposes = new List<string>()
        {
            "Invoice",
            "Security Deposit",
            "Processing Fee",
            "Estimation Fee",
            "Re Connection",
            "Dis Connection",
            "Meter Cost",
            "Meter Testing Fee",
            "Static Meter Report Fee",
            "Additional Security Deposit Fee",
            "Inspection Fee",
            "Meter Equipment Fee",
            "Others",
            "Service Connection Fees"
        };

        ddlPaymentPurpose.DataSource = purposes;
        ddlPaymentPurpose.DataBind();
    }

    private void PopulatePaymentMode()
    {
        IList<string> purposes = new List<string>()
        {
             "Cash",
            "Cheque"
           
        };

        ddlPaymentMode.DataSource = purposes;
        ddlPaymentMode.DataBind();
    }

    private void PopulateConsumerDetails()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        connection.Open();

        IDbCommand cmdGetConsumerDetails = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGetConsumerDetails.CommandText =string.Format("SELECT CONS_ACC, CONS_NAME FROM TBL_CONSMAST WHERE CONS_ACC={0}",txtConsumerNumber.Text);
        cmdGetConsumerDetails.Connection = connection;

        DataSet dsConsumer = new DataSet();
        IDbDataAdapter adapter = DataAccessLayer.DBManagerFactory.GetDataAdapter(DataProvider.Oracle);
        adapter.SelectCommand = cmdGetConsumerDetails;
        adapter.Fill(dsConsumer);

        connection.Close();

        //ddlConsumerNo.DataSource = dsConsumer.Tables[0];
       // ddlConsumerNo.DataTextField = "CONS_ACC";
       // ddlConsumerNo.DataValueField = "CONS_ACC";
       // ddlConsumerNo.DataBind();
    }

    private void PopulateBankDetails()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        connection.Open();

        IDbCommand cmdGetBankDetails = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGetBankDetails.CommandText = "SELECT * FROM tbl_bank_det";
        cmdGetBankDetails.Connection = connection;

        DataSet dsbank = new DataSet();
        IDbDataAdapter adapter = DataAccessLayer.DBManagerFactory.GetDataAdapter(DataProvider.Oracle);
        adapter.SelectCommand = cmdGetBankDetails;
        adapter.Fill(dsbank);

        connection.Close();

        ddlbankID.DataSource = dsbank.Tables[0];
        ddlbankID.DataTextField = "SHORTNAME";
        ddlbankID.DataValueField = "BANK_CODE";
        ddlbankID.DataBind();
    }
    //protected void ddlConsumerNo_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
    //    connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

    //    connection.Open();

    //    IDbCommand cmdGetConsumerDetails = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
    //    cmdGetConsumerDetails.CommandText = string.Format("SELECT CONS_ACC, CONS_NAME FROM TBL_CONSMAST  WHERE cons_acc = '{0}'", ddlConsumerNo.SelectedValue);
    //    cmdGetConsumerDetails.Connection = connection;

    //    IDataReader reader = cmdGetConsumerDetails.ExecuteReader();

    //    while (reader.Read())
    //    {
    //        txtConnectionID.Text = Convert.ToString(reader[0]);
    //        txtConsumerName.Text = Convert.ToString(reader[1]);
    //    }

    //    connection.Close();
    //}
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string recieptNo = string.Empty;

        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();

        IDbCommand cmdGetRecieptNo = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGetRecieptNo.CommandText = "SELECT seq_tbl_payment.NEXTVAL from dual";
        cmdGetRecieptNo.Connection = connection;

        recieptNo = Convert.ToString(cmdGetRecieptNo.ExecuteScalar());

        IDbCommand cmdInsertCSVPayment = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdInsertCSVPayment.CommandText = string.Format("INSERT INTO tbl_Payment(ConnectionID, CUSTNAME, RECEIPTNUMBER, MANUALRECEIPTNO, AMOUNT, BANKID, SEC_CODE, SUB_DIV_CODE, DIV_CODE, PAYMENTDATETIME, PAYMENTMODES, PAYMENTPURPOSE, REMARKS, CREATEDDATETIME, CREATEDBY, TICKETNUMBER, CHEQUENO, CHEQUEDATE)" +
            "VALUES('{0}', '{1}', {2}, {3}, {4}, '{5}', '{6}', '{7}', '{8}', {9}, '{10}', '{11}', '{12}', {13}, '{14}', {15}, '{16}', {17})"
            , txtConnectionID.Text, //ConnectionID
            txtConsumerName.Text,
recieptNo,
recieptNo,
Convert.ToDouble(txtAmount.Text), // AMount
ddlbankID.SelectedValue,
"000001", //Sec Code
"000001", //Sub Div Code
"000001", //div Code
string.Format("TO_DATE('{0}', 'yyyymmdd hh24:mi:ss')", Convert.ToDateTime(txtPaymentDateTime.Text).ToString("yyyyMMdd HH.mm.ss")), // payment date
ddlPaymentMode.SelectedValue, //payment Type
        ddlPaymentPurpose.SelectedValue, //payment purpose
        txtRemarks.Text,
string.Format("TO_DATE('{0}', 'yyyymmdd hh24:mi:ss')", DateTime.Now.ToString("yyyyMMdd HH.mm.ss")), //Created Time
"ADMIN", //CreatedBy
recieptNo, //Ticket Number
txtInstrumentNo.Text, //Cheque NO
txtInstrumentDate.Text// Cheque Date
);

        cmdInsertCSVPayment.Connection = connection;
        cmdInsertCSVPayment.ExecuteNonQuery();

        connection.Close();

        Session["receiptdetails"] = GetRecieptDetails(recieptNo);

        btnSubmit.Enabled = false;
    }

    protected string GetRecieptDetails(string recieptNumber)
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        connection.Open();

        IDbCommand cmdGetConsumerDetails = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGetConsumerDetails.CommandText = "SELECT receiptnumber, paymentdatetime, div_name, SUB_DIV_NAME, SEC_NAME, connectionid, custname, paymentpurpose, amount, manualreceiptno, paymentdatetime, paymentmodes, bankid, chequeno, chequedate FROM tbl_Payment, tbl_division, tbl_sub_division, tbl_section WHERE tbl_payment.div_code = tbl_division.division_code AND tbl_payment.sub_div_code = tbl_sub_division.sub_div_code AND tbl_payment.sec_code = tbl_section.sec_code AND receiptnumber = " + recieptNumber;
        cmdGetConsumerDetails.Connection = connection;
        DataSet dsConsumer = new DataSet();
        IDbDataAdapter adapter = DataAccessLayer.DBManagerFactory.GetDataAdapter(DataProvider.Oracle);
        adapter.SelectCommand = cmdGetConsumerDetails;
        adapter.Fill(dsConsumer);

        connection.Close();

        DataRow row = dsConsumer.Tables[0].Rows[0];

        string details = string.Empty;
        foreach (DataColumn column in dsConsumer.Tables[0].Columns)
        {
            details += Convert.ToString(row[column]) + "}";
        }

        return details;
        //Response.Redirect(string.Format("javascript:window.location = 'ensrv://{0}'",details));
    }
    protected void btnsearchConsumer_Click(object sender, EventArgs e)
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        connection.Open();

        IDbCommand cmdGetConsumerDetails = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGetConsumerDetails.CommandText = string.Format("SELECT CONS_ACC, CONS_NAME FROM TBL_CONSMAST  WHERE cons_acc = '{0}'", txtConsumerNumber.Text);
        cmdGetConsumerDetails.Connection = connection;

        IDataReader reader = cmdGetConsumerDetails.ExecuteReader();

        while (reader.Read())
        {
            txtConnectionID.Text = Convert.ToString(reader[0]);
            txtConsumerName.Text = Convert.ToString(reader[1]);
        }

        connection.Close();
    }
}