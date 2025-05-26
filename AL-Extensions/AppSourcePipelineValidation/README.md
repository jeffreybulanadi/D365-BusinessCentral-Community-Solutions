# Business Central Extension AppSource Validation Pipeline

This project demonstrates a complete setup for automated testing and validation of Business Central extensions for AppSource submission. It includes a sample extension with automated tests and an Azure DevOps pipeline configuration that handles the entire validation process.

## Project Structure

```
AzurePipelineValidation/
├── .vscode/
│   ├── launch.json         # Debug configuration
│   ├── settings.json       # AL settings and code analyzers
│   └── ruleset.json        # Code analysis rules
├── app.json                # App manifest
├── azure-pipelines.yml     # CI/CD pipeline definition
└── src/
    ├── codeunit/
    │   └── Cod50200.PipelineDemoCU.al    # Sample business logic
    └── test/
        └── Cod50201.PipelineDemoTest.al   # Test cases
```

## Prerequisites

- Visual Studio Code with AL Language extension
- Docker Desktop
- Azure DevOps account
- Business Central development environment
- ALOps extension in your Azure DevOps organization

## Setting Up Local Development

1. Clone this repository:
```powershell
git clone <your-repo-url>
cd AzurePipelineValidation
```

2. Open in Visual Studio Code:
```powershell
code .
```

3. Update the `app.json` with your extension details:
   - Modify the `id`
   - Update `name` and `publisher`
   - Adjust `version` as needed

4. Modify `launch.json` with your environment details:
   - Update `environmentName`
   - Set correct `tenant`

## Running Tests Locally

1. Press F5 to deploy to your development environment
2. Use AL Test Runner in VS Code to execute tests
3. View test results in the Output window

## Azure DevOps Pipeline Setup

1. Create a new project in Azure DevOps
2. Import your repository
3. Create a new pipeline:
   - Choose "Azure Repos Git"
   - Select your repository
   - Choose "Existing Azure Pipelines YAML file"
   - Select `azure-pipelines.yml`

4. Configure pipeline variables:
   - Docker registry credentials (if needed)
   - Business Central license
   - Any environment-specific variables

## Pipeline Stages

The pipeline (`azure-pipelines.yml`) includes:

1. Build Stage
   - Creates Business Central container
   - Compiles AL app
   - Performs initial validation

2. Validation Stage
   - Runs AppSourceCop
   - Executes CodeCop analysis
   - Validates technical requirements

3. Test Stage
   - Runs all test codeunits
   - Generates test reports
   - Validates test coverage

4. Package Stage
   - Creates AppSource package
   - Publishes build artifacts
   - Prepares for submission

## AppSource Validation Checks

The pipeline automatically validates:

- Code quality and standards
- AL best practices
- Technical requirements
- Test coverage
- Documentation completeness
- Performance benchmarks
- AppSource compliance

## Test Framework

The sample includes:

- Unit tests for business logic
- Error scenario testing
- Test patterns and best practices
- Assert statements
- Test case documentation

## Best Practices

1. Code Organization:
   - Separate test codeunits
   - Clear naming conventions
   - Proper documentation

2. Testing:
   - Cover positive and negative scenarios
   - Include error handling tests
   - Validate all business logic

3. Validation:
   - Enable all code analyzers
   - Follow AL coding guidelines
   - Meet AppSource requirements

## Troubleshooting

Common issues and solutions:

1. Pipeline Failures:
   - Check Docker container logs
   - Verify Business Central version
   - Validate credentials and permissions

2. Test Failures:
   - Review test output
   - Check test environment
   - Verify test data

3. Validation Errors:
   - Review AppSourceCop output
   - Check code analysis results
   - Verify compliance requirements

## Additional Resources

- [Business Central Development Docs](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/)
- [AppSource Submission Guidelines](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-checklist-submission)
- [AL Test Framework](https://learn.microsoft.com/dynamics365/business-central/dev-itpro/developer/devenv-testing-application)
- [Azure DevOps Documentation](https://learn.microsoft.com/azure/devops/)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support:
- Open an issue in the repository
- Contact the development team
- Check the documentation

## Maintenance

Regular updates needed for:
- Business Central version compatibility
- AppSource requirements
- AL Language updates
- Pipeline configuration
