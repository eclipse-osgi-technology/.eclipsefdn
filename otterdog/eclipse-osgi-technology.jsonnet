local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-osgi-technology') {
  settings+: {
    description: "",
    name: " OSGi® Technology Project ",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "read",
    },
  },
  _repositories+:: [
    orgs.newRepo('jakartarest-osgi') {
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_alerts_enabled: false,
      description: "Glassfish Jersey based implementation of the OSGi Jakarta RESTful Web Services Whiteboard specification",
      homepage: "https://projects.eclipse.org/projects/technology.osgi-technology",
      topics+: [
        "jakarta",
        "osgi",
        "rest",
        "whiteboard"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
  ],
}
