public with sharing class RuleEngine 
{
    private List<Opportunity_Score_Rule__c> oppRuleCfgs;
    
    public RuleEngine()
    {
        loadRules();
    }

    private void loadRules()
    {
        // get the rules from the custom setting and store in the oppRuleCfgs 
        // list, ordered by the Index__c field, low to high. 
        // E.g. first entry has index 10, second has index 20 etc
    }

    public Integer scoreOpportunity(Opportunity opp)
    {
        Integer totalScore=0;
        for (Opportunity_Score_Rule__c oppRuleCfg : oppRuleCfgs)
        {
            OpportunityScoringRuleIF oppRule;
            // create the OpportunityScoringRuleIF implementing class
            // based on the Implementing_Class_Name__c field
            totalScore+=oppRule.calculateScore(opp);
        }

        return totalScore;
    }
}
