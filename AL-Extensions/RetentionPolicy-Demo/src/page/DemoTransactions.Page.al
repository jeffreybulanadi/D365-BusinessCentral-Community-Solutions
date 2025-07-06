page 50100 "Demo Transactions"
{
    ApplicationArea = All;
    Caption = 'Demo Transactions';
    PageType = List;
    SourceTable = "Demo Transaction";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateSampleData)
            {
                ApplicationArea = All;
                Caption = 'Create Sample Data';
                Image = CreateDocument;

                trigger OnAction()
                var
                    DemoDataMgt: Codeunit "Demo Data Management";
                begin
                    DemoDataMgt.CreateSampleTransactions();
                end;
            }

            action(CreateOldData)
            {
                ApplicationArea = All;
                Caption = 'Create Old Data';
                Image = CreateYear;

                trigger OnAction()
                var
                    DemoDataMgt: Codeunit "Demo Data Management";
                begin
                    DemoDataMgt.CreateOldTransactions();
                end;
            }

            action(SetupRetentionPolicy)
            {
                ApplicationArea = All;
                Caption = 'Setup Retention Policy';
                Image = Setup;

                trigger OnAction()
                var
                    RetentionPolicySetup: Codeunit "Demo Retention Policy Setup";
                begin
                    RetentionPolicySetup.SetupDemoRetentionPolicies();
                end;
            }

            action(OpenRetentionPolicies)
            {
                ApplicationArea = All;
                Caption = 'Open Retention Policies';
                Image = SetupList;
                RunObject = Page "Retention Policy Setup List";
            }
        }
    }
}
