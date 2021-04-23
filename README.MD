### Background
The Anypoint Platform adheres to the common OIDC standard and will only display grant types the IDP supports over OIDC. This information is fetched by using the issuer field to get the /.well-known/openid-configuration from the provider.  (https://docs.mulesoft.com/access-management/configure-client-management-openid-task#display-grant-types-in-the-api-portal) This is the explicit listing of what the IDP will support and our UI adjusts to the grant types listed here.  

OIDC Endpoints from identity providers commonly do not support Client Credential grant types common in system to system/API to API interactions, and OIDC Dynamic Client Registration does not account for ongoing management of client applications creating manual workaround and management steps. 

For example to manage client credentials grant types in Okta one would need to:
Register clients as auth code or other grant type, and enable client credentials for them within Okta.  The client app can obtain an Oauth token and both the OIDC Token validation policy or JWT Validation policy can validate the token even without it being an OIDC scoped request.  
The down sides are:
- Manual manipulation of the client app configuration in Okta to enable the additional grant type.
- Disconnected UI in the platform with the client app provisioning.
- Does not address OIDC gaps for secret reset and removal (would need to occur in Okta).

Alternatively a mediator application can be used to advertise a modified well known configuration, intercept and adapt client creation, update, deletion and secret rotation requests from the Anypoint Platform and make the appropriate non-OIDC API calls to the Identity Provider.  

The mediator is be used for endpoints related to 
- Issuer
- Client Create
- Client Update
- Client Secret Reset
- Client Delete

The mediator is not used for token validation and is not used in the direct path of any API traffic, only for administering OIDC Client updates and registrations.  As in a failure of this component will not cause a failure in the API Manager/Gateway or APIs under management.
This allows full functionality of managing clients in the platform and flow through to Okta supporting grant types not advertised by the IDP and addressing gaps in OIDC for external delete and update of existing clients.

Keep in mind using a mediator app and pattern is a customers responsibility to alter to their requirements, operationalize, deploy and support.  **This is not a supported component of the Anypoint Platform, and the requests sent by the Anypoint Platform could change without explicit notice.**  
