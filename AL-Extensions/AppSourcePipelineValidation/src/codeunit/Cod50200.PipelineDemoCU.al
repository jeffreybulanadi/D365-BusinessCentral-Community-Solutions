codeunit 50200 "Pipeline Demo Codeunit"
{
    procedure CalculateTotal(Value1: Decimal; Value2: Decimal): Decimal
    begin
        exit(Value1 + Value2);
    end;

    procedure ValidateInput(InputText: Text): Boolean
    begin
        if InputText = '' then
            Error('Input cannot be empty');
        
        exit(true);
    end;

    procedure FormatDocumentNo(DocumentNo: Code[20]): Text
    begin
        if DocumentNo = '' then
            Error('Document No. cannot be empty');
        
        exit(StrSubstNo('DOC-%1', DocumentNo));
    end;
}
