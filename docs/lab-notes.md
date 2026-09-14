# Lab notes

This file is where I keep the less polished notes behind the project: what I chose, what I would change in a real environment and what I still want to test.

## Why I started with identity detections

For this lab I started with Microsoft Entra ID because identity events are easy to relate to real security incidents. Failed sign-ins, risky successful sign-ins and privileged-role changes also give me a good mix of authentication and administrative activity to query with KQL.

The first failed-sign-in query currently uses a simple threshold of 10 failures in 15 minutes. That is intentionally a lab default, not something I would copy straight into production. In a real tenant I would first look at normal sign-in volume, service accounts, legacy clients and known automation before deciding on a threshold.

## What I learned while structuring the detections

A query that returns suspicious-looking rows is not automatically a useful detection. I found it more useful to think in this order:

1. what behaviour am I actually trying to catch?
2. which log table proves that behaviour?
3. which fields would an analyst need after the alert fires?
4. what normal activity could trigger the same query?
5. can the query later become a Sentinel analytic rule without rewriting everything?

That is why the detections try to keep useful investigation fields such as identity, source IP, app, location and timestamps in the final result instead of only returning a count.

## Things I would not call production-ready yet

- thresholds still need baselining against real tenant activity;
- there are no environment-specific allowlists or exclusions;
- KQL syntax is stored and reviewed as code, but there is no automated KQL test pipeline yet;
- Sentinel analytic-rule deployment is only partially represented and still needs to be moved fully into Terraform;
- Defender for Cloud coverage and SOAR automation are still on the roadmap.

I prefer keeping these limitations visible instead of presenting the lab as a finished security platform.

## Next things I want to add

The next useful additions for me are workload-identity/service-principal detections, a small Defender for Cloud section and one Logic App/SOAR example. I also want to add screenshots or sample query output once I have run the detections against a representative lab dataset.

## Certification focus

I am also using this repository as practical preparation for **SC-200 (Microsoft Security Operations Analyst)**. The parts that line up best with that goal are Sentinel, KQL, incident investigation, identity monitoring and detection engineering.
