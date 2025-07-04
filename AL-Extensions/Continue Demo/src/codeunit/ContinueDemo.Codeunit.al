codeunit 60010 "Demo Mgt."
{
    /// <summary>
    /// Demonstrates the new 'continue' keyword functionality introduced in Business Central 26.
    /// This procedure showcases how the continue keyword enables cleaner loop logic by
    /// skipping to the next iteration without nested if-statements.
    /// </summary>
    /// <remarks>
    /// The demo processes vendors and filters out:
    /// - Blocked vendors (any blocked status)
    /// - Vendors missing email addresses
    /// Results are displayed in a message showing valid vs filtered vendors.
    /// Processing is limited to prevent overwhelming output in the demo.
    /// </remarks>
    /// <example>
    /// Call this procedure from a page action or codeunit to see the continue keyword in action:
    /// <code>
    /// DemoMgt: Codeunit "Demo Mgt.";
    /// DemoMgt.DemoContinueKeyword();
    /// </code>
    /// </example>
    procedure DemoContinueKeyword()
    var
        Vendor: Record Vendor;
        FilteredOut: Integer;
        ValidVendors: Integer;
        DemoOutput: Text;
        DemoOutputBuilder: TextBuilder;
    begin
        // Build the header using TextBuilder
        DemoOutputBuilder.AppendLine('Business Central 26: Continue Keyword Demo');
        DemoOutputBuilder.AppendLine('==========================================');
        DemoOutputBuilder.AppendLine();

        // Initialize counters
        ValidVendors := 0;
        FilteredOut := 0;

        // Let's look at the first batch of vendors
        Vendor.Reset();
        if Vendor.FindSet() then
            repeat
                // Here's the magic: continue keyword in action!
                // Skip any blocked vendors immediately
                if Vendor.Blocked <> Vendor.Blocked::" " then begin
                    FilteredOut += 1;
                    DemoOutputBuilder.AppendLine(StrSubstNo('Filtered out: %1 (%2) - Vendor blocked', Vendor."No.", Vendor.Name));
                    continue; // Jump to next iteration - no nested ifs needed!
                end;

                // Skip vendors without contact info
                if Vendor."E-Mail" = '' then begin
                    FilteredOut += 1;
                    DemoOutputBuilder.AppendLine(StrSubstNo('Filtered out: %1 (%2) - Missing email', Vendor."No.", Vendor.Name));
                    continue; // Again, clean exit without nesting
                end;

                // Vendor passed all checks - let's include them
                ValidVendors += 1;
                DemoOutputBuilder.AppendLine(StrSubstNo('Valid vendor: %1 (%2)', Vendor."No.", Vendor.Name));
            until (Vendor.Next() = 0) or (ValidVendors + FilteredOut >= GetDemoLimit());

        // Add results using TextBuilder
        DemoOutputBuilder.AppendLine();
        DemoOutputBuilder.AppendLine('DEMO RESULTS:');
        DemoOutputBuilder.AppendLine(StrSubstNo('Valid vendors found: %1', ValidVendors));
        DemoOutputBuilder.AppendLine(StrSubstNo('Filtered out: %1', FilteredOut));
        DemoOutputBuilder.AppendLine(StrSubstNo('Total evaluated: %1', ValidVendors + FilteredOut));
        DemoOutputBuilder.AppendLine();
        DemoOutputBuilder.AppendLine('The beauty of continue: No more nested if-statements!');
        DemoOutputBuilder.Append('Clean, readable code that handles edge cases upfront.');

        // Convert TextBuilder to Text and display
        DemoOutput := DemoOutputBuilder.ToText();
        Message(DemoOutput);
    end;

    local procedure GetDemoLimit(): Integer
    begin
        exit(8); // Keep demo concise
    end;
}
