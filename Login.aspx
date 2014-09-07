<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>FEDCO Login Page</title>
    <link rel="stylesheet" type="text/css" href="login_style.css">
    <!-- Style Form Login Page-->
    
    <style type="text/css">

label{
float: left;
width: 80px;
font-weight: bold;
}

input, textarea, select{
width: 54px;
margin-bottom: 5px;
font:normal 10px 'verdana' arial;
color:#666;
text-align:left;
border:1px solid #99c;
background: #f2efef !important;

}

#submitbutton{
margin-left:5px;
margin-top: 20px;
width:50px;
text-align:center;
border:1px solid #99c;

	
}
.button{
text-align:center;
            height: 18px;
        }

br{
clear: both;
}
.left
{display:inline;
margin-top:-5px;
}

#frame {
  position:relative;
  margin: 0px auto;
  padding: 0px;
 /* height:329px;*/
  width:600px;
  background:url('images/Login.png') no-repeat;
  
}
#main{
font:normal 10px 'verdana' arial;
color:#666;
}
 A:link, A:visited, A:active { color: blue; text-decoration:
underline }



        .auto-style7
        {
            height: 12px;
        }
        .auto-style8
        {
            width: 17%;
            height: 12px;
        }



        .auto-style12
        {
            width: 14%;
            height: 12px;
        }
        .auto-style14
        {
            width: 14%;
            height: 20px;
        }
        .auto-style15
        {
            width: 17%;
            height: 20px;
        }
        .auto-style16
        {
            height: 20px;
        }
        .auto-style19
        {
            width: 14%;
            height: 15px;
        }
        .auto-style20
        {
            width: 17%;
            height: 15px;
        }
        .auto-style21
        {
            height: 15px;
        }
        .auto-style25
        {
            width: 14%;
            height: 13px;
        }
        .auto-style26
        {
            width: 17%;
            height: 13px;
        }
        .auto-style27
        {
            height: 13px;
        }
        .auto-style37
        {
            width: 14%;
            height: 30px;
        }
        .auto-style38
        {
            width: 17%;
            height: 30px;
        }
        .auto-style39
        {
            height: 30px;
        }
        .auto-style40
        {
            width: 14%;
            height: 21px;
        }
        .auto-style41
        {
            width: 17%;
            height: 21px;
        }
        .auto-style42
        {
            height: 21px;
        }
        


        .auto-style46
        {
            width: 14%;
            height: 2px;
        }
        .auto-style47
        {
            width: 17%;
            height: 2px;
        }
        .auto-style48
        {
            height: 2px;
        }
        .auto-style52
        {
            height: 20px;
            width: 39%;
        }
        .auto-style53
        {
            width: 39%;
        }
        .auto-style54
        {
            height: 15px;
            width: 39%;
        }
        .auto-style55
        {
            height: 12px;
            width: 39%;
        }
        .auto-style56
        {
            height: 21px;
            width: 39%;
        }
        .auto-style57
        {
            height: 30px;
            width: 39%;
        }
        .auto-style58
        {
            height: 13px;
            width: 39%;
        }
        .auto-style60
        {
            height: 2px;
            width: 39%;
        }
        


        .auto-style61
        {
            height: 9px;
        }
        .auto-style62
        {
            width: 17%;
        }
        .auto-style63
        {
            height: 9px;
            width: 17%;
        }
        .auto-style64
        {
            height: 9px;
            width: 14%;
        }
        


    </style>
  
    <script language="javascript" type="text/javascript">


        function killses() {

        }

        function print() {
            var qz = document.getElementById('qz');
            qz.append('A37,503,0,1,2,3,N,PRINTED USING QZ-PRINT\n');
            // ZPLII
            // qz.append('^XA^FO50,50^ADN,36,20^FDPRINTED USING QZ-PRINT^FS^XZ');  
            qz.print();
        }
        function SetLogoutCookie(bcookieValue) {

            //Cookie Expiry Script By Balakrishna

            var exdate = new Date();
            var expires = ""
            exdate.setDate(exdate.getDate() + 1);
            expires = "; expires=" + exdate.toGMTString();
            document.cookie = "logout=" + bcookieValue + expires + "; path=/";

        }
        //function uservalidation() {
        //    SetLogoutCookie('false');
        //    if (document.getElementById("txtuser").value == "") {
        //        alert("Enter User Name..")
        //        document.getElementById("txtuser").focus()
        //        return false;
        //    }
        //    else if (document.getElementById("txtpwd").value == "") {
        //        alert("Enter Password..")
        //        document.getElementById("txtpwd").focus()
        //        return false;
        //    }

        //    return true;
        //}
        /**
	* Optionally used to deploy multiple versions of the applet for mixed
	* environments.  Oracle uses document.write(), which puts the applet at the
	* top of the page, bumping all HTML content down.
	*/
        function RunEXE() {
            var oShell = new ActiveXObject("WScript.Shell");
            var prog = "C:\\temp\\PrintDOS.exe" + ' "' + "MoneyReceiptNo}PayDate}Division}SubDivision}Section}ConsumerNo}ReceivedFrom}PaymentType}Amount}AmountWord}ManualReceiptNo}Manual_Receipt_Date}PymentMode}BankName}ChequeNo}ChequeDate" + '"';
            oShell.Run('"' + prog + '"', 1);
        }
    </script>
 
</head>
<!-- Cookie Kill Function Called in Page Load Method-->
<body onload="killses();" >
    <form id="form1" runat="server">
        <div class="topdiv">
        </div>
        <center>
            <div id="frame">
                 <table cellpadding="0" cellspacing="0" width="100%" height="100%">
                             
                                <tr>
                                    <td style="width: 19%; height: 134px;">
                                    </td>
                                    <td align="top" width="80%" style="height: 134px">
                                       <div id="main" style="display: table;">
                                            <table cellpadding="0" cellspacing="0" height="100%" width="100%">
                                                <tr>
                                                    <td class="auto-style14">
                                                    </td>
                                                    <td align="right" class="auto-style15">
                                                       
                                                    </td>
                                                    <td align="left" class="auto-style52" >
                                                      
                                                    </td>
                                                    <td width="20%" align="left" class="auto-style16" >
                                                      
                                                        &nbsp;</td>
                                                    <td width="20%" align="left" class="auto-style16" >
                                                      
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <!--Password Section-->
                                                    <!-- User Name Section-->
                                                    <td class="auto-style12">
                                                    </td>
                                                    <td align="right" class="auto-style62">
                                                        &nbsp;</td>
                                                    <td class="auto-style53">
                                                        &nbsp;</td>
                                                    <td width="60%">
                                                        &nbsp;</td>
                                                    <td width="60%">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style19">
                                                    </td>
                                                    <td align="right" class="auto-style20">
                                                    </td>
                                                    <td class="auto-style54">
                                                    </td>
                                                    <td width="60%" class="auto-style21">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style21">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                    </td>
                                                    <td class="auto-style8">
                                                    </td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style7">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style7">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style40">
                                                    </td>
                                                    <td class="auto-style41">
                                                    </td>
                                                    <td class="auto-style56">
                                                    </td>
                                                    <td width="60%" class="auto-style42">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style42">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        </td>
                                                    <td class="auto-style8">
                                                        </td>
                                                    <td class="auto-style55">
                                                        </td>
                                                    <td width="60%" class="auto-style7">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style7">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style37">
                                                        </td>
                                                    <td class="auto-style38">
                                                        </td>
                                                    <td class="auto-style57">
                                                        </td>
                                                    <td width="60%" class="auto-style39">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style39">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style25">
                                                        </td>
                                                    <td class="auto-style26">
                                                        </td>
                                                    <td class="auto-style58">
                                                        </td>
                                                    <td width="60%" class="auto-style27">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style27">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style14">
                                                        </td>
                                                    <td class="auto-style15">
                                                        </td>
                                                    <td class="auto-style52">
                                                        </td>
                                                    <td width="60%" class="auto-style16">
                                                        </td>
                                                    <td width="60%" class="auto-style16">
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style46">
                                                        </td>
                                                    <td align="right" class="auto-style47">
                                                        <asp:Label ID="lblusername" runat="Server" Text="User Name:  " Font-Bold="True" Width="88px"></asp:Label>&nbsp;
                                                    </td>
                                                    <td class="auto-style60">
                                                        <input id="txtuser" runat="server" type="text" autocomplete="off" style="width: 146px" />
                                                        <asp:requiredfieldvalidator errormessage="Required" controltovalidate="txtuser" runat="server"/>
                                                    </td>
                                                    <td width="60%" class="auto-style48">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style48">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style14">
                                                        </td>
                                                    <td align="right" class="auto-style15">
                                                        <asp:Label ID="lblpwd" runat="server" Font-Bold="True" Text="Password: "></asp:Label>&nbsp;
                                                    </td>
                                                    <td class="auto-style52">
                                                        <input id="txtpwd" type="password" runat="server" style="width: 146px" />
                                                        <asp:requiredfieldvalidator errormessage="Required" controltovalidate="txtpwd" runat="server"/>
                                                    </td>
                                                    <td width="60%" class="auto-style16">
                                                        &nbsp;</td>
                                                    <td width="60%" class="auto-style16">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style64" >
                                                        </td>
                                                    <td class="auto-style63" >
                                                    </td>
                                                    <td class="auto-style61" >
                                                        <asp:Button ID="btnlogin" runat="server"  Text="Login" Width="60px"  CssClass="button" OnClick="btnlogin_Click" />
                                                       &nbsp;</td>
                                                    <td width="60%" class="auto-style61">
                                                        </td>
                                                    <td width="60%" class="auto-style61">
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                    </td>
                                                    <td class="auto-style55">
                                                        <a href="ForgotPassword.aspx">Forgot your password?</a>
                                                    </td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style12">
                                                        &nbsp;</td>
                                                    <td class="auto-style8">
                                                        &nbsp;</td>
                                                    <td class="auto-style55">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                    <td width="60%" style="height: 12px">
                                                        &nbsp;</td>
                                                </tr>
                                            </table>
                                      </div>
                                    </td>
                                </tr>
                            </table>
            </div>
        </center>
         <script language="javascript" type="text/javascript">
             document.getElementById('frame').style.height = '329px';

             if (navigator.appName == "Netscape") {

                 document.getElementById('frame').style.height = '600px';
             }
             else {
                 document.getElementById('frame').style.height = '329px';
             }
    </script>
    </form>
</body>
</html>
