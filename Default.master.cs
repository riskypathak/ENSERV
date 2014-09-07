using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.VisualBasic;
using System.Collections;
using System.Data;
using Utilities;  
using System.Data.OleDb;
using MKB;
using DataAccessLayer;    

public partial class _Default : System.Web.UI.MasterPage
{
    public string strItemSelection;
    public string strFolderSelection;
    public string strpreviousselection;
    public string strHintmessage;
    public string strpageName;
    // holds the stacktrace
    string strstacktrace = string.Empty;
   // CHtmlFolder m_CHtmlFolder;
    protected void Page_Load(object sender, System.EventArgs e)
    {
        CUSERDetails objUserDetails = new CUSERDetails();
        objUserDetails = (CUSERDetails)Session["sesuUserDetails"];
        if (!IsPostBack)
        {

        }
        string strFolderSelection = null;
        //CDatabase m_db = default(CDatabase);
        object objConnection = null;
        //PrivilegeStack m_UserPrivilegeStack = default(PrivilegeStack);
        //nodePrivilegeStack m_nodePrivilegeStack = default(nodePrivilegeStack);
        int i = 0;
        ///'''''''''''' Step 1 Check for User Session
        if (objUserDetails == null)
        {
            return;
        }
    }
}



