# Cloud Security Lab

A practical Azure cloud security portfolio project focused on infrastructure-as-code, Microsoft Sentinel detections, identity monitoring, secure defaults, and CI validation.

## What this repository demonstrates

- Azure security architecture with Terraform
- Microsoft Sentinel / Log Analytics foundations
- Detection engineering with KQL
- Microsoft Entra ID sign-in monitoring
- Infrastructure validation in GitHub Actions
- Security documentation and threat-model thinking

## Architecture

```text
                +----------------------+
                |   Microsoft Entra ID |
                +----------+-----------+
                           |
                           | sign-in / audit telemetry
                           v
+----------------+   +-----+------------------+
| Azure Activity |-->| Log Analytics Workspace|
+----------------+   +-----------+------------+
                                |
                                v
                     +----------+-----------+
                     | Microsoft Sentinel   |
                     | Analytics & Hunting  |
                     +----------+-----------+
                                |
                     +----------+-----------+
                     | KQL Detection Rules  |
                     +----------------------+
```

## Repository structure

```text
.
├── .github/workflows/      # CI validation
├── detections/             # KQL detections and hunting queries
│   └── entra/
├── docs/                   # Architecture and security design notes
└── terraform/              # Azure lab infrastructure
```

## Detection catalogue

| Detection | Data source | Purpose | MITRE ATT&CK |
|---|---|---|---|
| Multiple failed sign-ins | `SigninLogs` | Detect repeated authentication failures against the same identity | T1110 |
| Risky successful sign-ins | `SigninLogs` | Surface successful sign-ins with elevated identity risk | T1078 |

> Queries are intended for a lab or learning environment. Tune thresholds and exclusions before production use.

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
4. **Detection-as-code** — KQL detections are version controlled.
5. **Shift-left validation** — Terraform formatting and validation run automatically in CI.
6. **Safe-by-default examples** — this repository is defensive and intentionally contains no offensive automation.

## Roadmap

- [x] Terraform foundation
- [x] Log Analytics workspace
- [x] Microsoft Sentinel onboarding
- [x] Entra ID KQL detections
- [x] GitHub Actions Terraform validation
- [ ] Azure Activity detections
- [ ] Microsoft Defender for Cloud recommendations
- [ ] Sentinel analytic-rule deployment as code
- [ ] Automated KQL linting/testing
- [ ] Incident-response playbooks
- [ ] Architecture diagram as code

## Disclaimer

This repository is a learning and portfolio project. It is not a complete production security baseline. Production environments require organization-specific governance, identity design, logging requirements, retention policies, networking controls, incident procedures, and regulatory review.

## License

MIT
