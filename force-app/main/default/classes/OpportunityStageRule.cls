/****************************************************************************************************************************
* @name OpportunityStageRule
*
* @description: calculates a score of 10 if the opportunity is Closed Won, otherwise 0
*
* @author BrightGen TC
* @date 2021-12-01 
* @testmethod RuleEngline_Test 
*
* Changes:
*****************************************************************************************************************************/

public with sharing class OpportunityStageRule implements OpportunityScoringRuleIF, Comparable
{
    private static Opportunity_Score_Rule__c ruleConfig;
    private static final String OPP_STAGE_TO_SCORE = 'Closed Won';
    private static final Integer SCORE_INCREMENT = 10;                  //could also be stored in ruleConfig

    public Integer calculateScore(Opportunity Opp)
    {
        Integer score = 0;

        if(Opp.StageName == OPP_STAGE_TO_SCORE)
        {
            score += SCORE_INCREMENT;
        }

        return score;
    }

    public void setConfig(Object config)
    {
        if (null == ruleConfig)
        {
            ruleConfig = (Opportunity_Score_Rule__c) config;
        }
    }

    public Object getConfig()
    {
        return (Object) ruleConfig;
    }

    public Integer compareTo(Object compareToRule)
    {
        return OppScoringRuleService.CompareRules(ruleConfig, compareToRule);
    }
}