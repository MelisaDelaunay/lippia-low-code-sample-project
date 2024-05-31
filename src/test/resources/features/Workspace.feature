@ -0,0 +1,46 @@
Feature: Clokify Creación de workspace exitoso
  Background:
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl

  @AddNewWorkspace
  Scenario Outline: POST Workspace
    And set value <nameWorkspace> of key name in body jsons/bodies/NuevoWorkspace.json
    When execute method POST
    Then the status code should be 201
    * define workspaceId = response.id

    Examples:
      | nameWorkspace |
      | NuevoWorkspace 2 |

@GetWorkspaceInfo
  Scenario: GET Workspace info
  Given call Workspace.feature@AddNewWorkspace
  And base url https://api.clockify.me/api
  And endpoint /v1/workspaces/{{workspaceId}}
  And header Content-Type = application/json
  And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
  When execute method GET
  Then the status code should be 200

