enum 50101 "Demo Transaction Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }

    value(1; Processed)
    {
        Caption = 'Processed';
    }

    value(2; Cancelled)
    {
        Caption = 'Cancelled';
    }

    value(3; Archived)
    {
        Caption = 'Archived';
    }
}
