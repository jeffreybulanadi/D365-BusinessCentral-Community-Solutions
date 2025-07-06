codeunit 50102 "Demo Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        RetentionPolicySetup: Codeunit "Demo Retention Policy Setup";
    begin
        // Setup retention policy for demo table
        RetentionPolicySetup.SetupDemoRetentionPolicies();
    end;
}
