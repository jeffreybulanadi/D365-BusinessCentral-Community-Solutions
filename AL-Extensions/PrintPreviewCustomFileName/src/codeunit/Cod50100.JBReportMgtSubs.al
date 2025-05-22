codeunit 50100 "JB Report Mgt. Subs."
{
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeSaveAttachment', '', false, false)]
    local procedure TableDocumentAttachmentOnBeforeSaveAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FileName: Text)
    var
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustomFileNameLbl: Label '%1 This will be your custom name', Comment = '%1 - Represents the document number or identifier';
        CustomFileName: Text;
    begin
        // Only handle our specific report
        if not FileName.Contains(Format(Report::"Standard Sales - Invoice")) then
            exit;

        if RecRef.Number = Database::"Sales Invoice Header" then begin
            RecRef.SetTable(SalesInvoiceHeader);
            if Customer.Get(SalesInvoiceHeader."Bill-to Customer No.") then
                CustomFileName := StrSubstNo(CustomFileNameLbl, SalesInvoiceHeader."No.");

            FileName := CopyStr(CustomFileName + '.pdf', 1, MaxStrLen(DocumentAttachment."File Name"));
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", 'OnBeforeGetAttachmentFileName', '', false, false)]
    local procedure CodeunitCodeunitDocumentMailingOnBeforeGetAttachmentFileName(EmailDocumentName: Text[250]; PostedDocNo: Code[20]; ReportUsage: Integer; var AttachmentFileName: Text[250])
    var
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustomFileNameLbl: Label '%1 This will be your custom name', Comment = '%1 - Represents the document number or identifier';
        CustomFileName: Text;
    begin
        // Only handle our specific report
        if GetReportIDUsedForSalesInvoice(ReportUsage) = Report::"Standard Sales - Invoice" then
            if SalesInvoiceHeader.Get(PostedDocNo) then begin
                if Customer.Get(SalesInvoiceHeader."Bill-to Customer No.") then
                    CustomFileName := StrSubstNo(CustomFileNameLbl, SalesInvoiceHeader."No.");

                AttachmentFileName := CopyStr(CustomFileName + '.pdf', 1, MaxStrLen(AttachmentFileName));
            end;
    end;

    local procedure GetReportIDUsedForSalesInvoice(ReportSelectionUsage: Integer): Integer
    var
        ReportSelection: Record "Report Selections";
    begin
        ReportSelection.SetRange(Usage, ReportSelectionUsage);
        if ReportSelection.FindFirst() then
            exit(ReportSelection."Report ID");
    end;
}