/**
 * Created by VeronikaAlkhimenok on 7/5/2021.
 */

public with sharing class MainController {
    private static final String MODEL_ID = 'eb8e48bf-6a55-4145-a54b-f06a72d08188';
    private static final String QUERY = 'Squeaky Squirrel.';

    public static void main() {
        List<AIInferenceRequest> suggestionsRequests = new List<AIInferenceRequest>();
        for (Integer i = 0; i < 150; i++) {
            suggestionsRequests.add(new AIInferenceRequest(MODEL_ID, QUERY));
        }
        System.debug(AISuggestionCSPCalloutController.controllerCallouts(suggestionsRequests, 10000));
    }

}