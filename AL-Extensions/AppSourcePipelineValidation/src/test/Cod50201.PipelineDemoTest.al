codeunit 50201 "Pipeline Demo Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure TestCalculateTotal()
    var
        PipelineDemo: Codeunit "Pipeline Demo Codeunit";
        Result: Decimal;
    begin
        // [GIVEN] Two decimal values
        // [WHEN] Calculating total
        Result := PipelineDemo.CalculateTotal(10.5, 20.5);
        
        // [THEN] Result should be correct
        Assert.AreEqual(31.0, Result, 'Total calculation is incorrect');
    end;

    [Test]
    procedure TestValidateInput()
    var
        PipelineDemo: Codeunit "Pipeline Demo Codeunit";
    begin
        // [GIVEN] Valid input text
        // [WHEN] Validating input
        // [THEN] No error should occur
        Assert.IsTrue(PipelineDemo.ValidateInput('Test Input'), 'Valid input should return true');
    end;

    [Test]
    procedure TestValidateInputError()
    var
        PipelineDemo: Codeunit "Pipeline Demo Codeunit";
    begin
        // [GIVEN] Empty input text
        // [WHEN] Validating input
        // [THEN] Error should occur
        asserterror PipelineDemo.ValidateInput('');
        Assert.ExpectedError('Input cannot be empty');
    end;

    [Test]
    procedure TestFormatDocumentNo()
    var
        PipelineDemo: Codeunit "Pipeline Demo Codeunit";
        Result: Text;
    begin
        // [GIVEN] Document number
        // [WHEN] Formatting document number
        Result := PipelineDemo.FormatDocumentNo('12345');
        
        // [THEN] Result should be correctly formatted
        Assert.AreEqual('DOC-12345', Result, 'Document number format is incorrect');
    end;

    var
        Assert: Codeunit Assert;
}
