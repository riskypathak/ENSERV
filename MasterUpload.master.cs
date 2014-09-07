using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class MasterUpload : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //this.Form.Action += "?id=" + Session.SessionID;
        if (!Page.IsPostBack)
        {
            GetPagePrivilege();
        }
    }

    private void GetPagePrivilege()
    {
        try
        {
            IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string screenName = Path.GetFileName(Request.Url.AbsolutePath);
            connection.Open();
            IDbCommand cmdPrivilege = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
            cmdPrivilege.CommandText = string.Format("SELECT PRIVILEGEID FROM SCREENPRIVILEGE WHERE SCREENNAME='{0}'", screenName.ToUpper());
            cmdPrivilege.Connection = connection;
            int privilegeId = cmdPrivilege.ExecuteScalar() == null ? 0 : Convert.ToInt32(cmdPrivilege.ExecuteScalar());

            CUSERDetails objUserDetails = new CUSERDetails();
            objUserDetails = (CUSERDetails)Session["sesuUserDetails"];
            IDbCommand cmdGroup = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
            cmdGroup.CommandText = string.Format("SELECT * FROM GROUPPRIVILEGE WHERE GROUPID={0} AND PRIVILEGEID={1}", objUserDetails.iGroupID, privilegeId);
            cmdGroup.Connection = connection;
            //int privilegeId = (int)cmdInsert.ExecuteScalar();
            int Id = cmdGroup.ExecuteScalar() == null ? 0 : Convert.ToInt32(cmdGroup.ExecuteScalar());
            connection.Close();
            if (Id <= 0)
            {
                Response.Redirect("Error.aspx");
            }
       

        }
        catch (Exception ex)
        {
            
            throw ex;
        }

        
    }
}
