<%@ page import="java.text.*, java.util.*, java.sql.ResultSet"%>
<script language="javascript">
var clientId = '512579143973.apps.googleusercontent.com';
var apiKey = 'AIzaSyBmDKtUuYheNUGaMz7dc3xtwFl3e9m48CY';
var scopes = 'https://www.googleapis.com/auth/analytics.readonly';

/**
 * =============================================================================
 * Callback executed once the Google APIs Javascript client library has loaded.
 * The function name is specified in the onload query parameter of URL to load
 * this library. After 1 millisecond, checkAuth is called.
 * =============================================================================
 */
function handleClientLoad() {
  gapi.client.setApiKey(apiKey);
  window.setTimeout(checkAuth, 1);
}


/**
 * =============================================================================
 * Uses the OAuth2.0 clientId to query the Google Accounts service
 * to see if the user has authorized. Once complete, handleAuthResults is
 * called.
 * =============================================================================
 */
function checkAuth() {
	var config = {
			'client_id': clientId,
			'scope': scopes
	 };
    gapi.auth.authorize(config, handleAuthResult);
}


/**
 * =============================================================================
 * Handler that is called once the script has checked to see if the user has
 * authorized access to their Google Analytics data. If the user has authorized
 * access, the analytics api library is loaded and the handleAuthorized
 * function is executed. If the user has not authorized access to their data,
 * the handleUnauthorized function is executed.
 * @param {Object} authResult The result object returned form the authorization
 *     service that determine whether the user has currently authorized access
 *     to their data. If it exists, the user has authorized access.
 * =============================================================================
 */
function handleAuthResult(authResult) {
  if (authResult) {
    gapi.client.load('analytics', 'v3', handleAuthorized);
  } else {
    handleUnauthorized();
  }
}


/**
 * =============================================================================
 * Call makeApiCall if GA authorize application
 * =============================================================================
 */
function handleAuthorized() {
  document.all.dvStatus.innerHTML += "Application have been authorized.";
  window.setTimeout(makeApiCall, 10);
}

/**
 * =============================================================================
 * if user unauthorized to this script show authorize-button.
 * =============================================================================
 */
function handleUnauthorized() {
  var authorizeButton = document.getElementById('authorize-button');
  authorizeButton.style.visibility = '';
  authorizeButton.onclick = handleAuthClick;
  document.all.dvStatus.innerHTML += "Please authorize this script to access Google Analytics.";
}


/**
 * =============================================================================
 * Handler for clicks on the authorization button. This uses the OAuth2.0
 * clientId to query the Google Accounts service to see if the user has
 * authorized. Once complete, handleAuthResults is called.
 * @param {Object} event The onclick event.
 * =============================================================================
 */
function handleAuthClick(event)
{
  gapi.auth.authorize({
    client_id: clientId, scope: scopes, immediate: false}, handleAuthResult);
  return false;
}

</script>

<script src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>

