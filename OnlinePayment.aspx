<%@ Page Title="Online Payment" Language="C#" MasterPageFile="~/DefaultMasterforRegulisation.master" AutoEventWireup="true" CodeFile="OnlinePayment.aspx.cs" Inherits="OnlinePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/ThemeBlue.css" rel="Stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href='/../code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css' />
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
    <script>
        $(function () {
            $(".datepicker").datepicker({ dateFormat: 'dd-mm-yy' });
        });
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                alert("Please Enter Only Numeric Value:");
                return false;
            }

            return true;
        } 
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scriptManager" runat="server" EnablePageMethods="true" />
    <table>
        <tr>
            <td colspan="2"><b>Consumer Detail</b></td>
        </tr>
        <tr>
            <td>Consumer No: </td>
            <td align="left">
               <%-- <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddlConsumerNo_SelectedIndexChanged" ID="ddlConsumerNo" runat="server"></asp:DropDownList></td>--%>
                <asp:TextBox ID="txtConsumerNumber" runat="server" />
                <asp:Button Text="Search" id="btnsearchConsumer" CausesValidation="false" runat="server" OnClick="btnsearchConsumer_Click" />
        </tr>
        <tr>
            <td>Connection ID: </td>
            <td align="left">
                <asp:TextBox Enabled="false" ID="txtConnectionID" ReadOnly="true" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="txtConnectionID" runat="server" />
            </td>
        </tr>
        <tr>
            <td>Consumer Name: </td>
            <td align="left">
                <asp:TextBox Enabled="false" ID="txtConsumerName" ReadOnly="true" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="txtConsumerName" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2"><b></b></td>
        </tr>
        <tr>
            <td colspan="2"><b>Payment Detail</b></td>
        </tr>
        <tr>
            <td>Payment Purpose: </td>
            <td align="left">
                <asp:DropDownList ID="ddlPaymentPurpose" runat="server"></asp:DropDownList></td>
        </tr>
        <tr>
            <td>Payment Mode: </td>
            <td align="left">
                <asp:DropDownList ID="ddlPaymentMode" runat="server"></asp:DropDownList></td>
        </tr>
        <tr>
            <td>Amount: </td>
            <td align="left">
                <asp:TextBox  ID="txtAmount" onkeypress="return isNumberKey(event)" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="txtAmount" runat="server" />
            </td>
        </tr>
        <tr>
            <td>Payment Date: </td>
            <td align="left">
                <asp:TextBox ID="txtPaymentDateTime" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="txtPaymentDateTime" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2"><b></b></td>
        </tr>
        <tr>
            <td colspan="2"><b>Bank Detail</b></td>
        </tr>
        <tr>
            <td>Bank ID: </td>
            <td align="left">
                <asp:DropDownList ID="ddlbankID" runat="server"></asp:DropDownList></td>
        </tr>
        <tr>
            <td>Instrument No.: </td>
            <td align="left">
                <asp:TextBox ID="txtInstrumentNo" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="txtInstrumentNo" runat="server" />
            </td>
        </tr>
        <tr>
            <td>Instrument Date: </td>
            <td align="left">
                <asp:TextBox CssClass="datepicker" ID="txtInstrumentDate" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="txtInstrumentDate" runat="server" />
            </td>
        </tr>
        <tr>
            <td>Remarks: </td>
            <td align="left">
                <asp:TextBox TextMode="MultiLine" Rows="5" ID="txtRemarks" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ErrorMessage="Required" ControlToValidate="txtRemarks" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit" />
            </td>
            <td>
                <input id="btnPrint" value="Print" type="button" onclick="javascript:window.location='ensrv://<%=Session["receiptdetails"]%>'" />
            </td>
        </tr>
    </table>
</asp:Content>
