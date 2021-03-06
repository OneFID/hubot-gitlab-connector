class GitlabClient
  constructor: (@robot, @url, @token) ->

  request = ->
    @robot.http(@url).header('Accept', 'application/json').header('PRIVATE-TOKEN', @token)

  getVersion: () ->
    request.call(this).path('/api/v4/version').get()

  getTriggers: (projectId) ->
    request.call(this).path('/api/v4/projects/' + projectId + '/triggers').get()

  getProject: (projectId) ->
    request.call(this).path('/api/v4/projects/' + projectId).get()

  getProjectsByName: (searchName) ->
    request.call(this).path('/api/v4/projects?search=' + searchName).get()

  getProjects: () ->
    request.call(this).path('/api/v4/projects').get()

  getBranches: (projectId) ->
    request.call(this).path('/api/v4/projects/' + projectId + '/repository/branches').get()

  getMergeRequests: (projectId, filter) ->
    filterPath=""
    if (filter !="")
      filterPath="?"+filter
    request.call(this).path('/api/v4/projects/' + projectId + '/merge_requests'+filterPath).get()

  acceptMergeRequest: (projectId, merge_iid) ->
    request.call(this).path('/api/v4/projects/' + projectId + '/merge_requests/'+merge_iid+'/merge').put()

  triggerPipeline: (projectId, params) ->
    request.call(this).header('Content-type', 'application/json').path('/api/v4/projects/' + projectId + '/trigger/pipeline').post(params)

module.exports = GitlabClient
