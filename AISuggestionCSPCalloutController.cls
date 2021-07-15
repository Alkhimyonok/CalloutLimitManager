/**
 * Created by VeronikaAlkhimenok on 7/1/2021.
 */

public with sharing class AISuggestionCSPCalloutController {
    private static final Integer NUMBER_CALLOUTS_LIMIT = Limits.getLimitCallouts();
    private static final Integer CALLOUT_TIMEOUT_LIMIT = 120000;

    public static RequestWrapper controllerCallouts(List<AIInferenceRequest> suggestionRequests, Integer defaultConnectionTimeout) {
        List<AIInferenceRequest> performedRequests = new List<AIInferenceRequest>();
        List<AIInferenceRequest> notPerformedRequests = new List<AIInferenceRequest>();
        List<AIInferenceResponse> receivedResponses = new List<AIInferenceResponse>();

        Long timeUsedForCallouts = 0;
        Long timeLeftForCallouts = 120000;

        for (AIInferenceRequest request : suggestionRequests) {
            try {
                if (NUMBER_CALLOUTS_LIMIT - Limits.getCallouts() > 0
                        && (CALLOUT_TIMEOUT_LIMIT - timeUsedForCallouts) > 0
                        && timeLeftForCallouts > 0) {

                    Long startTime = DateTime.now().getTime();
                    if (timeLeftForCallouts < defaultConnectionTimeout) {
                        receivedResponses.add(AIInferenceEndpoint.sendRequest(request, (Integer) timeLeftForCallouts));
                    } else {
                        receivedResponses.add(AIInferenceEndpoint.sendRequest(request, defaultConnectionTimeout));
                    }
                    Long stopTime = DateTime.now().getTime();

                    timeUsedForCallouts += stopTime - startTime;
                    timeLeftForCallouts -= timeUsedForCallouts;

                    performedRequests.add(request);
                } else {
                    notPerformedRequests.add(request);
                }
            } catch (CalloutException e) {
                notPerformedRequests.add(request);
            }
        }
        return new RequestWrapper(performedRequests, notPerformedRequests, receivedResponses);
    }

}