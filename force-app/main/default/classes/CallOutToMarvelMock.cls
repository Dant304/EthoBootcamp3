public class CallOutToMarvelMock implements HttpCallOutMock {
	protected Integer code;
    protected String status;
    protected String body;
    
    public CallOutToMarvelMock(Integer httpCode){
        this.code = httpCode;
        if(httpCode == 200){
            this.status = 'OK';
            this.body = '';
        }else{
            this.status = 'NOK';
            this.body = '';
        }
    }
    
    public HttpResponse respond(HttpRequest request){
        HttpResponse response  = new HttpResponse();
        
        response.setBody(this.body);
        response.setStatus(this.status);
        response.setStatusCode(this.code);
        
        return response;
    }
}