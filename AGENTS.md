# Agent notes

`docker-compose-bulk` is a wrapper for running bulk operations across Docker
Compose projects.

- Test changes with disposable Compose projects and review the target set
  before commands that stop or remove containers.
- Run ShellCheck on shell-script changes and validate flake changes with the
  repository's Nix checks.
- Before adding or changing workflows, check for reusable workflows or actions
  in [ci-workflows](https://github.com/pschmitt/ci-workflows) and preserve
  existing caller behavior and check coverage.
