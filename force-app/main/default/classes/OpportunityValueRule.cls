/****************************************************************************************************************************
* @name OpportunityValueRule
*
* @description:  calculates a score of 10 if the opportunity has a value of 2.5 million or above
*
* @author BrightGen TC
* @date 2021-12-01 
* @testmethod RuleEngline_Test
*
* Changes:
*****************************************************************************************************************************/
public with sharing class OpportunityValueRule implements OpportunityScoringRuleIF
{
    private static final Decimal OPP_AMOUNT_THRESHOLD = 2500000;
    private static final Integer scoreIncrement = 10;

    public Integer calculateScore(Opportunity Opp)
    {
        Integer score = 0;

        if(Opp.Amount >= OPP_AMOUNT_THRESHOLD)
        {
            score += scoreIncrement;
        }

        return score;
    }
}
