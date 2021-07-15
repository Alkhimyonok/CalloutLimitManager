/**
 * Created by VeronikaAlkhimenok on 7/7/2021.
 */

@IsTest
public with sharing class AISuggestionCSPCalloutControllerTest {
    private static final String MODEL_ID = 'eb8e48bf-6a55-4145-a54b-f06a72d08188';
    private static final String QUERY = 'Squeaky Squirrel.';

    @IsTest
    private static void buildRequestShouldSetExpectedAttributesOnRequest() {
        AIInferenceEndpointHttpMock responseMock = new AIInferenceEndpointHttpMock();
        responseMock.setResponseType(AIInferenceEndpointHttpMock.ResponseType.SUCCESS);
        Test.setMock(HttpCalloutMock.class,responseMock);

        List<AIInferenceRequest> suggestionsRequests = new List<AIInferenceRequest>();
        for (Integer i = 0; i < 150; i++) {
            suggestionsRequests.add(new AIInferenceRequest(MODEL_ID, QUERY));
        }

        Test.startTest();
        RequestWrapper requestWrapper = AISuggestionCSPCalloutController.controllerCallouts(suggestionsRequests, 10000);
        Test.stopTest();

        System.assertNotEquals(null, requestWrapper);
        System.assertEquals(100, requestWrapper.successRequests.size());
        System.assertEquals(50, requestWrapper.notCompletedRequests.size());
        System.assertEquals(100, requestWrapper.successResponses.size());
    }

}