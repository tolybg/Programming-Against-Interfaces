@isTest
public class RuleTestFixtures 
{
    public static Opportunity_Score_Rule__c GetRule(String name, 
                                                    Integer idx,
                                                      String className)
    {
        Opportunity_Score_Rule__c rule=
                new Opportunity_Score_Rule__c(Name=name,
                                              Index__c=idx,
                                              Implementing_Class_Name__c=className);

        return rule;
    }
}