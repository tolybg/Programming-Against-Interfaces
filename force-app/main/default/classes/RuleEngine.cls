public with sharing class RuleEngine 
{
    private List<Opportunity_Score_Rule__c> oppRuleCfgs; //why not custom metatadata types? 
    
    public RuleEngine()
    {
        loadRules();
    }

    private void loadRules()
    {
        // get the rules from the custom setting and store in the oppRuleCfgs 
        // list, ordered by the Index__c field, low to high. 
        // E.g. first entry has index 10, second has index 20 etc

        List<Opportunity_Score_Rule__c> sortedRules = new List<Opportunity_Score_Rule__c>();
        Map<String,Opportunity_Score_Rule__c> sortMap = new Map<String,Opportunity_Score_Rule__c>();

        for (Opportunity_Score_Rule__c rule : Opportunity_Score_Rule__c.getall().values()) 
        {
            String key = rule.Index__c + '_' + rule.Implementing_Class_Name__c ;
            sortMap.put(key, rule);
        }

        List<String> sortedKeys = new List<String>(sortMap.keyset());
        sortedKeys.sort();

        for (String key : sortedKeys) 
        {
            sortedRules.add(sortMap.get(key));
        }

        oppRuleCfgs = sortedRules;
    }

    public Integer scoreOpportunity(Opportunity opp)
    {
        Integer totalScore=0;
        for (Opportunity_Score_Rule__c oppRuleCfg : oppRuleCfgs)
        {
            // create the OpportunityScoringRuleIF implementing class
            // based on the Implementing_Class_Name__c field
            Type ruleType = Type.forName(oppRuleCfg.Implementing_Class_Name__c);
            OpportunityScoringRuleIF oppRule = (OpportunityScoringRuleIF) ruleType.newInstance();
            
            totalScore+=oppRule.calculateScore(opp);
        }

        return totalScore;
    }
}
