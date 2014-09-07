<%@ Page Title="" Language="C#" MasterPageFile="~/Default.master" AutoEventWireup="true" CodeFile="frmOnlinePayment.aspx.cs" Inherits="Utility_frmOnlinePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="http://code.jquery.com/jquery-1.8.3.js" type="text/javascript"></script>    
    <script type="text/javascript">
        $(document).ready(function () {
            //Dropdownlist Selectedchange event
            $('#<%= ddlpaymentmode.ClientID %>').change(function () {
                if (this.value == "Cheque") {
                    //show the table if value is Cheque
                    $('#<%= tblbankdetail.ClientID %>').show();
                } else {
                    //Hide the table if value is Cheque
                    $('#<%= tblbankdetail.ClientID %>').hide();
                }

            });
                return false;            
        });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="98%" class="table" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="Headers" colspan="2">&nbsp;Payments</td>
        </tr>
        <tr>
            <td>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="panel1" runat="server" GroupingText="Consumer Details" CssClass="panel" Width="350px">
                    <table width="350px" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="Labeltext" width="35%">Consumer No:</td>
                            <td align="left">
                                <asp:TextBox ID="txtconsumerno" runat="server" CssClass="Textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="Labeltext">Consumer Id:</td>
                            <td align="left">
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="Textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="Labeltext">Consumer Name:</td>
                            <td align="left">
                                <asp:TextBox ID="txtconsumername" runat="server" CssClass="Textbox" Width="150px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>

        </tr>
        <tr>
            <td>
                <asp:Panel ID="panel2" runat="server" GroupingText="Payment Details" CssClass="panel" Width="350px">
                    <table width="350px" align="center" cellpadding="0" cellspacing="0">

                        <tr>
                            <td class="Labeltext" width="35%">Payment Purpose:</td>
                            <td align="left">
                                <asp:DropDownList ID="ddlpaymentpurpose" runat="server" CssClass="combobox">
                                    <asp:ListItem>Invoice</asp:ListItem>
                                    <asp:ListItem>Security Deposit</asp:ListItem>
                                    <asp:ListItem>Processing Fee</asp:ListItem>
                                    <asp:ListItem>Re-connection</asp:ListItem>
                                    <asp:ListItem>Dis-connection</asp:ListItem>
                                    <asp:ListItem>Meter cost</asp:ListItem>
                                    <asp:ListItem>Meter Testing Fee</asp:ListItem>
                                    <asp:ListItem>Static Meter Report Fee</asp:ListItem>
                                    <asp:ListItem>Additional Deposit Fee</asp:ListItem>
                                    <asp:ListItem>Meter Equipment cost</asp:ListItem>
                                    <asp:ListItem>Others sevice connection fee</asp:ListItem>

                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="Labeltext">Payment Mode:</td>
                            <td align="left">
                                <asp:DropDownList ID="ddlpaymentmode" runat="server" CssClass="combobox">
                                    <asp:ListItem>Cash</asp:ListItem>
                                    <asp:ListItem>Cheque</asp:ListItem>
                                    <asp:ListItem>Demand Draft</asp:ListItem>
                                    <asp:ListItem>RTGS</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>

                        <tr>
                            <td class="Labeltext">Amount:</td>
                            <td align="left">
                                <asp:TextBox ID="txtamount" runat="server" CssClass="Textbox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="Labeltext">Payment Date and Time:</td>
                            <td align="left">
                                <asp:TextBox ID="txtpaymentdate" runat="server" CssClass="Textbox"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table id="tblbankdetail" runat="server" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="Labeltext" width="35%">Bank Name:</td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlbankname" runat="server" CssClass="combobox">
                                                <asp:ListItem>Allahabad Bank</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Instruction No:</td>
                                        <td align="left">
                                            <asp:TextBox ID="txtinstructionno" runat="server" CssClass="Textbox"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Labeltext">Instruction Date:</td>
                                        <td align="left">
                                            <asp:TextBox ID="txtinstructiondate" runat="server" CssClass="Textbox" Width="70px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="Labeltext">Remarks</td>
                            <td align="left">
                                <asp:TextBox ID="txtremarks" runat="server" CssClass="Textbox" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>

                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>

            <td>
                <asp:Button ID="btnsave" runat="server" Text="Save" CssClass="buttons" /></td>

        </tr>

        <tr>
            <td>
                <asp:GridView ID="gdvconsumerdetails" runat="server" AutoGenerateColumns="False" Width="98%"
                    Caption="<table width=100%><tr><td class=GridHeaders>Details of Consumer</td></tr></table>" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" Font-Size="10px" />
                    <Columns>
                        <asp:TemplateField HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Receipt No" DataField="ReceiptNo" />
                        <asp:BoundField HeaderText="Consumer No" DataField="ConsumerNo" />
                        <asp:BoundField HeaderText="Amount" DataField="Amount" />
                        <asp:BoundField HeaderText="Connection Id" DataField="ConnectionId" />
                        <asp:BoundField HeaderText="Consumer Name" DataField="ConsumerName" />
                        <asp:BoundField HeaderText="Payment DateTime" DataField="" />
                        <asp:BoundField HeaderText="Payment Purpose" DataField="PaymentPurpose" />
                        <asp:BoundField HeaderText="Payment Modes" DataField="PaymentReceipt" />
                        <asp:BoundField HeaderText="Payment bookno" DataField="" />
                        <asp:BoundField HeaderText="Payment receiptno" DataField="" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <EmptyDataTemplate>No Records Found</EmptyDataTemplate>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" Font-Size="12px" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Size="12px" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>

