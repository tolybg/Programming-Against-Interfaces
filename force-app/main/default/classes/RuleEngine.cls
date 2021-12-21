public with sharing class RuleEngine 
{
    // private List<Opportunity_Score_Rule__c> oppRuleCfgs;
    private List<OpportunityScoringRuleIF> scoringRules = new List<OpportunityScoringRuleIF>();
    
    public RuleEngine()
    {
        loadRules();
    }

    private void loadRules()
    {
        // get the rules from the custom setting and store in the oppRuleCfgs list

        for (Opportunity_Score_Rule__c ruleCfg : Opportunity_Score_Rule__c.getall().values()) 
        {
            // create the OpportunityScoringRuleIF implementing class
            // based on the Implementing_Class_Name__c field
            Type ruleType = Type.forName(ruleCfg.Implementing_Class_Name__c);
            OpportunityScoringRuleIF oppRule = (OpportunityScoringRuleIF) ruleType.newInstance();
            oppRule.setConfig(ruleCfg);
            scoringRules.add(oppRule);
        }

        // ordered by the Index__c field, low to high. 
        // E.g. first entry has index 10, second has index 20 etc
        scoringRules.sort();
    }

    public Integer scoreOpportunity(Opportunity opp)
    {
        Integer totalScore=0;
        for (OpportunityScoringRuleIF rule : scoringRules)
        {
            totalScore+=rule.calculateScore(opp);
        }

        return totalScore;
    }
}
