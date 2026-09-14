# Cloud Security Lab

[![Terraform CI](https://github.com/ispartaliemir32/cloud-security-lab/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/ispartaliemir32/cloud-security-lab/actions/workflows/terraform-ci.yml)

I built this lab to get more hands-on with Azure security instead of only reading about Sentinel, KQL and incident response.

The main focus is Microsoft Sentinel, Entra ID, KQL detections, Azure Activity monitoring and Terraform. I am also using the repo as practical preparation for **SC-200 (Microsoft Security Operations Analyst)**.

## What is in the repo

- Microsoft Sentinel + Log Analytics foundation
- KQL detections for Entra ID and Azure Activity
- privileged-role and RBAC monitoring
- Sentinel analytic-rule examples
- incident-response notes
- Terraform for the lab foundation
- GitHub Actions validation
- MITRE ATT&CK mapping

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
│   ├── entra/                  # Entra ID detections
│   └── azure-activity/         # Azure control-plane detections
├── sentinel/analytics/         # Sentinel analytic-rule templates
├── docs/
│   ├── detection-engineering.md
│   ├── incident-response.md
│   └── lab-notes.md
└── terraform/                  # Azure + Sentinel lab foundation
```

## Current detections

| Detection | Data source | Purpose | MITRE ATT&CK |
|---|---|---|---|
| Multiple failed sign-ins | `SigninLogs` | Repeated authentication failures against one identity | T1110 |
| Risky successful sign-ins | `SigninLogs` | Successful sign-ins with elevated identity risk | T1078 |
| Privileged role change | `AuditLogs` | Additions to privileged Entra roles | T1098 |
| Azure RBAC role assignment | `AzureActivity` | New Azure role assignments | T1098 |
| Resource group deletion | `AzureActivity` | Destructive resource-group operations | T1485 |

These are lab detections. Thresholds and exclusions still need to be tuned before they make sense in a real tenant.

## A small example

The failed-sign-in detection currently looks for 10 or more failures in 15 minutes for the same identity. That makes the query easy to understand while I am learning, but I would not use that value blindly in production. Normal sign-in volume, service accounts and automation all matter.

## Detection workflow

```text
Hypothesis -> Telemetry -> KQL -> Tuning -> Validation -> Analytic Rule -> Incident Response
```

More detail is in [`docs/detection-engineering.md`](docs/detection-engineering.md).

I also keep less polished notes, limitations and next steps in [`docs/lab-notes.md`](docs/lab-notes.md).

## Deploy the lab foundation

Prerequisites:

- Terraform >= 1.7
- Azure CLI authenticated to a test subscription
- permission to create resource groups and Log Analytics resources

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

## What is still missing

- [ ] Defender for Cloud examples
- [ ] service-principal and workload-identity detections
- [ ] automated KQL linting/testing
- [ ] full Sentinel analytic-rule deployment through Terraform
- [ ] SOAR / Logic App response example
- [ ] screenshots or sample query output from a representative lab dataset

## Notes

This is a learning lab, not a production security baseline. I am deliberately keeping the limitations visible instead of making the repo look more finished than it is.

MIT licensed.
