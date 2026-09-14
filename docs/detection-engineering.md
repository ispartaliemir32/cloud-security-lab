# Detection Engineering Notes

This repository treats detections as version-controlled engineering artifacts rather than one-off portal queries.

## Design goals

Each detection should answer five questions:

1. What behavior is suspicious?
2. Which telemetry is required?
3. Which MITRE ATT&CK technique does it map to?
4. What are the likely false positives?
5. What should an analyst investigate next?

## Detection lifecycle

1. **Hypothesis** — define the attacker behavior or risky administrative action.
2. **Telemetry** — identify the relevant table and fields.
3. **Query** — write the smallest KQL query that captures the behavior.
4. **Tuning** — account for service accounts, automation and known administrator activity.
5. **Validation** — test syntax and expected result shape against representative data.
6. **Deployment** — promote stable queries into Sentinel analytic rules.
7. **Review** — re-evaluate thresholds and exclusions as the environment changes.

## Current coverage

| Area | Detection | Data source | ATT&CK |
|---|---|---|---|
| Identity | Repeated failed sign-ins | `SigninLogs` | T1110 |
| Identity | Risky successful sign-ins | `SigninLogs` | T1078 |
| Identity | Privileged role change | `AuditLogs` | T1098 |
| Azure control plane | RBAC role assignment | `AzureActivity` | T1098 |
| Azure control plane | Resource group deletion | `AzureActivity` | T1485 |

## Tuning guidance

Avoid treating a query as production-ready merely because it returns results. Baseline normal administrative behavior, exclude approved automation only when the identity and purpose are well understood, and prefer narrow exclusions over broad suppression.

Thresholds in this repository are intentionally readable lab defaults. A production threshold should be driven by environment size, authentication patterns, privileged-role operating procedures and acceptable alert volume.

## Investigation context

Useful enrichment fields include:

- user principal name
- initiating identity
- source IP
- authentication result
- Conditional Access result
- subscription and resource scope
- correlation ID
- target identity or resource
- operation result

The incident-response playbook in `docs/incident-response.md` provides the next-step workflow after a detection fires.
