%dw 2.0
output application/json
var ccGrantOnly=(contains (payload.grant_types, "client_credentials") and sizeOf(payload.grant_types)==1)
---
{
	client_name: payload.client_name,
	client_uri: payload.client_uri,
	logo_uri: payload.logo_uri,
	redirect_uris: payload.redirect_uris map ( redirecturi , indexOfRedirecturi ) -> redirecturi,
	response_types: if(ccGrantOnly) ["token"] else payload.response_types map ( responsetype , indexOfResponsetype ) -> responsetype,
	grant_types: payload.grant_types map ( granttype , indexOfGranttype ) -> granttype,
	token_endpoint_auth_method: payload.token_endpoint_auth_method,
	application_type: if (ccGrantOnly) "service" else "web"
		
}