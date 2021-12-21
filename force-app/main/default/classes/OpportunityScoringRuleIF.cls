public interface OpportunityScoringRuleIF 
{
    Integer calculateScore(Opportunity opp);

    void setConfig(Object customSetting);
    Object getConfig();

    //Sort rules
    //compareToRule is another OpportunityScoringRuleIF implementation 
    Integer compareTo(Object compareToRule); 

}
