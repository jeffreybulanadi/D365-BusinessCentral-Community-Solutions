page 50100 "Review G/L Inconsistencies"
{
    Caption = 'Review G/L Inconsistencies';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTableTemporary = true;
    SourceTable = "G/L Entry";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    RefreshOnActivate = true;
    Permissions = tabledata "G/L Entry" = RIMD;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of Posting Date field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of Document No. field.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the value of G/L Account No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of Description field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of Global Dimension 2 Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of Amount field.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of Bal. Account Type field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of Bal. Account No. field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of Entry No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ToolTip = 'Specifies the value of   field.';
                }
            }
            group(Totals)
            {
                ShowCaption = false;
                fixed(FixedTotals)
                {
                    ShowCaption = false;
                    group(CurrentStatusGroup)
                    {
                        Caption = 'Current Status';
                        field(TrackingStatus; RunTrackingStatus())
                        {
                            ToolTip = 'Shows if the system is currently tracking G/L entry posting.';
                            ShowCaption = false;
                            StyleExpr = TrackingStatusStyle;
                        }
                    }
                    group(TotalDebitsGroup)
                    {
                        Caption = 'Total Debits';
                        field(TotalDebits; TotalDebits)
                        {
                            ToolTip = 'Shows the sum of Debits for all records.';
                            BlankZero = false;
                            BlankNumbers = DontBlank;
                            ShowCaption = false;
                            DecimalPlaces = 2;
                            Editable = false;
                        }
                    }
                    group(TotalCreditsGroup)
                    {
                        Caption = 'Total Credits';
                        field(TotalCredits; TotalCredits)
                        {
                            ToolTip = 'Shows the sum of Credits for all records.';
                            BlankZero = false;
                            BlankNumbers = DontBlank;
                            DecimalPlaces = 2;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }
                    group(TotalBalanceGroup)
                    {
                        Caption = 'Total Balance';
                        field(Balance; TotalBalance)
                        {
                            ToolTip = 'Shows the total balance of all the amounts';
                            BlankZero = false;
                            BlankNumbers = DontBlank;
                            DecimalPlaces = 2;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(PromotedStart; StartTracking) { }
                actionref(PromotedStop; StopTracking) { }
                actionref(PromotedRefresh; Refresh) { }
            }
        }
        area(Processing)
        {
            action(StartTracking)
            {
                Caption = 'Start Tracking';
                ToolTip = 'Starts tracking G/L Transactions.';
                Image = NextRecord;
                Enabled = not TrackingIsEnabled;
                trigger OnAction()
                begin
                    CheckGLInconsistencies.StartTracking();
                    TrackingIsEnabled := CheckGLInconsistencies.IsTracking();
                    SetTrackingStatusStyle();
                end;
            }
            action(StopTracking)
            {
                Caption = 'Stop Tracking';
                ToolTip = 'Stops tracking G/L Transactions.';
                Image = Stop;
                Enabled = TrackingIsEnabled;
                trigger OnAction()
                begin
                    CheckGLInconsistencies.StopTracking();
                    TrackingIsEnabled := CheckGLInconsistencies.IsTracking();
                    SetTrackingStatusStyle();
                end;
            }
            action(Refresh)
            {
                Caption = 'Refresh Entries';
                ToolTip = 'Refreshes the view for newly tracked records.';
                Image = Refresh;
                trigger OnAction()
                begin
                    CheckGLInconsistencies.CopyRecords(Rec, TotalBalance, TotalDebits, TotalCredits);
                    SetTrackingStatusStyle();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Clear(TotalBalance);
        Clear(TotalDebits);
        Clear(TotalCredits);

        TrackingIsEnabled := CheckGLInconsistencies.IsTracking();
        CheckGLInconsistencies.CopyRecords(Rec, TotalBalance, TotalDebits, TotalCredits);
        SetTrackingStatusStyle();
    end;

    local procedure RunTrackingStatus(): Text
    begin
        if TrackingIsEnabled then
            exit('Tracking');

        exit('Not Tracking');
    end;

    local procedure SetTrackingStatusStyle()
    begin
        if TrackingIsEnabled then
            TrackingStatusStyle := 'Favorable'
        else
            TrackingStatusStyle := 'Unfavorable';
    end;

    var
        CheckGLInconsistencies: Codeunit "G/L Inconsistencies Mgt.";
        TrackingIsEnabled: Boolean;
        TotalBalance: Decimal;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        TrackingStatusStyle: Text;


}