using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Site_UserList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["sesuUserDetails"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!Page.IsPostBack)
        {
            BindGrid();
        }
    }

    void BindGrid()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = "select u.*, g.GroupName  groupname  from users  u inner join usergroup  g on u.GroupID=g.GroupID";
        cmdGet.Connection = connection;
        var userData = cmdGet.ExecuteReader();
        DataTable dt= new DataTable();
        dt.Columns.Add(new DataColumn("UserId", System.Type.GetType("System.Int32")));
        dt.Columns.Add(new DataColumn("UserName", System.Type.GetType("System.String")));
        dt.Columns.Add(new DataColumn("Question", System.Type.GetType("System.String")));
        dt.Columns.Add(new DataColumn("Answer", System.Type.GetType("System.String")));
        dt.Columns.Add(new DataColumn("GroupName", System.Type.GetType("System.String")));
        while (userData.Read())
        {
            System.Data.DataRow dr = dt.NewRow();
            dt.Rows.Add(userData.GetValue(0), userData.GetValue(1), userData.GetValue(2), userData.GetValue(3), userData.GetValue(4));
        }
        rptUserList.DataSource = dt;
        rptUserList.DataBind();
       
    }
}