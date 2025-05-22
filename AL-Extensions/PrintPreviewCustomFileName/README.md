# Custom PDF File Names in Print Preview

## Forum Question

**Original question**: Asked by Samantha73 on May 22, 2025
"When printing documents without print preview, document created with the number as file name. However when print preview and then download you only get document as field name. Is there a way to automatically create meaningful file names when downloading PDF?"

https://community.dynamics.com/forums/thread/details/?threadid=41c0c97b-c936-f011-8c4e-0022481fa6ba

## Solution Overview

This solution demonstrates how to:
1. Customize the file name generation for PDF downloads in print preview
2. Automatically include the document number in the PDF file name
3. Implement this for various document types (Sales Orders, Purchase Orders, etc.)

## Implementation Details

The solution modifies the default behavior of the print preview functionality to:
- Capture the document number before printing
- Generate a meaningful file name using the document type and number
- Apply the custom file name during the PDF download process

## Installation Instructions

1. Download the AL project files
2. Open in Visual Studio Code with the AL Language extension
3. Update the `app.json` with your extension details
4. Build and publish the extension to your Business Central environment
5. Assign the permission set to users who need access to this functionality

## Additional Considerations

- The solution works with standard Business Central reports
- Custom file naming patterns can be configured based on document type
- Compatible with both cloud and on-premises deployments
- Supports multi-language environments

## Screenshots

(Screenshots showing the print preview dialog with custom file names will be added here)
