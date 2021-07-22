@isTest
private with sharing class RuleEngine_Test 
{
    @isTest
    static void CalculateScoreMax_Test()
    {
        List<Opportunity_Score_Rule__c> rules=
                    new List<Opportunity_Score_Rule__c>();

        rules.add(RuleTestFixtures.GetRule('Value', 10, 'OpportunityValueRule'));
        rules.add(RuleTestFixtures.GetRule('Stage', 20, 'OpportunityStageRule'));
        insert rules;

        Test.startTest();
        RuleEngine engine=new RuleEngine();
        Opportunity opp=new Opportunity(Name='Test Opp',
                                        StageName='Closed Won',
                                        Amount=2500000);

        Integer totalScore=engine.scoreOpportunity(opp);
        Test.stopTest();
        System.assertEquals(20, totalScore, 'Expected a score of 20 for a closed won opp worth 2.5 million');
    }

    @isTest
    static void CalculateScoreMin_Test()
    {
        List<Opportunity_Score_Rule__c> rules=
                    new List<Opportunity_Score_Rule__c>();

        rules.add(RuleTestFixtures.GetRule('Value', 10, 'OpportunityValueRule'));
        rules.add(RuleTestFixtures.GetRule('Stage', 20, 'OpportunityStageRule'));
        insert rules;

        Test.startTest();
        RuleEngine engine=new RuleEngine();
        Opportunity opp=new Opportunity(Name='Test Opp',
                                        StageName='Prospecting',
                                        Amount=5000);

        Integer totalScore=engine.scoreOpportunity(opp);
        Test.stopTest();
        System.assertEquals(0, totalScore, 'Expected a score of 0 for a prospecting opp worth 5k');
    }

    @isTest
    static void CalculateScoreHighValueEarlyStage_Test()
    {
        List<Opportunity_Score_Rule__c> rules=
                    new List<Opportunity_Score_Rule__c>();

        rules.add(RuleTestFixtures.GetRule('Value', 10, 'OpportunityValueRule'));
        rules.add(RuleTestFixtures.GetRule('Stage', 20, 'OpportunityStageRule'));
        insert rules;

        Test.startTest();
        RuleEngine engine=new RuleEngine();
        Opportunity opp=new Opportunity(Name='Test Opp',
                                        StageName='Prospecting',
                                        Amount=5000000);

        Integer totalScore=engine.scoreOpportunity(opp);
        Test.stopTest();
        System.assertEquals(10, totalScore, 'Expected a score of 10 for a prospecting opp worth 5 million');
    }

    @isTest
    static void CalculateScoreLateStageLowValue_Test()
    {
        List<Opportunity_Score_Rule__c> rules=
                    new List<Opportunity_Score_Rule__c>();

        rules.add(RuleTestFixtures.GetRule('Value', 10, 'OpportunityValueRule'));
        rules.add(RuleTestFixtures.GetRule('Stage', 20, 'OpportunityStageRule'));
        insert rules;

        Test.startTest();
        RuleEngine engine=new RuleEngine();
        Opportunity opp=new Opportunity(Name='Test Opp',
                                        StageName='Closed Won',
                                        Amount=15000);

        Integer totalScore=engine.scoreOpportunity(opp);
        Test.stopTest();
        System.assertEquals(10, totalScore, 'Expected a score of 10 for a closed won opp worth 15k');
    }

    @isTest
    static void CalculateScoreOnlyValue_Test()
    {
        List<Opportunity_Score_Rule__c> rules=
                    new List<Opportunity_Score_Rule__c>();

        rules.add(RuleTestFixtures.GetRule('Value', 10, 'OpportunityValueRule'));
        insert rules;

        Test.startTest();
        RuleEngine engine=new RuleEngine();
        Opportunity opp=new Opportunity(Name='Test Opp',
                                        StageName='Closed Won',
                                        Amount=5000);

        Integer totalScore=engine.scoreOpportunity(opp);
        Test.stopTest();
        System.assertEquals(0, totalScore, 'Expected a score of 0 for a closed won opp worth 5k if only the value matters');
    }

    @isTest
    static void CalculateScoreOnlyStage_Test()
    {
        List<Opportunity_Score_Rule__c> rules=
                    new List<Opportunity_Score_Rule__c>();

        rules.add(RuleTestFixtures.GetRule('Stage', 10, 'OpportunityStageRule'));
        insert rules;

        Test.startTest();
        RuleEngine engine=new RuleEngine();
        Opportunity opp=new Opportunity(Name='Test Opp',
                                        StageName='Prospecting',
                                        Amount=10000000);

        Integer totalScore=engine.scoreOpportunity(opp);
        Test.stopTest();
        System.assertEquals(0, totalScore, 'Expected a score of 0 for a prospecting opp worth 10 million if only the stage matters');
    }
}