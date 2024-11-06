local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local branchProtectionRule(branchName) = orgs.newBranchProtectionRule(branchName) {
  required_approving_review_count: 0,
  requires_linear_history: true,
  requires_strict_status_checks: true,
};

local newOSGiTechRepo(repoName, default_branch = 'main') = orgs.newRepo(repoName) {
  allow_squash_merge: false,
  allow_update_branch: false,
  default_branch: default_branch,
  delete_branch_on_merge: false,
  dependabot_security_updates_enabled: true,
  has_wiki: false,
  homepage: "https://projects.eclipse.org/projects/technology.osgi-technology",
  web_commit_signoff_required: false,
  branch_protection_rules: [
    branchProtectionRule($.default_branch) {},
  ],
};


orgs.newOrg('eclipse-osgi-technology') {
  settings+: {
    description: "",
    name: " OSGi® Technology Project ",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
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

    newOSGiTechRepo('.github') {
      description: "github organisation repository, defaults for all other Repositories",
    },

    newOSGiTechRepo('maven-pom') {
      description: "Repository for the maven poms",
    },

    newOSGiTechRepo('feature-launcher') {
      description: "Repository for the feature-launcher osgi implementation",
    },

    newOSGiTechRepo('jakarta-webservices') {
      description: "Repository for the jakarta-webservices osgi implementation",
    },

    newOSGiTechRepo('jakarta-websockets') {
      description: "Repository for the jakarta-websockets osgi implementation",
    },
  ],
}
