@ -0,0 +1,46 @@
Feature: Clokify Creación de workspace exitoso
  Background:
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl

  @GetAllProjectExitoso
  Scenario: GET all projects exitoso
    Given call Workspace.feature@GetWorkspaceInfo
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    When execute method GET
    Then the status code should be 200

  @AddNewProject
  Scenario Outline: POST Add a new project
    Given call Workspace.feature@GetWorkspaceInfo
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    And set value nameProyecto of key name in body jsons/bodies/NuevoProyecto.json
    When execute method POST
    Then the status code should be 201
    * define proyectoId = response.id
    * define workspaceId = {{workspaceId}}

    Examples:
      | nameProyecto |
      | NuevoProyecto 1 |

  @GetFindProjectById
  Scenario: GET Find project by ID
    Given call Project.feature@AddNewProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    When execute method GET
    Then the status code should be 200

  @AssignRemoveUserToFromTheProject
  Scenario Outline: GET Find project by ID
    Given call Project.feature@AddNewProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}/memberships
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    And set value userIDs of key userIds in body jsons/bodies/userProyect.json
    When execute method POST
    Then the status code should be 200

    Examples:
      | userIDs |
      | "1234" |

  @DeleteProjectFromWorkspaceBadRequest
  Scenario: Delete project from workspace bad request 400
    Given call Project.feature@GetFindProjectById
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    When execute method DELETE
    Then the status code should be 400

  @DeleteProjectFromWorkspaceExitoso
  Scenario: Delete project from workspace exitoso
    Given call Project.feature@UpdateProjectOnWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    When execute method DELETE
    Then the status code should be 200

  @DeleteProjectFromWorkspaceNoAutorizado
  Scenario: Delete project from workspace no autorizado
    Given call Project.feature@GetFindProjectById
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    When execute method DELETE
    Then the status code should be 401

  @DeleteProjectFromWorkspaceNoEncontrado
  Scenario: Delete project from workspace No encontrado
    Given call Project.feature@UpdateProjectOnWorkspace
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/221
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    When execute method DELETE
    Then the status code should be 404

  @UpdateProjectOnWorkspace
  Scenario Outline: UPDATE Project On Workspace
    Given call Project.feature@GetFindProjectById
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    And set value <nameProyecto> of key name in body jsons/bodies/ModificacionProyecto.json
    When execute method PUT
    Then the status code should be 200
    Examples:
      |nameProyecto|
      |"Proyecto Prueba Por API"|

  @UpdateProjectEstimate
  Scenario Outline: UPDATE project estimate
    Given call Project.feature@GetFindProjectById
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    And set value <nameProyecto> of key name in body jsons/bodies/ModificacionProyectoEstimate.json
    When execute method PATCH
    Then the status code should be 200
    Examples:
      |nameProyecto|
      |"Proyecto Prueba Por API"|

  @UpdateProjectMembershipOnWorkspace
  Scenario Outline: UPDATE Project On Workspace
    Given call Project.feature@GetFindProjectById
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}/memberships
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    And set value <memberships> of key memberships in body jsons/bodies/ModificacionProyectoMemberships.json
    When execute method PATCH
    Then the status code should be 200
    Examples:
      |memberships|
      |2000|


  @UpdateProjectTemplate
  Scenario: Update project template
    Given call Project.feature@AddNewProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}/template
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    And set value false of key template in body jsons/bodies/ProjectTemplate.json
    When execute method PATCH
    Then the status code should be 201

  @UpdateProjectUserCostRate
  Scenario: Update project template
    Given call Project.feature@AddNewProject
    And base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{proyectoId}}/users/6618421303a7b573aff3c282/cost-rate
    And header Content-Type = application/json
    And header x-api-key = OWViMWQ5OWMtYzBhMi00MGJmLWEyMjAtODdkM2FiYTk5ZTZl
    And set value "2020-01-01T00:00:00Z" of key since in body jsons/bodies/ProjectUserCost.json
    When execute method PUT
    Then the status code should be 200
