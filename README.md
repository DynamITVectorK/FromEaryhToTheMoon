# AL-Go Per Tenant Extension Template

This template repository can be used for managing Per-tenant Extensions (PTEs) for Business Central.

Please go to https://aka.ms/AL-Go to learn more.

## Sandbox deployment setup

This repository is configured to deploy from CI/CD to an AL-Go environment named `Sandbox`.

Required GitHub configuration:
- Create a GitHub Environment named `Sandbox`
- Add one of these secrets with Business Central auth context JSON:
  - `Sandbox-AuthContext`
  - `Sandbox_AuthContext`
  - `AuthContext`
- (Optional) add environment variable `ALGoEnvironmentSettings` if you use environment-specific overrides

## Contributing

Please read [this](https://github.com/microsoft/AL-Go/blob/main/Scenarios/Contribute.md) description on how to contribute to AL-Go for GitHub.

We do not accept Pull Requests on the template repository directly.
