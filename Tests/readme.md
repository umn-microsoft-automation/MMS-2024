# Tests

Pester test files go here, and they will be run as part of the build process.
By default, the build will fail if any tests fail,
however if you specify `FailOnTestFailure` to be `false` in `azure-pipelines.yml`
test failures will be reported but they will not fail the job.

In addition to any tests in this directory, the pipeline will run PSScriptAnalyzer
against the module, and will also test to make sure each cmdlet has help text defined.

Each function should get its own test file here, named for the function.
Test files must end in `.Tests.ps1`.
For example, to write a test file for the function `Get-ModuleTemplate` the file would
be named `Get-ModuleTemplate.Tests.ps1`
