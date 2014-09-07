using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

///<summary>
///SummarydescriptionforSBMOutput
///</summary>
public class SBMOutput
{
    public string ConsumerNumber { get; set; }
    public string SBMNo { get; set; }
    public string MeterReaderName { get; set; }
    public string MeterReaderID { get; set; }
    public DateTime BillDate { get; set; }
    public string BillMonth { get; set; }
    public string BillTime { get; set; }
    public int BillPeriod { get; set; }
    public int CurrentMeterReading { get; set; }
    public DateTime CurrrentMeterReadingDate { get; set; }
    public double MDI { get; set; }
    public string CurrentMeterStatus { get; set; }
    public int CumulativeMeterStatusCounter { get; set; }
    public double HouseLockAdjumentAmount { get; set; }
    public int UnitsConsumed { get; set; }
    public string BillBasis { get; set; }
    public int Slab1Units { get; set; }
    public int Slab2Units { get; set; }
    public int Slab3Units { get; set; }
    public int Slab4Units { get; set; }
    public double Slab1EC { get; set; }
    public double Slab2EC { get; set; }
    public double Slab3EC { get; set; }
    public double Slab4EC { get; set; }
    public double TotalEnergyCharge { get; set; }
    public double MonthlyMinimumCharges { get; set; }
    public double MeterRent { get; set; }
    public double ElectricityDutyCharges { get; set; }
    public double CumulativeProvisionalEnergyCharges { get; set; }
    public double CumulativeProvisionalElectricityDuty { get; set; }
    public int CumulativeUnits { get; set; }
    public double DelayPaymentSurcharge { get; set; }
    public double CurrentBillTotal { get; set; }
    public double RoundAmount { get; set; }
    public double RebateAmount { get; set; }
    public double AmounttobePaidonRebateDate { get; set; }
    public int AverageUnitsBilled { get; set; }
    public DateTime RebateDate { get; set; }
    public DateTime DueDate { get; set; }
    public int AveragePFPercentage { get; set; }
    public double AmountPaidafterRebateDate { get; set; }
    public DateTime Disconnectiondate { get; set; }
    public string Remarks { get; set; }
    public string TariffCode { get; set; }
    public string BillNo { get; set; }
    public string UploadFlag { get; set; }
}