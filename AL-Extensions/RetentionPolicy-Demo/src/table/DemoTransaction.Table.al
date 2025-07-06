table 50100 "Demo Transaction"
{
    Caption = 'Demo Transaction';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(2; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }

        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }

        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }

        field(5; "Transaction Type"; Enum "Demo Transaction Type")
        {
            Caption = 'Transaction Type';
        }

        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }

        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }

        field(10; Status; Enum "Demo Transaction Status")
        {
            Caption = 'Status';
        }

        field(11; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
        }

        key(TransactionDate; "Transaction Date")
        {
        }
    }

    trigger OnInsert()
    begin
    end;

    procedure GetNextEntryNo(): Integer
    var
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        exit(SequenceNoMgt.GetNextSeqNo(Database::"Demo Transaction"));
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;
}
