using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreateUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["sesuUserDetails"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!Page.IsPostBack)
        {
            BindGroupDropdown();
            BindUserTypeDropdown();

            trDivision.Visible = false;
            trSubDivision.Visible = false;
            trSection.Visible = false;
            if (Request.QueryString["Id"] != null)
            {
                PopulateData(Request.QueryString["Id"].ToString());
            }

        }
    }

    void PopulateData(string id)
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = string.Format("Select USERID,USERNAME,USERPASSWORD,SECURITYQUESTION,ANSWER,GROUPID from Users where USERID={0}", id);
        cmdGet.Connection = connection;
        var userData = cmdGet.ExecuteReader();
        while (userData.Read())
        {
             txtUsername.Text = userData.GetValue(1).ToString();
            string Password = userData.GetValue(2).ToString();
            txtPassword.Attributes.Add("value", Password);
            txtConfirmpassword.Attributes.Add("value", Password);
             txtQuestion.Text = userData.GetValue(3).ToString();
            
            txtAnswer.Text = userData.GetValue(4).ToString();
            ddlGroup.SelectedValue = userData.GetValue(5).ToString();
            hdnUserID.Value = userData.GetValue(0).ToString();
           
           
           // ddlGroup.Items.Add(new ListItem(userData.GetValue(1).ToString(), userData.GetValue(0).ToString()));
        }
        connection.Close();
    }



    void BindUserTypeDropdown()
    {
        IList<string> types = new List<string>()
        {
            "Admin",
            "Division",
            "Sub Division",
            "Section",
        };

        ddlUserType.DataSource = types;
        ddlUserType.DataBind();
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToInt32(hdnUserID.Value) > 0)
            {
                UpdateUser();
            }
            else
            {
                SaveUser();
            }
           
        }
        catch (Exception ex)
        {
            lblresult.Text = "Error occured. \n\n Details:" + ex.Message;
        }
    }

    private void SaveUserArea()
    {
        string userName = txtUsername.Text;
        string userType = ddlUserType.SelectedValue;

        string areaID = "000000";

        if (ddlUserType.SelectedValue.Equals("Division"))
        {
            areaID = ddlDivision.SelectedValue;
        }
        else if (ddlUserType.SelectedValue.Equals("Sub Division"))
        {
            areaID = ddlSubDivision.SelectedValue;
        }
        else if (ddlUserType.SelectedValue.Equals("Section"))
        {
            areaID = ddlSection.SelectedValue;
        }

        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        connection.Open();
        IDbCommand cmdInsert = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdInsert.CommandText = string.Format("INSERT INTO UserArea (UserName,UserType,AreaID) VALUES('{0}','{1}','{2}')", userName, userType, areaID);
        cmdInsert.Connection = connection;
        cmdInsert.ExecuteNonQuery();
        connection.Close();
    }

    protected void ddlUserType_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDivisionDropDown();

        if (ddlUserType.SelectedValue.Equals("Admin"))
        {
            trDivision.Visible = false;
            trSubDivision.Visible = false;
            trSection.Visible = false;
        }
        else if (ddlUserType.SelectedValue.Equals("Division"))
        {
            trDivision.Visible = true;
            trSubDivision.Visible = false;
            trSection.Visible = false;
        }
        else if (ddlUserType.SelectedValue.Equals("Sub Division"))
        {
            trDivision.Visible = true;
            trSubDivision.Visible = true;
            trSection.Visible = false;
        }
        else if (ddlUserType.SelectedValue.Equals("Section"))
        {
            trDivision.Visible = true;
            trSubDivision.Visible = true;
            trSection.Visible = true;
        }
    }

    private void BindDivisionDropDown()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = "SELECT DIVISION_CODE, DIV_NAME FROM tbl_Division";
        cmdGet.Connection = connection;
        var data = cmdGet.ExecuteReader();
        while (data.Read())
        {
            ddlDivision.Items.Add(new ListItem(data.GetValue(1).ToString(), data.GetValue(0).ToString()));
        }
        connection.Close();
    }

    private void BindSubDivisionDropDown()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = "SELECT DIVISION_CODE, DIV_NAME FROM tbl_Division";
        cmdGet.Connection = connection;
        var data = cmdGet.ExecuteReader();
        while (data.Read())
        {
            ddlDivision.Items.Add(new ListItem(data.GetValue(1).ToString(), data.GetValue(0).ToString()));
        }
        connection.Close();
    }

    private void BindSectionDropDown()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = "SELECT DIVISION_CODE, DIV_NAME FROM tbl_Division";
        cmdGet.Connection = connection;
        var data = cmdGet.ExecuteReader();
        while (data.Read())
        {
            ddlDivision.Items.Add(new ListItem(data.GetValue(1).ToString(), data.GetValue(0).ToString()));
        }
        connection.Close();
    }

    protected void ddlDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = string.Format("SELECT SUB_DIV_CODE, SUB_DIV_NAME FROM tbl_Sub_Division WHERE DIVISION_CODE = '{0}'", ddlDivision.SelectedValue);
        cmdGet.Connection = connection;
        var data = cmdGet.ExecuteReader();
        while (data.Read())
        {
            ddlSubDivision.Items.Add(new ListItem(data.GetValue(1).ToString(), data.GetValue(0).ToString()));
        }
        connection.Close();
    }

    protected void ddlSubDivision_SelectedIndexChanged(object sender, EventArgs e)
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        connection.Open();
        IDbCommand cmdGet = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdGet.CommandText = string.Format("SELECT SEC_CODE, SEC_NAME FROM tbl_Section WHERE SUB_DIV_CODE = '{0}'", ddlSubDivision.SelectedValue);
        cmdGet.Connection = connection;
        var data = cmdGet.ExecuteReader();
        while (data.Read())
        {
            ddlSection.Items.Add(new ListItem(data.GetValue(1).ToString(), data.GetValue(0).ToString()));
        }
        connection.Close();
    }

    private void SaveUser()
    {
        IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
        connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        connection.Open();
        IDbCommand cmdInsert = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
        cmdInsert.CommandText = string.Format("INSERT INTO USERS (UserName,UserPassword,SecurityQuestion,Answer,GroupID) VALUES('{0}','{1}','{2}','{3}',{4})", txtUsername.Text, txtPassword.Text, txtQuestion.Text, txtAnswer.Text, ddlGroup.SelectedValue);
        cmdInsert.Connection = connection;
        cmdInsert.ExecuteNonQuery();
        connection.Close();

        SaveUserArea();

        lblresult.Text = "User Created Successfully";
    }
    private void UpdateUser()
    {
        try
        {
            IDbConnection connection = DataAccessLayer.DBManagerFactory.GetConnection(DataProvider.Oracle);
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            connection.Open();
            IDbCommand cmdInsert = DataAccessLayer.DBManagerFactory.GetCommand(DataProvider.Oracle);
            cmdInsert.CommandText = string.Format("Update USERS SET UserName='{0}',UserPassword='{1}',SecurityQuestion='{2}',Answer='{3}',GroupID={4} WHERE USERID={5}", txtUsername.Text, txtPassword.Text, txtQuestion.Text, txtAnswer.Text, ddlGroup.SelectedValue,hdnUserID.Value);
            cmdInsert.Connection = connection;
            cmdInsert.ExecuteNonQuery();
            connection.Close();
            lblresult.Text = "User Updated Successfully";

        }
        catch (Exception)
        {
            
            throw;
        }
    }
}