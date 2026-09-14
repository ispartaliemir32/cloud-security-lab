# Security Policy

This repository contains defensive cloud-security examples and intentionally avoids offensive automation, credential harvesting, persistence mechanisms, or destructive tooling.

## Reporting a vulnerability

If you find a security issue in the code or examples, open a GitHub issue without including real credentials, tenant identifiers, access tokens, or other sensitive information.

## Secret handling

- Never commit Azure credentials, client secrets, certificates, tokens, or `.tfvars` files containing sensitive values.
- Prefer short-lived authentication and workload identity / OIDC for automation.
- Treat all example identifiers as placeholders unless explicitly documented otherwise.
- Rotate any credential immediately if it is accidentally committed.

## Scope

The repository is a portfolio and learning environment, not a certified production security baseline. Users are responsible for validating controls against their own cloud environment, threat model, compliance requirements, and licensing.
