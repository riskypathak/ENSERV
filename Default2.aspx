<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>




<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<title>New Ticket Creation</title>
<!-- Script for User Validation-->
<script language="javascript" type="text/javascript">
    function InsertDate() {
        var frmdate = document.getElementById('<%=txtFromDate.ClientID%>');
        var todate = document.getElementById('<%=txtToDate.ClientID%>');
        var rbl = document.getElementById('<%=rdbTemporary.ClientID%>');

        if (rbl.checked) {
            if (isValidDate(frmdate.value) == '' || isValidDate(frmdate.value) == null)
                alert('enter fromdate');
            if (isValidDate(todate.value) == '' || isValidDate(todate.value) == null)
                alert('enter todate');
            return false;
        }
    }
    function uservalidation() {
        // document.getElementById('hidden1').value = 2;

        if (document.getElementById("cmbDivision").value == "--Select--") {
            alert("Select Division")
            document.getElementById("cmbDivision").focus()
            return false;
        }
        else if (document.getElementById("cmbSubdivision").value == "--Select--") {
            alert("Select Sub Division")
            document.getElementById("cmbSubdivision").focus()
            return false;
        }
        else if (document.getElementById("cmbSection").value == "--Select--") {
            alert("Select Section")
            document.getElementById("cmbSection").focus()
            return false;
        }
        else if (document.getElementById("cmbSectionIncharge").value == "--Select--") {
            alert("Select Section Incharge")
            document.getElementById("cmbSectionIncharge").focus()
            return false;
        }
        else if (document.getElementById("txtConsumerName").value == "") {
            alert("Enter Consumer Name..")
            document.getElementById("txtConsumerName").focus()
            return false;
        }
        else if (document.getElementById("txtconsMobile").value == "") {
            alert("Enter Consumer Mobile Number")
            document.getElementById("txtconsMobile").focus()
            return false;
        }
        else if (document.getElementById("txtaddress").value == "") {
            alert("Enter Address")
            document.getElementById("txtaddress").focus()
            return false;
        }
        else if (document.getElementById("rdbTemporary").checked) {
            if (document.getElementById("txtFromDate").value == "") {
                alert('enter fromdate');
                document.getElementById("txtFromDate").focus()
                return false;
            }
            if (document.getElementById("txtToDate").value == "") {
                alert('enter todate');
                document.getElementById("txtToDate").focus()
                return false;
            }
        }
        return true;
    }
    function validatenumerics(key, value) {
        //getting key code of pressed key
        var keycode = (key.which) ? key.which : key.keyCode;
        //comparing pressed keycodes

        if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {

            return false;
        }
        else return true;
    }
    function isNumberKey(key) {
        //getting key code of pressed key
        var keycode = (key.which) ? key.which : key.keyCode;
        //comparing pressed keycodes

        if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 47) {
            alert(" You can enter only characters 0 to 9 ");
            return false;
        }
        else return true;
    }
    function datevalidation() {
        if (document.getElementById("txtday").value.length > 0) {
            if (document.getElementById("txtday").value > 31) {
                alert("Day Should Not greater than 31 days")
                document.getElementById("txtday").focus()
                return false;
            }
        }
        return true;
    }

    function numbersonly(e) {
        var unicode = e.charCode ? e.charCode : e.keyCode;
        if (unicode != 8) {
            if (unicode < 48 || unicode > 57)
                return false;
        }
    }

    function validateEmail(emailField) {
        var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
        if (reg.test(emailField.value) == false) {
            alert('Invalid Email Address');
            return false;
        }
        return true;

    }
</script>
     <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="../code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="../Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="../Scripts/calendar-en.min.js" type="text/javascript"></script>
    <link href="../Styles/calendar-blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('[id$=txtFromDate]').dynDateTime({
                showsTime: true,
                ifFormat: "%d-%m-%Y",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: true,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtToDate.ClientID%>").dynDateTime({
                showsTime: true,
                ifFormat: "%d-%m-%Y",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: true,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtTicketGeneratedDate.ClientID%>").dynDateTime({
                showsTime: true,
                ifFormat: "%d-%m-%Y",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: true,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
        });

    </script>
<link href="main.css" rel="stylesheet" />
    <style type="text/css">
        .button{
text-align:center;
cursor: hand;
font-family: Verdana;
top: 240px; 
font-size: 10px;
background-repeat:repeat-x;

}
        
        #btnreset
        {
            margin-top: 3px;
        }
       
       
        </style>
    <link href="css/Designcss.css" rel="stylesheet" />
</head>
<body onload="dis();" style="width: 98%;">

<form id="form2" runat="server"> 
    <asp:ScriptManager ID="sc1" runat="server"></asp:ScriptManager>  
<center>
<div>
      
<table width="750px" cellspacing="0" cellpadding="0" align="center">
<tr><td style="height:5px"></td></tr>
<tr><td>
<table width="750px" cellspacing="0" cellpadding="0" class="table" align="center">
 <tr>
  <td colspan="2" class="Header">&nbsp;&nbsp;&nbsp; Ticket Creation</td>            
 </tr>
    <tr><td colspan="2"><hr  style="color:#1a46b0"/></td></tr>
    
 <tr>
  <td width="50%" height="100%">
     <asp:Panel ID="panel1" runat="server" CssClass="panel">
     <table  width="100%" height="100%" cellspacing="0" cellpadding="0" class="table" align="center">
     <tr>
     <td class="Labeltext" width="37%">Ticket Type :<span style="color:Red ">*</span></td>
     <td style="font-size:8pt;height:30px" class="column">
      <asp:RadioButton ID="rdbNSC" runat="server" Checked="True" 
          Text="NSC" TabIndex="113" GroupName="TicketType" AutoPostBack="true" />
      <asp:RadioButton ID="rdbOther" runat="server"  Text="Others" 
           TabIndex="112" GroupName="TicketType"  AutoPostBack="true"/>
     </td>
          
     </tr>
         <tr>
             <td class="Labeltext">Source of Complaint:       <span style="color:Red ">*</span>   </td>
             <td style="font-size:8pt;height:30px" class="column">
                   <asp:RadioButton ID="rdbConsumer" runat="server" Checked="True" 
                        Text="Consumer" TabIndex="113" GroupName="ComplaintSource" />
            <asp:RadioButton ID="rdbOnM" runat="server" Text="O&amp;M"
                 TabIndex="112" GroupName="ComplaintSource" />
             </td>
         </tr>
         
         <tr>
             <td class="Labeltext">Ticket Registered Date:<span style="color:Red ">*</span> </td>
             <td class="column" align="left" style="padding-bottom:2px">
              <asp:TextBox id="txtTicketGeneratedDate" runat="server" maxlength="25" CssClass="Textbox" Width="70px" 
                  TabIndex="106"></asp:TextBox>&nbsp;<img id="img2" src="calender.png" />
             </td>
         </tr>
     <tr>
       <td class="Labeltext">Consumer Name :<span style="color:Red ">*</span></td>
       <td class="column">
           <asp:TextBox ID="txtConsumerName" runat="server" TabIndex="101" 
              Width="170px" MaxLength="60" CssClass="Textbox"></asp:TextBox>
       </td>
     </tr>
         <tr>
             <td class="Labeltext">Consumer Mobile :<span style="color:Red ">*</span></td>
            <td class="column">
                <asp:TextBox ID="txtconsMobile" TabIndex="102" runat="server" Width="170px" CssClass="Textbox"
                     MaxLength="10" onkeypress="return validatenumerics(event)"></asp:TextBox>

            </td>       
         </tr>
         <tr>
        <td class="Labeltext">
        Division Name:<span style="color:Red ">*</span> 
        </td>
        <td class="column">
        <asp:DropDownList ID="cmbDivision"  runat="server" TabIndex="104" Width="170px" CssClass="combobox" AutoPostBack="True">
        </asp:DropDownList>       
        </td>
        </tr>
         <tr>

        <td class="Labeltext">
          Sub Division Name : <span style="color:Red ">*</span>
        </td>
        <td class="column">
        <asp:DropDownList ID="cmbSubdivision" runat="server" CssClass="combobox" TabIndex="105" Width="170px"  AutoPostBack="True">
        </asp:DropDownList>
        
        </td>
         </tr>
         <tr>
        <td class="Labeltext">
        Section Name :<span style="color:Red ">*</span>
        </td>
        <td class="column">
        <asp:DropDownList ID="cmbSection" runat="server" CssClass="combobox" TabIndex="106" Width="170px" 
             AutoPostBack="True">
        </asp:DropDownList>
        </td>
        </tr>
         <tr>
              
        <td class="Labeltext">Category : <span style="color:Red ">*</span></td>
        <td class="column">
        <asp:DropDownList ID="cmbLoadType" runat="server" TabIndex="110" Width="170px" CssClass="combobox">
            <asp:ListItem Selected="True">Single Phase</asp:ListItem>
            <asp:ListItem>LT Three Phase Domestic</asp:ListItem>
            <asp:ListItem>LT Three Phase Commercial</asp:ListItem>
            <asp:ListItem>HT</asp:ListItem>
        </asp:DropDownList>
        </td>
        </tr>
        <tr>            
        <td class="Labeltext">Load required : <span style="color:Red ">*</span></td>
        <td class="column">
         <asp:TextBox id="txtLoadRequired" runat="server" ToolTip="Enter Day" 
             onblur="javascript:return datevalidation();"  maxlength="5"
              Width="60px" TabIndex="111" CssClass="Textbox">1</asp:TextBox> 
             &nbsp; 
            <asp:DropDownList ID="cmbLoadUnits" runat="server" TabIndex="112" Width="100px" CssClass="combobox">
            <asp:ListItem Selected="True">KW</asp:ListItem>
            <asp:ListItem>HP</asp:ListItem>
            <asp:ListItem>KVA</asp:ListItem>
        </asp:DropDownList>
        </td>
         </tr>
         <tr>
             <td>&nbsp;</td>
             <td class="column" align="left" style="padding-bottom:10px;padding-top:10px">
             <asp:Panel ID="PanleConnection" runat="server">
             <asp:RadioButton ID="rdbRegular" runat="server" Checked="True" 
                  Text="Regular" TabIndex="113" GroupName="Hooking" AutoPostBack="true" />
             <asp:RadioButton ID="rdbHooking" runat="server"  Text="Hooking" TabIndex="112" GroupName="Hooking" AutoPostBack="true" />
             <asp:RadioButton ID="rdbTemporary" runat="server"  GroupName="Hooking" TabIndex="112" Text="Temporary" AutoPostBack="true" />
              </asp:Panel>
             </td>
         </tr>
         <tr>
          <td colspan="2">
          <asp:Panel ID="tmppanel" runat="server">
          <table cellpadding="0" cellspacing="0" width="100%">
           <tr>
             <td class="Labeltext" width="37%">Temporary From Date:</td>
             <td class="column" align="left">
               <asp:TextBox id="txtFromDate" runat="server" maxlength="25" CssClass="Textbox" Width="70px"
                    TabIndex="106">
               </asp:TextBox>&nbsp;<img id="imgCalManual" src="calender.png" />
              <td>
</td>   
             </td>
               
         </tr>
         <tr>
             <td class="Labeltext">Temporary From Time:</td>
             <td class="column" align="left" style="padding-bottom:5px;padding-top:2px">
                 <cc1:TimeSelector ID="fromtimepicker" runat="server" DisplaySeconds="false"   SelectedTimeFormat="TwentyFour" ></cc1:TimeSelector>
             </td>
         </tr>
         <tr>
             <td class="Labeltext">Temporary To Date:</td>
             <td class="column" align="left" style="padding-bottom:2px">
              <asp:TextBox id="txtToDate" runat="server" maxlength="25" CssClass="Textbox" Width="70px" 
                  TabIndex="106"></asp:TextBox>&nbsp;<img id="img1" src="calender.png" />
             </td>
         </tr>
       <tr>
             <td class="Labeltext">Temporary To Time:</td>
             <td class="column" align="left" style="padding-bottom:5px">
                 <cc1:TimeSelector ID="totimepicker" runat="server" DisplaySeconds="false" SelectedTimeFormat="TwentyFour" ></cc1:TimeSelector>
             </td>
         </tr>
                    
          

      </table>
          </asp:Panel>  
      </td>
     </tr>
       
     </table>
     </asp:Panel>
     </td>
     <td width="50%" height="100%">
        <asp:Panel ID="panel2" runat="server" CssClass="panel">
        <table  width="100%" height="100%" cellspacing="0" cellpadding="0" class="table" align="center">
         <tr >
         <td class="Labeltext" width="50%">Ticket Number :<span style="color:Red ">*</span></td>
         <td class="column" style="padding-top:5px;">
           <asp:TextBox ID="txtTicketNumber" runat="server"  CssClass="Textbox" AutoCompleteType="disabled" 
               TabIndex="100" Width="170px" Enabled="False"></asp:TextBox>
        </td>
        </tr>

        <tr>
                <td class="Labeltext">Address :<span style="color:Red ">*</span></td>
                <td style="resize:none" class="column">
                 <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine" CssClass="Textbox"
                      TabIndex="107" Width="167px" MaxLength="120"></asp:TextBox>
                </td>
            </tr>
            <tr>
             <td class="Labeltext">Ticket Time:<span style="color:Red ">*</span> </td>
             <td class="column" align="left" style="padding-bottom:5px;padding-top:2px">
                 <cc1:TimeSelector ID="txtTicketGeneratedTime" runat="server" DisplaySeconds="false"   SelectedTimeFormat="TwentyFour" ></cc1:TimeSelector>
             </td>
         </tr>
        <tr>
                <td class="Labeltext">Village/City :<span style="color:Red ">*</span></td>
                <td class="column">
                  <asp:TextBox ID="txtVillage" runat="server" TabIndex="108" Width="170px" MaxLength="40" CssClass="Textbox"></asp:TextBox>
                 </td>
            </tr>
        <tr>
                 <td class="Labeltext">Nearest Land Mark :</td>
                 <td class="column">
                  <asp:TextBox ID="txtNearestLandMark" runat="server" CssClass="Textbox" TabIndex="109" Width="170px" MaxLength="40"></asp:TextBox>
                 </td>
           </tr>
        <tr>
              <td class="Labeltext">Consumer Mail ID :</td>
              <td class="column">
               <asp:TextBox id="txtconsMailID" runat="server" ToolTip="Enter Day"  CssClass="Textbox"
               onblur="javascript:return validateEmail(this);"  maxlength="50"  Width="170px" TabIndex="103">
               </asp:TextBox> 
             </td>
            </tr>
       <tr>
           <td class="Labeltext">Consumer Account Number :</td>
           <td class="column">
           <asp:TextBox id="txtConsumerAccountNumber" runat="server" ToolTip="Enter Day" CssClass="Textbox" 
               onblur="javascript:return validateEmail(this);"  maxlength="50" Columns="2" Width="150px" TabIndex="103" ></asp:TextBox> 
        </td>
       </tr>
            <tr>
           <td class="Labeltext">Complaint Code:</td>
           <td class="column">
        <asp:DropDownList ID="CmbComplaintNumber" runat="server" TabIndex="106" 
            Width="160px" CssClass="combobox" AutoPostBack="True">
        </asp:DropDownList>
        
        </td>
       </tr>
        <tr>
             <td class="Labeltext">Complaint Category:</td>
              <td class="column">
             <asp:DropDownList ID="CmbComplaintType" runat="server" TabIndex="106" Width="160px" CssClass="combobox" AutoPostBack="True">
            <asp:ListItem>NO SUPPLY</asp:ListItem>
            <asp:ListItem>CONNECTION</asp:ListItem>
            <asp:ListItem>OTHERS</asp:ListItem>
            <asp:ListItem>METER</asp:ListItem>
            <asp:ListItem>BILLING</asp:ListItem>
        </asp:DropDownList>        
        </td>
       </tr>
        <tr>
         <td class="Labeltext">Complaint Sub-category :</td>
        <td class="column">
        <asp:DropDownList ID="CmbComplaintSubCategory" runat="server" TabIndex="106" Width="170px" CssClass="combobox"  AutoPostBack="True">
        </asp:DropDownList>
        </td>
        </tr>
        <tr>
         <td class="Labeltext">Complaint Details:</td>
         <td class="column">
         <asp:DropDownList ID="CmbComplaintSubDetails" runat="server" TabIndex="106" 
             Width="170px"  AutoPostBack="True" CssClass="combobox">
         </asp:DropDownList>
         </td>
         </tr>
           
           
       
            
        <tr>
                <td class="Labeltext">E-Mail Id :</td>
        <td class="column" style="padding-bottom:3px">
        <asp:TextBox ID="txtSetcionEmailID" runat="server"  onblur="javascript:return validateEmail(this);" 
            TabIndex="116" AutoPostBack="True" Width="170px" CssClass="Textbox"></asp:TextBox>
        
        </td>
         </tr>

         <tr>
                <td class="Labeltext">Comment :</td>
               <td class="column" align="left">
                   <asp:TextBox ID="txtcomment" runat="server" TabIndex="117"  TextMode="MultiLine"
                        Width="167px" MaxLength="157" CssClass="Textbox" style="resize:none" ></asp:TextBox>
               </td>
            </tr>
             <tr>
          <td class="Labeltext">Section Incharge : <span style="color:Red ">*</span></td>
        <td class="column">
        <asp:DropDownList ID="cmbSectionIncharge" runat="server" CssClass="combobox" TabIndex="114" Width="160px" AutoPostBack="True">
        </asp:DropDownList>
        </td>
         </tr>
                    <tr>
           <td class="Labeltext">Section inchage Mobile :</td>
        <td class="column" >
        <asp:TextBox ID="txtSectionInchageMobile" runat="server"  onkeypress="return validatenumerics(event)" 
            TabIndex="115" AutoPostBack="True" Width="70px" MaxLength="10" CssClass="Textbox"></asp:TextBox>
        
        </td>
            </tr> 
        </table>
       </asp:Panel>
    </td>
    </tr>
           

    <tr>
      <td colspan="2"  align="center"><hr  style="color:#1a46b0"/>
        <asp:Button ID="btnCLear" runat="server"  Text="New" Width="60px"
         CssClass="buttons" TabIndex="119"  />  &nbsp;  
        <asp:Button ID="btnSubmit" runat="server"  Text="Save" Width="60px" 
        OnClientClick="return uservalidation();" CssClass="buttons" TabIndex="118"  />
         &nbsp;
         <input type="reset" id="btnreset" class="buttons" tabindex="10" runat="server"
        value="Close" onclick="javascript: window.close();"  />
       </td>
    </tr>
    <tr>
     <td colspan="2"> 
      <asp:DropDownList ID="cmbSectionInchargeCode" runat="server" TabIndex="6" Width="170px" CssClass="combobox" Visible="False">
      </asp:DropDownList>
      <br />
      <asp:DropDownList ID="cmbDivisionCode" runat="server" TabIndex="6" Width="46px" 
       CssClass="combobox" Visible="False">
      </asp:DropDownList>
        <asp:DropDownList ID="cmbSectionCode" runat="server" TabIndex="6" Width="200px" CssClass="combobox" Visible="False">
        </asp:DropDownList>
        <asp:DropDownList ID="cmbSectionCode0" runat="server" TabIndex="6" Width="200px" CssClass="combobox" Visible="False">
        </asp:DropDownList>
         <asp:DropDownList ID="cmbSubdivisionCode" runat="server" CssClass="combobox" TabIndex="6" Visible="False" Width="200px">
         </asp:DropDownList>
         <asp:TextBox ID="txtComplaintCategory" runat="server" Height="2px" Visible="False" Width="71px"></asp:TextBox>
     </td>
     </tr>
    </table>
    </td></tr>
   </table>
  
<%--<table cellpadding="0" cellspacing="0" style="height:481px; width: 100%;border:1px" class="head_txt">
<tr align="center">
    <td colspan="4" align="center"  style="font-weight: bold; color: white; background-color: #5d7b9d;">&nbsp;
        Ticket Creation
    </td>
</tr>
<tr>
 <td class="auto-style52"></td>
 <td class="auto-style62"></td>
 <td class="auto-style44"></td>
 <td class="auto-style44"></td>
</tr>
<tr>
 <td align="right" class="auto-style49"><span style="color:Red ">*</span>Ticket Type :</td>
 <td align="left" class="auto-style63">
  <asp:RadioButton ID="rdbNSC" runat="server" Checked="True" Font-Bold="True" Text="NSC" TabIndex="113" GroupName="TicketType" />
  <asp:RadioButton ID="rdbOther" runat="server" Font-Bold="True" Text="Others" TabIndex="112" GroupName="TicketType" />
 </td>
 <td align="left" class="auto-style61"><span style="color:Red ">* </span>Ticket Number :</td>
 <td align="left" class="auto-style54">
     <asp:TextBox ID="txtTicketNumber" runat="server" Height="17px" AutoCompleteType="disabled" TabIndex="100" Width="191px" Enabled="False"></asp:TextBox>
</td>
</tr>
    <tr>
        <td align="right" class="auto-style50">
            &nbsp;</td>
        <td align="left" class="auto-style64">
            &nbsp;</td>
        <td align="left" class="auto-style46">
            &nbsp;</td>
        <td align="left" class="auto-style46">
            &nbsp;</td>
    </tr>
    <tr>
<td align="right" class="auto-style48"><span style="color:Red ">*</span>Consumer Name :</td>
<td align="left" class="auto-style65"><asp:TextBox ID="txtConsumerName" runat="server" Height="18px" TabIndex="101" Width="189px" MaxLength="60"></asp:TextBox></td>

        <td align="right" class="auto-style52">
            <span style="color:Red ">*</span>Address :</td>
        <td align="left" class="auto-style44">
        <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine" TabIndex="107" Width="195px" MaxLength="120"></asp:TextBox>
        </td>

    </tr>
    <tr>
        <td align="right" class="auto-style48">
        </td>
        <td align="left" class="auto-style65">
        </td>
        <td align="right" class="auto-style50">
            </td>
        <td align="left" class="auto-style46">
            </td>
    </tr>
    <tr>
<td align="right" class="auto-style48"><span style="color:Red ">*</span>Consumer Mobile :</td>
<td align="left" class="auto-style65"><asp:TextBox ID="txtconsMobile" TabIndex="102" runat="server" Width="187px" MaxLength="10" onkeypress="return validatenumerics(event)"></asp:TextBox>

</td>
        <td align="right" class="auto-style50">
            <span style="color:Red ">*</span>Village/City :</td>
        <td align="left" class="auto-style46">
            <asp:TextBox ID="txtVillage" runat="server" Height="18px" TabIndex="108" Width="189px" MaxLength="40"></asp:TextBox>
            </td>
    </tr>
    <tr>
        <td align="right" class="auto-style50">
        </td>
        <td align="left" class="auto-style64">
            &nbsp;</td>
        <td align="right" class="auto-style50">
            &nbsp;</td>
        <td align="left" class="auto-style46">
            &nbsp;</td>
    </tr>
    <tr>
        <td align="right" class="auto-style45" >
        <span style="color:Red ">*</span> Division Name:
        </td>
        <td align="left" class="auto-style66" >
        <asp:DropDownList ID="cmbDivision" runat="server" TabIndex="104" Width="200px" CssClass="auto-style29" AutoPostBack="True">
        </asp:DropDownList>
        &nbsp;
        </td>
        <td align="right" class="auto-style51">
            Nearest Land Mark :</td>
        <td align="left" class="auto-style56">
            <asp:TextBox ID="txtNearestLandMark" runat="server" Height="18px" TabIndex="109" Width="189px" MaxLength="40"></asp:TextBox>
         </td>
    </tr>
    <tr>
        <td align="right" class="auto-style48">
        </td>
        <td align="left" class="auto-style65">
        <asp:DropDownList ID="cmbDivisionCode" runat="server" TabIndex="6" Width="46px" 
            CssClass="auto-style29" Height="16px" Visible="False">
        </asp:DropDownList>
        </td>
        <td align="left" class="auto-style46">
        </td>
        <td align="left" class="auto-style46">
        </td>
    </tr>
    <tr>

        <td align="right" class="auto-style45" >
        <span style="color:Red ">*</span>Sub Division Name :
        </td>
        <td align="left" class="auto-style66" >
        <asp:DropDownList ID="cmbSubdivision" runat="server" TabIndex="105" Width="200px" CssClass="auto-style29" AutoPostBack="True">
        </asp:DropDownList>
        
        </td>

        <td class="auto-style60" >
            Consumer Mail ID :</td>
        <td align="left" class="auto-style12" >
           <asp:TextBox   id="txtconsMailID" runat="server" ToolTip="Enter Day" 
               onblur="javascript:return validateEmail(this);"  maxlength="50" Columns="2" Width="188px" TabIndex="103">
           </asp:TextBox> 
        </td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style52">
        </td>
        <td align="left" class="auto-style62">
        <asp:DropDownList ID="cmbSubdivisionCode" runat="server" TabIndex="6" Width="200px" CssClass="auto-style29" Visible="False">
        </asp:DropDownList>
        
        </td>
        <td class="auto-style59">
            &nbsp;</td>
        <td align="left" class="auto-style15">
            &nbsp;</td>
    </tr>
    <tr>

        <td align="right" class="auto-style52" >
        <span style="color:Red ">*</span>Section Name :
        </td>
        <td align="left" class="auto-style62" >
        <asp:DropDownList ID="cmbSection" runat="server" TabIndex="106" Width="200px" CssClass="auto-style29" AutoPostBack="True">
        </asp:DropDownList>
        </td>

        <td class="auto-style58" >
            Complaint Category:</td>

        <td align="left" class="auto-style55" >
        <asp:DropDownList ID="CmbComplaintType" runat="server" TabIndex="106" Width="200px" CssClass="auto-style29" AutoPostBack="True">
            <asp:ListItem>No Supply</asp:ListItem>
            <asp:ListItem>Billing Related</asp:ListItem>
            <asp:ListItem>Connection Related</asp:ListItem>
            <asp:ListItem>Meter Related</asp:ListItem>
            <asp:ListItem>Others</asp:ListItem>
        </asp:DropDownList>
        
        </td>

    </tr>
    <tr>
        <td align="right" class="auto-style48">
        </td>
        <td align="left" class="auto-style65">
        <asp:DropDownList ID="cmbSectionCode" runat="server" TabIndex="6" Width="200px" CssClass="auto-style29" Visible="False">
        </asp:DropDownList>
        </td>
        <td class="auto-style58">
        
        </td>
        <td align="left" class="auto-style55">
        
        </td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style52">
      
            <span style="color:Red ">*</span>Category :</td>
        <td align="left" class="auto-style62">
        <asp:DropDownList ID="cmbLoadType" runat="server" TabIndex="110" Width="200px" CssClass="auto-style29">
            <asp:ListItem Selected="True">Single Phase</asp:ListItem>
            <asp:ListItem>LT Three Phase Domestic</asp:ListItem>
            <asp:ListItem>LT Three Phase Commercial</asp:ListItem>
            <asp:ListItem>HT</asp:ListItem>
        </asp:DropDownList>
        </td>
        <td style="height: 13px" class="auto-style57">
            Complaint Sub-category :</td>
        <td align="left" style="height: 13px">
        <asp:DropDownList ID="CmbComplaintSubCategory" runat="server" TabIndex="106" Width="200px" CssClass="auto-style29" AutoPostBack="True">
        </asp:DropDownList>
        </td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style52">
      
            &nbsp;</td>
        <td align="left" class="auto-style62">
            &nbsp;</td>
        <td style="height: 13px" class="auto-style57">
            &nbsp;</td>
        <td align="left" style="height: 13px">
            &nbsp;</td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style52">
      
            <span style="color:Red ">*</span>Load required :</td>
        <td align="left" class="auto-style62">

<asp:TextBox   id="txtLoadRequired" runat="server" ToolTip="Enter Day" onblur="javascript:return datevalidation();"  maxlength="5" Columns="2" Width="75px" CssClass="auto-style29" TabIndex="111" >1</asp:TextBox> 
       &nbsp;&nbsp; <asp:DropDownList ID="cmbLoadUnits" runat="server" TabIndex="112" Width="100px" CssClass="auto-style29" Height="16px">
            <asp:ListItem Selected="True">KW</asp:ListItem>
            <asp:ListItem>HP</asp:ListItem>
            <asp:ListItem>KVA</asp:ListItem>
        </asp:DropDownList>
        </td>
        <td style="height: 13px" class="auto-style57">

            Complaint Details:</td>
        <td align="left" style="height: 13px">

        <asp:DropDownList ID="CmbComplaintSubDetails" runat="server" TabIndex="106" Width="200px" CssClass="auto-style29" AutoPostBack="True">
        </asp:DropDownList>
        </td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style52">
      
            &nbsp;</td>
        <td align="left" class="auto-style62">
            &nbsp;</td>
        <td style="height: 13px" class="auto-style57">
            &nbsp;</td>
        <td align="left" style="height: 13px">
            &nbsp;</td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style52">
      
            &nbsp;</td>
        <td align="left" class="auto-style62">
           <asp:Panel runat="server" >
             <asp:RadioButton ID="rdbRegular" runat="server" Checked="True" Font-Bold="True" Text="Regular" TabIndex="113" GroupName="Hooking" />
            <asp:RadioButton ID="rdbHooking" runat="server" Font-Bold="True" Text="Hooking" TabIndex="112" GroupName="Hooking" />
               <asp:RadioButton ID="rdbTemporary" runat="server" Font-Bold="True" GroupName="Hooking" TabIndex="112" Text="Temporary" />
        </asp:Panel>
               </td>
        <td style="height: 13px" class="auto-style57">
            Comment :
               </td>
        <td align="left" rowspan="2">
        <asp:TextBox ID="txtcomment" runat="server" TextMode="MultiLine" TabIndex="117" Width="194px" MaxLength="160" Height="44px"></asp:TextBox>
               </td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style52">
      
            &nbsp;</td>
        <td align="left" class="auto-style62">
            &nbsp;</td>
        <td style="height: 13px" class="auto-style57">
            &nbsp;</td>
    </tr>
    <tr>
        <td align="right" class="auto-style45" >
        <span style="color:Red ">*</span>Section Incharge :
        </td>
        <td align="left" class="auto-style66" >
        <asp:DropDownList ID="cmbSectionIncharge" runat="server" TabIndex="114" Width="200px" AutoPostBack="True">
        </asp:DropDownList>
        </td>
        <td style="height: 22px" class="auto-style57" >
            &nbsp;</td>
        <td align="left" style="height: 22px" >
            &nbsp;</td>
    </tr>
    <tr height="13">
        <td align="right" class="auto-style48">
        </td>
        <td align="left" class="auto-style65">
        <asp:DropDownList ID="cmbSectionInchargeCode" runat="server" TabIndex="6" Width="200px" Visible="False">
        </asp:DropDownList>
        </td>
        <td align="left">
            &nbsp;</td>
        <td align="left">
            &nbsp;</td>
    </tr>
    <tr>
        <td align="right" class="auto-style48" >
            Section inchage Mobile :
        </td>
        <td align="left" class="auto-style65" >
        <asp:TextBox ID="txtSectionInchageMobile" runat="server"  onkeypress="return validatenumerics(event)" TabIndex="115" AutoPostBack="True" Width="189px" MaxLength="10"></asp:TextBox>
        
        </td>
        <td align="left" style="text-align: right" >
            E-Mail Id :
                
        </td>
        <td align="left" >
        <asp:TextBox ID="txtSetcionEmailID" runat="server"  onblur="javascript:return validateEmail(this);" TabIndex="116" AutoPostBack="True" Width="188px"></asp:TextBox>
        
        </td>
    </tr>
    <tr>
        <td align="right" class="auto-style48">&nbsp;</td>
        <td align="left" class="auto-style65">
            &nbsp;</td>
        <td align="left">
            &nbsp;</td>
        <td align="left">
            &nbsp;</td>
    </tr>
    <tr align="center">
<td colspan="4" align="center" style="font-weight: bold; color: white; background-color: #5d7b9d; height: 24px;">
    <asp:Button ID="btnCLear" runat="server"  Text="New" Width="60px" CssClass="button" TabIndex="119"  />
     &nbsp;
    &nbsp;&nbsp;
<asp:Button ID="btnSubmit" runat="server"  Text="Save" Width="60px" OnClientClick="return uservalidation()" CssClass="button" TabIndex="118"  />
    
    &nbsp;
    &nbsp;&nbsp;
    <input type="reset" id="btnreset" class="button" tabindex="10" runat="server" value="Close" onclick="javascript: window.close();" /> &nbsp;
    &nbsp;&nbsp;</td>
</tr>
</table>--%>
</div>
     </center>
<input type="hidden"  id="hidden1" runat="server"/>
        
 
</form>
</body>
</html>
