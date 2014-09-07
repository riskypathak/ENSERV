using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GroupPrivilgeMapping : System.Web.UI.Page
{
    private int groupId;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["sesuUserDetails"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            CUSERDetails objUserDetails = new CUSERDetails();
            objUserDetails = (CUSERDetails)Session["sesuUserDetails"];
            groupId = objUserDetails.iGroupID;
            BindGroupDropdown();
            BindUserTypeDropdown();
        }
    }
    void BindGroupDropdown()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = "Select GroupID, GroupName from UserGroup";
        cmdGet.Connection = connection;
        var groupData = cmdGet.ExecuteReader();
        while (groupData.Read())
        {
            ddlGroup.Items.Add(new ListItem(groupData.GetValue(1).ToString(), groupData.GetValue(0).ToString()));
        }
        connection.Close();
    }
    void BindUserTypeDropdown()
    {
        //IList<string> types = new List<string>()
        //{
        //    "Admin",
        //    "Division",
        //    "Sub Division",
        //    "Section",
        //};
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = "Select PRIVILEGEID, SCREENNAME from SCREENPRIVILEGE";
        cmdGet.Connection = connection;
        var privilegeData = cmdGet.ExecuteReader();
        while (privilegeData.Read())
        {
            ddlPrivileges.Items.Add(new ListItem(privilegeData.GetValue(1).ToString(), privilegeData.GetValue(0).ToString()));
        }

        //ddlPrivileges.DataSource = privilegeData;
        //ddlPrivileges.DataBind();
        connection.Close();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
           

            var selecteditems = String.Join(", ", ddlPrivileges.Items.Cast<ListItem>()
                                                .Where(i => i.Selected)
                                                .Select(i => i.Value));
           

            if (selecteditems != "")
            {
                IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
                connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

                connection.Open();
                /***Delete***/
                IDbCommand cmdDelete = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                cmdDelete.CommandText = string.Format("DELETE FROM GROUPPRIVILEGE WHERE GROUPID={0} ", ddlGroup.SelectedValue);
                cmdDelete.Connection = connection;
                cmdDelete.ExecuteNonQuery();
                /***End***/


                var privilegeIds = selecteditems.Split(',');
                foreach (var item in privilegeIds)
                {
                    IDbCommand cmdInsert = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
                    cmdInsert.CommandText = string.Format("INSERT INTO GROUPPRIVILEGE (GROUPID,PRIVILEGEID) VALUES({0},{1})", ddlGroup.SelectedValue, item);
                    cmdInsert.Connection = connection;
                    cmdInsert.ExecuteNonQuery();
                }

                connection.Close();
                lblMsg.Visible = true;
            }
           

        }
        catch (Exception)
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Privileges Not Assigned Successfully.";
           
            throw;
        }


       
    }
}