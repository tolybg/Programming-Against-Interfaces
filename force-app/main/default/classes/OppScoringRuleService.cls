public with sharing class OppScoringRuleService 
{

    /*  Logic for Comparable interface implementation
    * 
    *   Rule with Index 1 is with higher priority than one with Index 2
    *   The implementation of this method returns the following values:
    *       0 if this instance and compareToRule are equal
    *       > 0 if this instance is greater than compareToRule
    *       < 0 if this instance is less than compareToRule
    *   https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_comparable.htm
     */
    
    public static Integer CompareRules(Object myConfig, Object compareToRule)
    {   
        Opportunity_Score_Rule__c rule = (Opportunity_Score_Rule__c) myConfig;
        OpportunityScoringRuleIF compareToRuleCasted = (OpportunityScoringRuleIF) compareToRule;
        Opportunity_Score_Rule__c otherRule =  (Opportunity_Score_Rule__c) compareToRuleCasted.getConfig();

        Double thisRuleIndex =  rule.Index__c;
        Double otherRuleIndex = otherRule.Index__c;

        //Avoid System.TypeException 
        if(thisRuleIndex != null && otherRuleIndex == null)
        {
            return 1;
        }

        if(thisRuleIndex == null && otherRuleIndex != null)
        {
            return -1;
        }

        if(thisRuleIndex == null && otherRuleIndex == null)
        {
            return 0;
        }


        //First Level - on Index
        if (thisRuleIndex > otherRuleIndex){
            return 1;
        }

        if (thisRuleIndex < otherRuleIndex){
            return -1;
        }

        if(thisRuleIndex == otherRuleIndex)
        {
            String thisRuleName = rule.Name;
            String otherRuleName = otherRule.Name;
            //Second Level - on Rule Name
            if(thisRuleName == otherRuleName)
            {
                return 0;
            } 
            else 
            {
                //rely on built-in string sorting algorythm
                List<String> names = new List<String>{thisRuleName, otherRuleName};
                names.sort();

                if(thisRuleName == names[0])
                {
                    return -1;
                }
                else
                {
                    return 1;
                }
            }
        }

        //should never get here
        return -1;
    }
}
