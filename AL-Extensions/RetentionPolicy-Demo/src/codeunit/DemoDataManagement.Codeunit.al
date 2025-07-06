codeunit 50100 "Demo Data Management"
{
    /// <summary>
    /// Creates sample transactions for current period (last 30 days)
    /// </summary>
    procedure CreateSampleTransactions()
    var
        DemoTransaction: Record "Demo Transaction";
        i: Integer;
    begin
        for i := 1 to 10 do begin
            Message(StrSubstNo('Step 1: %1', i));
            DemoTransaction.Init();
            DemoTransaction."Entry No." := DemoTransaction.GetNextEntryNo();
            DemoTransaction."Transaction Date" := CalcDate('-' + Format(Random(30)) + 'D', Today);
            DemoTransaction."Customer No." := 'CUST00' + Format(Random(3) + 1);
            DemoTransaction."Customer Name" := 'Customer ' + Format(Random(3) + 1);
            DemoTransaction."Transaction Type" := "Demo Transaction Type"::Sale;
            DemoTransaction.Amount := Random(1000);
            DemoTransaction.Description := 'Transaction ' + Format(i);
            DemoTransaction.Status := "Demo Transaction Status"::Processed;
            DemoTransaction."Processed Date" := DemoTransaction."Transaction Date";
            if DemoTransaction.Insert(true) then;
        end;

        Message('Created 10 sample transactions');
    end;

    /// <summary>
    /// Creates old transactions (3+ years old) that will be caught by retention policies
    /// </summary>
    procedure CreateOldTransactions()
    var
        DemoTransaction: Record "Demo Transaction";
        OldDate: Date;
        i: Integer;
    begin
        for i := 1 to 20 do begin
            DemoTransaction.Init();
            // Create transactions 3-5 years old
            OldDate := CalcDate('-' + Format(Random(2) + 3) + 'Y', Today);

            DemoTransaction."Entry No." := DemoTransaction.GetNextEntryNo();
            DemoTransaction."Transaction Date" := OldDate;
            DemoTransaction."Customer No." := 'OLD00' + Format(i);
            DemoTransaction."Customer Name" := 'Old Customer ' + Format(i);
            DemoTransaction."Transaction Type" := "Demo Transaction Type"::Sale;
            DemoTransaction.Amount := Random(500);
            DemoTransaction.Description := 'Old transaction from ' + Format(OldDate);
            DemoTransaction.Status := "Demo Transaction Status"::Archived;
            DemoTransaction."Processed Date" := OldDate;
            DemoTransaction.Insert(true);
        end;

        Message('Created 20 old transactions for retention policy testing');
    end;


}
