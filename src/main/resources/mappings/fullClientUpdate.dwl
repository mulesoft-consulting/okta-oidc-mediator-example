%dw 2.0
output application/json
---
{
	client_id: vars.currentAppData.client_id,
	client_name: payload.client_name,
	client_uri: payload.client_uri,
	logo_uri: payload.logo_uri,
	application_type: vars.currentAppData.application_type,
	redirect_uris: payload.redirect_uris map ( redirecturi , indexOfRedirecturi ) -> redirecturi,
	post_logout_redirect_uris: vars.currentAppData.post_logout_redirect_uris map ( postlogoutredirecturi , indexOfPostlogoutredirecturi ) -> postlogoutredirecturi,
	response_types: payload.response_types map ( responsetype , indexOfResponsetype ) -> responsetype,
	grant_types: payload.grant_types map ( granttype , indexOfGranttype ) -> granttype,
	token_endpoint_auth_method: payload.token_endpoint_auth_method,
	initiate_login_uri: vars.currentAppData.initiate_login_uri
}