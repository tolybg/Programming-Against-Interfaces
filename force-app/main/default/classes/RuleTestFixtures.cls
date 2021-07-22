@isTest
public class RuleTestFixtures 
{
    public static Opportunity_Scoring_Rule__c GetRule(Integer idx,
                                                      String className)
    {
        Opportunity_Scoring_Rule__c rule=
                new Opportunity_Scoring_Rule__c(Index__c=idx,
                                                Implementing_Class_Name__c=className);

        return rule;
    }
}
