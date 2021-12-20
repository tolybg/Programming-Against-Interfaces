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

public with sharing class OpportunityStageRule implements OpportunityScoringRuleIF
{
    private static final String OPP_STAGE_TO_SCORE = 'Closed Won';
    private static final Integer SCORE_INCREMENT = 10;

    public Integer calculateScore(Opportunity Opp)
    {
        Integer score = 0;

        if(Opp.StageName == OPP_STAGE_TO_SCORE)
        {
            score += SCORE_INCREMENT;
        }

        return score;
    }
}
