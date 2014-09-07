<%@ Page Title="" Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" CodeFile="DivisionMaster.aspx.cs" Inherits="Master_Pages_DivisionMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
  
      <div style="flex-align:center">
     <table width="800px">
        <tr><td style="height:0px"></td></tr> 
         <tr><td>
    <table class="table" width="450px" align="center" cellpadding="0" cellspacing="0">
        <tr><td colspan="2" class="Header">Division Details</td></tr>
        <tr>
            <td width="20%" class="Labeltext">Division Name</td>
            <td><asp:TextBox ID="txtdivisionname" runat="server" CssClass="Textbox" ></asp:TextBox></td>
        </tr>
    </table>
     </td></tr>
     </table>       
    </div>
        
</asp:Content>

