@wip
Feature: User preferences
    @auth
    Scenario: List empty preferences
        Given empty "preferences"
        When we get "/preferences"
        Then we get error 405
        """
        {"_error": {"message": "The method is not allowed for the requested URL.", "code": 405}, "_status": "ERR"}
        """


    @auth
    Scenario: Create new preference
      Given we have sessions "/sessions"

      When we get "/preferences/#SESSION_ID#"
      Then we get default preferences

    @auth
    Scenario: Update user archive view preference settings
      Given we have sessions "/sessions"

      When we patch "/preferences/#SESSION_ID#"
      """
      {"user_preferences": {"archive:view": {"view": "compact" }}}
      """

      When we get "/preferences/#SESSION_ID#"
      Then we get existing resource
      """
      {"user": "#USERS_ID#", "user_preferences": {"archive:view":
      {
      "type": "string",
      "view": "compact",
      "default": "mgrid",
      "label": "Users archive view format",
      "category": "archive"
      }}}
      """

    @auth
    Scenario: Update user feature preview preference settings
      Given we have sessions "/sessions"

      When we patch "/preferences/#SESSION_ID#"
      """
      {"user_preferences": {"feature:preview": {"enabled": true }}}
      """

      When we get "/preferences/#SESSION_ID#"
      Then we get existing resource
      """
      {"user": "#USERS_ID#", "user_preferences": {"feature:preview":
      {
      "type": "bool",
      "enabled": true,
      "default": false,
      "label": "Enable Feature Preview",
      "category": "feature"
      }}}
      """


    @auth
    Scenario: Update user preference settings
      Given we have sessions "/sessions"

      When we patch "/preferences/#SESSION_ID#"
      """
      {"user_preferences": {"email:notification": {"enabled": false }}}
      """

      When we get "/preferences/#SESSION_ID#"
      Then we get existing resource
      """
      {"user": "#USERS_ID#", "user_preferences": {"email:notification":
      {
      "type": "bool",
      "enabled": false,
      "default": true,
      "label": "Send notifications via email",
      "category": "notifications"
      }}}
      """

    @auth
    Scenario: Update user preference settings - wrong preference
      Given we have sessions "/sessions"

      When we patch "/preferences/#SESSION_ID#"
      """
      {"user_preferences": {"email:bad_name": {"enabled": false }}}
      """
      Then we get error 400
      """
      {"_status": "ERR", "_issues": {"validator exception": "Invalid preference: email:bad_name"}}
	  """

    @auth
    Scenario: Update session preference settings
      Given we have sessions "/sessions"

      When we patch "/preferences/#SESSION_ID#"
      """
      {"session_preferences": {"some preference": {"something": "valueofsomething" }}}
      """

      When we get "/preferences/#SESSION_ID#"
      Then we get existing resource
      """
      {
      "session_preferences": {"some preference": {"something": "valueofsomething"}
      }}
      """

