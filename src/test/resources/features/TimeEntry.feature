@AllTest
Feature: Clokify Time Entry

  Background:
    Given base url $(env.base_url)
    And endpoint /v1/workspaces
    And header Content-Type = $(env.Content_Type)
    And header x-api-key = $(env.x_api_key)

  @AddNewtime
  Scenario Outline: POST Add a new time
    Given call Workspace.feature@GetWorkspaceInfo
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries
    And set value <Tiempo> of key start in body jsons/bodies/NuevoTiempo.json
    And set value <TiempoFinal> of key end in body jsons/bodies/NuevoTiempo.json
    When execute method POST
    Then the status code should be 201
    * define timeId = response.id
  Examples:
    | Tiempo | TiempoFinal |
    | "2024-06-06T12:00:00Z" |  "2024-06-06T12:10:00Z"  |

  @UpdateTimeEntry
  Scenario: PUT time entry
    Given call TimeEntry.feature@AddNewtime
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    And set value "2024-06-06T16:30:00Z" of key start in body jsons/bodies/NuevoTiempo.json
    And set value "2024-06-06T16:46:00Z" of key end in body jsons/bodies/NuevoTiempo.json
    And set value "TaskCurso" of key description in body jsons/bodies/NuevoTiempo.json
    When execute method PUT
    Then the status code should be 200
    * define timeId = response.id

  @GetTimeEntry
  Scenario: GET time entry
    Given call TimeEntry.feature@AddNewtime
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    When execute method GET
    Then the status code should be 200

  @DeleteTimeEntryFromWorkspace
  Scenario: Delete Time Entry From Workspace
    Given call TimeEntry.feature@GetTimeEntry
    And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeId}}
    When execute method DELETE
    Then the status code should be 204
