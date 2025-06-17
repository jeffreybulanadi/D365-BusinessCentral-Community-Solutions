codeunit 50100 "G/L Inconsistencies Mgt."
{
    SingleInstance = true;

    procedure IsTracking(): Boolean
    begin
        exit(TrackInconsistencies);
    end;

    procedure StartTracking()
    begin
        TrackInconsistencies := true;
    end;

    procedure StopTracking()
    begin
        TrackInconsistencies := false;
    end;

    procedure CopyRecords(var GLEntry: Record "G/L Entry" temporary; var TotalBalance: Decimal; var TotalDebits: Decimal; var TotalCredits: Decimal)
    begin
        GLEntry.DeleteAll();
        Clear(TotalBalance);
        Clear(TotalDebits);
        Clear(TotalCredits);
        if TempGLEntry.FindSet() then
            repeat
                GLEntry.Init();
                GLEntry := TempGLEntry;
                GLEntry.Insert();
                TotalBalance += GLEntry.Amount;
                TotalDebits += GLEntry."Debit Amount";
                TotalCredits += GLEntry."Credit Amount";
            until TempGLEntry.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterFinishPosting, '', false, false)]
    local procedure CodeunitGenJnlPostLineOnAfterFinishPosting(var GlobalGLEntry: Record "G/L Entry"; var GLRegister: Record "G/L Register"; var IsTransactionConsistent: Boolean; var GenJournalLine: Record "Gen. Journal Line")
    begin
        if (not IsTransactionConsistent) and TrackInconsistencies then begin
            GlobalGLEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
            TempGLEntry.DeleteAll();
            if GlobalGLEntry.FindSet() then
                repeat
                    TempGLEntry.Init();
                    TempGLEntry := GlobalGLEntry;
                    TempGLEntry.Insert();
                until GlobalGLEntry.Next() = 0;
            GlobalGLEntry.SetRange("Entry No.");
        end;
    end;

    var
        TempGLEntry: Record "G/L Entry" temporary;
        TrackInconsistencies: Boolean;
}