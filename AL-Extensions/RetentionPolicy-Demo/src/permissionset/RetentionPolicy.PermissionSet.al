permissionset 50100 "Retention Policy"
{
    Access = Public;
    Assignable = true;
    Caption = 'Demo Retention Policy';

    Permissions =
        table "Demo Transaction" = X,
        tabledata "Demo Transaction" = RIMD,
        codeunit "Demo Data Management" = X,
        codeunit "Demo Install" = X,
        codeunit "Demo Retention Policy Setup" = X,
        page "Demo Transactions" = X;
}
