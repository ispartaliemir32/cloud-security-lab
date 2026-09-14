# Cloud Security Lab

[![Terraform CI](https://github.com/ispartaliemir32/cloud-security-lab/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/ispartaliemir32/cloud-security-lab/actions/workflows/terraform-ci.yml)

A practical Azure cloud security portfolio project focused on infrastructure-as-code, Microsoft Sentinel, Microsoft Entra ID, KQL detection engineering, incident response and automated CI validation.

## What this repository demonstrates

- Azure security architecture with Terraform
- Microsoft Sentinel and Log Analytics foundations
- Detection engineering with KQL
- Microsoft Entra ID sign-in and privileged-role monitoring
- Azure control-plane monitoring with `AzureActivity`
- Detection-as-code with Sentinel analytic rule templates
- Incident-response documentation and investigation workflows
- Infrastructure validation in GitHub Actions
- MITRE ATT&CK mapping and security design thinking

## Architecture

```text
                 +----------------------+
                 | Microsoft Entra ID   |
                 | Sign-ins + AuditLogs |
                 +----------+-----------+
                            |
                            v
+----------------+   +------+-------------------+
| Azure Activity |-->| Log Analytics Workspace |
+----------------+   +-----------+--------------+
                                 |
                                 v
                      +----------+-----------+
                      | Microsoft Sentinel   |
                      | SIEM / Analytics     |
                      +----------+-----------+
                                 |
               +-----------------+-----------------+
               |                                   |
               v                                   v
      +--------+---------+                +--------+---------+
      | KQL Detections   |                | Analytic Rules   |
      | Detection-as-Code|                | Alert Generation |
      +--------+---------+                +--------+---------+
               |                                   |
               +-----------------+-----------------+
                                 v
                      +----------+-----------+
                      | Incident Response    |
                      | Triage + Containment |
                      +----------------------+
```

## Repository structure

```text
.
├── .github/workflows/          # Terraform CI validation
├── detections/
│   ├── entra/                  # Entra ID sign-in and role detections
│   └── azure-activity/         # Azure control-plane detections
├── sentinel/analytics/         # Sentinel analytic-rule templates
├── docs/
│   ├── detection-engineering.md
│   └── incident-response.md
└── terraform/                  # Azure + Sentinel lab foundation
```

## Detection catalogue

| Detection | Data source | Purpose | MITRE ATT&CK |
|---|---|---|---|
| Multiple failed sign-ins | `SigninLogs` | Detect repeated authentication failures against the same identity | T1110 |
| Risky successful sign-ins | `SigninLogs` | Surface successful sign-ins with elevated identity risk | T1078 |
| Privileged role change | `AuditLogs` | Detect additions to Microsoft Entra privileged roles | T1098 |
| Azure RBAC role assignment | `AzureActivity` | Detect new Azure role assignments | T1098 |
| Resource group deletion | `AzureActivity` | Detect destructive resource-group operations | T1485 |

> Queries are intended for a lab or learning environment. Tune thresholds, exclusions and required telemetry before production use.

## Detection engineering workflow

```text
Hypothesis -> Telemetry -> KQL -> Tuning -> Validation -> Analytic Rule -> Incident Response
```

The design methodology is documented in [`docs/detection-engineering.md`](docs/detection-engineering.md), including tuning guidance and investigation context.

## Incident response

The repository includes an analyst-oriented playbook covering:

- identity compromise triage
- suspicious privileged-role changes
- Azure control-plane incidents
- containment and recovery
- evidence preservation
- severity guidance

See [`docs/incident-response.md`](docs/incident-response.md).

## Deploy the lab foundation

Prerequisites:

- Terraform >= 1.7
- Azure CLI authenticated to a test subscription
- Permission to create resource groups and Log Analytics resources

```bash
cd terraform
terraform init
terraform fmt -check
terraform validate
terraform plan -var="subscription_id=<SUBSCRIPTION_ID>"
```

To deploy:

```bash
terraform apply -var="subscription_id=<SUBSCRIPTION_ID>"
```

## Security principles used

1. **Least privilege** — the repository does not require or store Azure credentials.
2. **No hard-coded secrets** — authentication should use Azure CLI locally or OIDC in CI/CD.
3. **Infrastructure as code** — cloud resources are reproducible and reviewable.
4. **Detection-as-code** — KQL detections and Sentinel rule definitions are version controlled.
5. **Shift-left validation** — Terraform formatting and validation run automatically in CI.
6. **Threat-informed monitoring** — detections are mapped to MITRE ATT&CK techniques.
7. **Documented response** — alerts are paired with investigation and incident-response guidance.
8. **Safe-by-default examples** — this repository is defensive and contains no offensive automation.

## Roadmap

- [x] Terraform foundation
- [x] Log Analytics workspace
- [x] Microsoft Sentinel onboarding
- [x] Entra ID KQL detections
- [x] Azure Activity detections
- [x] GitHub Actions Terraform validation
- [x] Detection engineering methodology
- [x] Incident-response playbook
- [x] Sentinel analytic-rule template
- [ ] Microsoft Defender for Cloud posture examples
- [ ] Additional service-principal and workload-identity detections
- [ ] Automated KQL linting/testing
- [ ] Sentinel analytic-rule deployment through Terraform
- [ ] SOAR / Logic App response playbook example
- [ ] Architecture diagram as code

## Portfolio talking points

This project can be discussed in interviews as an example of combining **cloud infrastructure, identity security, SIEM engineering, KQL, IaC, CI/CD and incident response** in one version-controlled security lab.

## Disclaimer

This repository is a learning and portfolio project. It is not a complete production security baseline. Production environments require organization-specific governance, identity design, logging requirements, retention policies, networking controls, incident procedures and regulatory review.

## License

MIT
