/**
 * Created by VeronikaAlkhimenok on 7/5/2021.
 */

public class BatchableCalloutController implements Database.Batchable<AIInferenceRequest>, Database.AllowsCallouts {

    private static final String MODEL_ID = 'eb8e48bf-6a55-4145-a54b-f06a72d08188';
    private static final String QUERY = 'Squeaky Squirrel.';

    public Iterable<AIInferenceRequest> start(Database.BatchableContext bc) {
        List<AIInferenceRequest> suggestionsRequests = new List<AIInferenceRequest>();
        for (Integer i = 0; i < 150; i++) {
            suggestionsRequests.add(new AIInferenceRequest(MODEL_ID, QUERY));
        }
        return suggestionsRequests;
    }

    public void execute(Database.BatchableContext bc, List<AIInferenceRequest> scope) {

        List<AIInferenceRequest> successRequests = new List<AIInferenceRequest>();
        List<AIInferenceRequest> failedRequests = new List<AIInferenceRequest>();
        List<AIInferenceResponse> successResponses = new List<AIInferenceResponse>();

        for (AIInferenceRequest request : scope) {
            try {
                    successResponses.add(AIInferenceEndpoint.sendRequest(request));
                    successRequests.add(request);
            } catch (System.LimitException e) {
                failedRequests.add(request);
            }
        }
    }

    public void finish(Database.BatchableContext bc) {

    }

}