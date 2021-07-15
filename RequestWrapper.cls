/**
 * Created by VeronikaAlkhimenok on 7/6/2021.
 */

public with sharing class RequestWrapper {
    @TestVisible private List<AIInferenceRequest> successRequests = new List<AIInferenceRequest>();
    @TestVisible private List<AIInferenceRequest> notCompletedRequests = new List<AIInferenceRequest>();
    @TestVisible private List<AIInferenceResponse> successResponses = new List<AIInferenceResponse>();

    public RequestWrapper() {
        this.successRequests = new List<AIInferenceRequest>();
        this.notCompletedRequests = new List<AIInferenceRequest>();
        this.successResponses = new List<AIInferenceResponse>();
    }

    public RequestWrapper(List<AIInferenceRequest> successRequests, List<AIInferenceRequest> notCompletedRequests, List<AIInferenceResponse> successResponses) {
        this.successRequests = successRequests;
        this.notCompletedRequests = notCompletedRequests;
        this.successResponses = successResponses;
    }

}