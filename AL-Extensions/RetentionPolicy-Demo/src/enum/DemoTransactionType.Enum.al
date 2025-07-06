enum 50100 "Demo Transaction Type"
{
    Extensible = true;
    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Sale)
    {
        Caption = 'Sale';
    }
    value(2; Purchase)
    {
        Caption = 'Purchase';
    }
    value(3; Payment)
    {
        Caption = 'Payment';
    }

    value(4; Refund)
    {
        Caption = 'Refund';
    }
    value(5; Transfer)
    {
        Caption = 'Transfer';
    }
    value(6; Adjustment)
    {
        Caption = 'Adjustment';
    }
}
