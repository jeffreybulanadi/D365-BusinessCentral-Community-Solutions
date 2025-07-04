pageextension 60020 "Vendor List" extends "Vendor List"
{
    actions
    {
        addlast(processing)
        {
            action("ShowContinueDemo")
            {
                ApplicationArea = All;
                Caption = 'BC26 Continue Demo';
                Image = ShowMatrix;
                ToolTip = 'Demonstrates the new continue keyword in Business Central 26';

                trigger OnAction()
                var
                    DemoMgt: Codeunit "Demo Mgt.";
                begin
                    DemoMgt.DemoContinueKeyword();
                end;
            }
        }
    }
}
