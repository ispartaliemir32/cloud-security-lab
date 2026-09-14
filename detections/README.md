# Detection Engineering

This directory contains defensive KQL detections and hunting queries intended for Microsoft Sentinel / Log Analytics labs.

## Design standard

Each detection should document:

- data source and expected table
- security hypothesis
- MITRE ATT&CK mapping
- threshold or time window
- expected false positives
- tuning guidance
- response / investigation steps

## Entra ID detections

### Multiple failed sign-ins

**File:** `entra/multiple-failed-signins.kql`

Hypothesis: repeated authentication failures against one account can indicate password spraying, brute force, stale credentials, or misconfigured automation.

Suggested investigation:

1. Review source IPs and geolocation.
2. Confirm whether the user recognizes the activity.
3. Look for a successful sign-in shortly after the failures.
4. Check identity risk, MFA events, device context, and targeted applications.
5. Tune known corporate egress addresses and expected service-account behavior.

### Risky successful sign-ins

**File:** `entra/risky-successful-signins.kql`

Hypothesis: a successful sign-in with medium/high Entra identity risk deserves investigation because valid credentials may have been abused.

Suggested investigation:

1. Review risk event types and Entra Identity Protection context.
2. Compare location, device, IP address, and application with normal behavior.
3. Review nearby sign-ins and authentication methods.
4. Revoke sessions or reset credentials only when supported by the investigation and organizational process.

## Production note

Lab thresholds are intentionally simple. Production detections should be baselined against normal behavior, service accounts, trusted networks, log ingestion delay, identity protection licensing, and the organization's incident-response process.
