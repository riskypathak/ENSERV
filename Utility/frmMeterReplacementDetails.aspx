<%@ Page Title="" Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" CodeFile="frmMeterReplacementDetails.aspx.cs" Inherits="Utility_frmMeterReplacementDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="http://localhost:5059/code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="Scripts/calendar-en.min.js" type="text/javascript"></script>
    <link href="Styles/calendar-blue.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="750px" height="100%" class="table" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="Headers" colspan="2">Meter Replacement</td>
        </tr>
        <tr>
            <td class="Labeltext" width="15%" style="padding-top: 5px">&nbsp;&nbsp;Consumer No:</td>
            <td class="column" align="left" style="padding-top: 5px"  width="85%">
                <asp:TextBox ID="txtconsumerno" runat="server" CssClass="Textbox"></asp:TextBox>&nbsp;
                <asp:Button ID="btnView" runat="server" CssClass="buttons" Text="Get Data" Width="60px" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Panel ID="Panel1" runat="server" GroupingText="Consumer Details"
                    CssClass="panel" Height="100%" Width="96%">
                    <table width="720px" align="center" cellpadding="0" cellspacing="0">

                        <tr>
                            <td class="Labeltext" width="15%">Name:</td>
                            <td align="left" class="column">
                                <asp:TextBox ID="txtconsumername" runat="server" CssClass="Textbox"></asp:TextBox></td>
                            <td class="Labeltext">Division Name:</td>
                            <td align="left" class="column">
                                <asp:TextBox ID="txtDIV_name" runat="server" TabIndex="104" Width="160px"
                                    CssClass="Textbox" MaxLength="25" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="Labeltext">Address:</td>
                            <td align="left" class="column">
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Width="157px" Height="50px"
                                    CssClass="Textbox" Style="resize: none"></asp:TextBox></td>
                            <td class="Labeltext" valign="top">Sub Division Name :<br />
                                <br />
                                Section Name:</td>
                            <td align="left" class="column">
                                <asp:TextBox ID="txtSubDiv_name" runat="server" Enabled="False" CssClass="Textbox"
                                    MaxLength="25" TabIndex="104" Width="160px"></asp:TextBox>
                                <br />
                                <asp:TextBox ID="txtSection_name" runat="server" TabIndex="104" Width="160px"
                                    CssClass="Textbox" MaxLength="25" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>

                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table width="740px" cellpadding="0" cellspacing="0" align="center">
                    <tr>
                        <td width="50%" valign="top">
                            <asp:Panel ID="pnloldmeterdetail" runat="server" GroupingText="Old Meter Details"
                                CssClass="panel" Height="100%">
                                <table width="100%" height="100%" align="center" cellpadding="0" cellspacing="0" valign="top"
                                    align="center">

                                    <tr>
                                        <td class="Labeltext" width="50%">Manufacturer Name:</td>
                                        <td class="column" align="left" style="padding-bottom:2px;padding-top:2px">
                                            <asp:TextBox ID="txtmanufacturename" runat="server" CssClass="Textbox" Width="150px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Manufacture Type</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtmanufacturetype" runat="server" CssClass="Textbox"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Phase</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtphase" runat="server" CssClass="Textbox"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Bill Basis</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtbillbasis" runat="server" CssClass="Textbox"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Meter Digits:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtmeterdigits" runat="server" CssClass="Textbox"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Is Metered/Un-Metered:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtismeter" runat="server" CssClass="Textbox"></asp:TextBox></td>
                                    </tr>

                                    <tr>
                                        <td class="Labeltext">Utility Type:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="Textbox"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Memo:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtmemo" runat="server" CssClass="Textbox"
                                                style="resize:none" TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Total No. of installments of MR:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="TextBox4" runat="server" Width="70px" CssClass="Textbox"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Remaining Installments of MR:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtremaininginstallmentofmr" runat="server" CssClass="Textbox" Width="70px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Installation Date:</td>
                                        <td class="column" align="left" style="padding-bottom:2px">
                                            <asp:TextBox ID="txtsanctiondate" runat="server" CssClass="Textbox" Width="70px"></asp:TextBox>
                                            <img id="img1" src="../calender.png" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                </table>
                            </asp:Panel>

                        </td>
                        <td width="50%" valign="top">
                            <asp:Panel ID="pnlmeterdetail" runat="server" GroupingText="New Meter Details" CssClass="panel"
                                Height="100%">
                                <table width="100%" height="100%" align="center" cellpadding="0" cellspacing="0" height="400px" valign="top">

                                    <tr>
                                        <td class="Labeltext" width="50%">Manufacturer Name:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlmanufacturername" runat="server" CssClass="combobox">
                                                <asp:ListItem>Genus</asp:ListItem>
                                                <asp:ListItem>LnG</asp:ListItem>
                                                <asp:ListItem>LnT</asp:ListItem>
                                                <asp:ListItem>Palmohan</asp:ListItem>
                                                <asp:ListItem>Secure</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Manufacture Type</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlmanufacturetype" runat="server" CssClass="combobox"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Phase</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlphase" runat="server" CssClass="combobox"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Bill Basis</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlbillbasis" runat="server" CssClass="combobox"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Meter Digits:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlmeterdigits" runat="server" CssClass="combobox"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Is Metered/Un-Metered:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlwhethermeter" runat="server" CssClass="combobox"></asp:DropDownList></td>
                                    </tr>

                                    <tr>
                                        <td class="Labeltext">Utility Type:</td>
                                        <td align="left">
                                            <asp:TextBox ID="txtutilitytype" runat="server" CssClass="Textbox"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Memo:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="txtmemo1" runat="server" CssClass="Textbox" TextMode="MultiLine" style="resize:none"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Total No. of installments of MR:</td>
                                        <td align="left">
                                            <asp:TextBox ID="txttotalnoofinstallment" runat="server" Width="70px" CssClass="Textbox"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Remaining Installments of MR:</td>
                                        <td class="column" align="left">
                                            <asp:TextBox ID="TextBox3" runat="server" CssClass="Textbox" Width="70px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Actual Instalation Date:</td>
                                        <td align="left">
                                            <asp:TextBox ID="txtactualdate" runat="server" CssClass="Textbox" Width="70px"></asp:TextBox>
                                            <img id="img2" src="../calender.png" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkirflag" runat="server" />
                                            IR Meter Flag
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr><td colspan="2"><hr /></td></tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Save" Width="60px"
                    CssClass="buttons" />
                <asp:Button ID="btnclose" runat="server" Text="Close" Width="60px"
                    CssClass="buttons" />
            </td>
        </tr>
         
    </table>
</asp:Content>

