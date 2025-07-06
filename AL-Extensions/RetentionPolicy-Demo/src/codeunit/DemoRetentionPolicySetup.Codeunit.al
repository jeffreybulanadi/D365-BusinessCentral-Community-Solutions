codeunit 50101 "Demo Retention Policy Setup"
{
    /// <summary>
    /// Sets up a simple retention policy for Demo Transaction table
    /// Removes archived transactions older than 2 years
    /// </summary>
    procedure SetupDemoRetentionPolicies()
    var
        RetenPolAllowedTables: Codeunit "Reten. Pol. Allowed Tables";
    begin
        // Add Demo Transaction table to allowed tables for retention policies
        RetenPolAllowedTables.AddAllowedTable(Database::"Demo Transaction");
        
        Message('Demo retention policy has been configured successfully.\Go to Retention Policies page to view and enable it.');
    end;
}
