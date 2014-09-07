using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using DataAccessLayer;      

using System.Configuration;

public partial class Login : System.Web.UI.Page
{
		// this string object is for Framing  Query to the database Dynamically
	string strQry = string.Empty;
		// Hold database Connection Object
	object objconnection = null;
		// = Nothing        ' Primary object for CDatabase which performs communication with database
    IDBManager m_db;  
		//Holds the recordset object 
	DataSet objDataset = null;
		// holds the stacktrace
	string strstacktrace = string.Empty;
    

	protected void Page_Load(object sender, System.EventArgs e)
	{

	}


	protected void btnlogin_Click(object sender, EventArgs e)
	{
		int iRecordsFetched = 0;
		int iTempGroupID = 0;
		m_db = new DBManager(DataProvider.Oracle);

		if (m_db == null) {
			Response.Redirect("Error_page.aspx?ERROR=UNABLE_CREATE_DBOBJ");
		}

		///''''''''''''If user clicked on login button check for username,password and selecttype are filled or not if they are not empty then proceed


		if (txtuser.Value.Length != 0 & txtpwd.Value.Length != 0) {
			m_db.ConnectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;


			m_db.Open();


			if (m_db.Connection == null) {
				///''''''' If Failed to Eastablish database Connection Show Error Page to the User

				//  strstacktrace = HttpUtility.UrlEncode(m_db.Exception_str)
				strstacktrace = "";
				Response.Redirect("Error_page.aspx?ERROR=DATABASE_CONNECTION_FAILED&MESSAGE=" + strstacktrace);



			}

			///''''''''''' Form the query to get the login userdetails from tbl_usermaster


			//     strQry = "select tbl_usermaster.userid,tbl_usermaster.usertypeflag,tbl_usermaster.webaccountflag,usersmemberslink.memberid,upper(username) as username,grp.groupid,grp.groupname from tbl_usermaster inner join  groupe as grp on tbl_usermaster.groupid=grp.groupid inner join usersmemberslink on tbl_usermaster.userid=usersmemberslink.userid where username='" & txtuser.Value.Trim() & "' and password='" & txtpwd.Value.Trim() & "'   and tbl_usermaster.activated=1 and tbl_usermaster.webaccountflag=1"
			//strQry = "select usermaster.userid,usermaster.usertypeflag,usermaster.webaccountflag,upper(username) as username,grp.groupid,grp.groupname from usermaster inner join  groupe as grp on usermaster.groupid=grp.groupid where username='" + txtuser.Value.Trim() + "' and password='" + txtpwd.Value.Trim() + "' and usermaster.activated=1 and usermaster.webaccountflag=1";
            //strQry = "select usermaster.userid,upper(username) as username from usermaster ";// where username='" + txtuser.Value.Trim() + "' and password='" + txtpwd.Value.Trim() + "'";
            strQry = string.Format("select users.userid,upper(username) as username,groupid from users where username='{0}' and userpassword='{1}'", txtuser.Value, txtpwd.Value);
			objDataset = m_db.ExecuteDataSet(CommandType.Text, strQry);


			if (objDataset == null) {
				m_db.Close();
				m_db.Dispose();
				// strstacktrace = HttpUtility.UrlEncode(m_db.Exception_str)
				Response.Redirect("Error_page.aspx?ERROR=RECORDSET_FETCH_FAILED&MESSAGE=" + strstacktrace);
			}

			///'''''''''''''' get the no of records that exsist for the framed query

			iRecordsFetched = int.Parse(objDataset.Tables[0].Rows.Count.ToString());

			///''''''''''''' if no records present give msg to the user alerting him that he is invalid user

			if (iRecordsFetched == 0) {
				
				txtuser.Focus();

			} else {
				///'''''''''''' if records present get all the userdetails and store them inside a session

				CUSERDetails objUserDetails = new CUSERDetails();
				objUserDetails.iUserID = Convert.ToInt32(objDataset.Tables[0].Rows[0]["userid"].ToString());
				objUserDetails.strUserName = objDataset.Tables[0].Rows[0]["username"].ToString();
				objUserDetails.iGroupID = Convert.ToInt32(objDataset.Tables[0].Rows[0]["groupid"]);
				//objUserDetails.strGroupName = objDataset.Tables[0].Rows[0]["groupname"].ToString();
				objUserDetails.iMemberID = "1";
				//objDataset.Tables(0).Rows(0)("memberid").ToString()
				//objUserDetails.iRooterFlag = Convert.ToInt32(objDataset.Tables[0].Rows[0]["usertypeflag"]);
				//objUserDetails.iWebAccountFlag = Convert.ToInt32(objDataset.Tables[0].Rows[0]["webaccountflag"]);

				//objUserDetails.iUserID = CType(objDataset.Tables(0).Rows(0)("userid").ToString(), Integer)
				//objUserDetails.strUserName = objDataset.Tables(0).Rows(0)("username").ToString()
				//objUserDetails.iGroupID = 4 ' CType(objDataset.Tables(0).Rows(0)("groupid"), Integer)
				//objUserDetails.strGroupName = objDataset.Tables(0).Rows(0)("groupname").ToString()
				//objUserDetails.iMemberID = 1 'objDataset.Tables(0).Rows(0)("memberid").ToString()
				//objUserDetails.iRooterFlag = 1 'CType(objDataset.Tables(0).Rows(0)("usertypeflag"), Integer)
				//objUserDetails.iWebAccountFlag = 1 'CType(objDataset.Tables(0).Rows(0)("webaccountflag"), Integer)
				Session["sesuUserDetails"] = objUserDetails;

				objDataset.Dispose();
				// Free dataset
				m_db.Close();
				// Free SQL Connection

				iTempGroupID = objUserDetails.iGroupID;


				objUserDetails = null;
				m_db = null;


                //Response.Redirect("~/frmNewConnection.aspx");
               Response.Redirect("SBMUpload.aspx");
						
				}

			}

		}

	}
    //private void DisplayClientMessage(string errorDesc)
    //{
    //    string script = "alert('" + errorDesc + "');";
    //    Page.ClientScript.RegisterStartupScript(this.GetType(), "meKey", script, true);
    //}

    //private void Login1_Unload(object sender, EventArgs e)
    //{
    //    this.Dispose();
    //}
    //public void Login1()
    //{
    //    Unload += Login1_Unload;
    //    Load += Page_Load;
    //}


//}


