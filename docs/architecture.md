# Architecture and Threat Model

## Goal

The lab provides a small, reproducible Azure security-monitoring foundation that demonstrates how identity and control-plane telemetry can be centralized and analyzed with Microsoft Sentinel.

## Logical architecture

```text
Users / Workloads
       |
       v
Microsoft Entra ID -------------------+
       |                               |
       | SigninLogs / AuditLogs        |
       v                               |
Azure Monitor / Diagnostic Sources    |
       |                               |
       +---------------+---------------+
                       v
             Log Analytics Workspace
                       |
                       v
               Microsoft Sentinel
                 /            \
                v              v
        Analytics rules    Hunting queries
                |              |
                +------+-------+
                       v
                 Investigation
```

## Trust boundaries

### Identity boundary

Microsoft Entra ID controls user and workload authentication. Identity telemetry is treated as security-sensitive because it can reveal compromised accounts, unusual sign-ins, and authentication failures.

### Azure control plane

Changes to subscriptions and resources can represent legitimate administration or attacker activity. Azure Activity logs should therefore be ingested and correlated with identity events.

### Detection layer

KQL is stored as code in GitHub. Changes are reviewable and version controlled, reducing undocumented changes to detection logic.

### CI boundary

CI currently validates Terraform syntax and formatting only. It deliberately does not deploy infrastructure and therefore requires no Azure secret or long-lived cloud credential.

## Example threats

| Threat | Security signal | Planned / implemented control |
|---|---|---|
| Password spraying / brute force | Repeated failed sign-ins | KQL failed sign-in detection |
| Stolen credentials | Successful risky sign-in | KQL identity-risk detection |
| Unauthorized resource changes | Azure Activity operations | Planned activity-log detections |
| Detection tampering | Changes to KQL or Terraform | Git history and pull-request workflow |
| Secret leakage | Credentials committed to source | No credentials required; `.gitignore` and CI design |

## Design decisions

- **Terraform over click-ops:** infrastructure can be reviewed, reproduced, and destroyed consistently.
- **Detection-as-code:** detections live alongside infrastructure and documentation.
- **No automatic apply:** a public portfolio repository should not require cloud credentials merely to validate contributions.
- **Short default retention:** 30 days keeps a lab inexpensive while remaining useful for demonstrations.
- **Single workspace:** intentionally simple for a portfolio lab; production environments may use different workspace strategies based on tenant, geography, ownership, regulation, and scale.

## Future architecture work

1. Connect Azure Activity logs.
2. Add Sentinel analytic-rule resources in Terraform.
3. Add Defender for Cloud recommendations and posture examples.
4. Add incident-response automation examples using Logic Apps.
5. Add automated security scanning and KQL quality checks.
