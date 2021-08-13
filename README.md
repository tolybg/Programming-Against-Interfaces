# Programming Against Interfaces Plug-In Architecture Challenge

## About

This challenge checks your knowledge of Programming Against Interfaces when using a plug-in architecture to configure Apex classes in use at runtime.

The concept of this challenge is a rules engine that calculates a score
for an opportunity via configurable (plug and play) rules.  The rules implement an interface `OpportunityScoringRuleIF` and are defined by instances of the `Opportunity_Score_Rule__c` custom setting.

You will need to complete the two classes that apply rules to calculate a score for an opportunity:

1. `OpportunityStageRule` - this calculates a score of 10 if the opportunity is Closed Won, otherwise 0
1. `OpportunityValueRule` - this calculates a score of 10 if the opportunity has a value of 2.5 million or above

These rules should be configured in via the custom setting detailed above, with the stage rule being executed first.

## Notes
You must have list custom settings enabled in your target org - navigate to `Setup -> Schema Settings` and enable `Manage list custom settings type` 

## Testing the Challenge

### Scratch Org
If you want to iterate on your development, use a scratch org and the Salesforce CLI force:source:push/pull commands.

### Developer Edition
To deploy to a developer edition, use the source deploy command :
`sfdx force:source:deploy -p force-app -w 10 -u <username>`

if you don't want to deploy the code, you can carry out a check deployment and execute the tests to get the results:

`sfdx force:source:deploy -l RunSpecifiedTests -r RuleEngine_Test -c -u <username> -p force-app -w 10 `


