local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

local branchProtectionRule(branchName) = orgs.newBranchProtectionRule(branchName) {
  required_approving_review_count: 0,
  requires_linear_history: false,
  requires_strict_status_checks: true,
};

local newOSGiTechRepo(repoName, default_branch = 'main') = orgs.newRepo(repoName) {
  allow_squash_merge: false,
  allow_update_branch: false,
  code_scanning_default_setup_enabled: true,
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


orgs.newOrg('technology.osgi-technology', 'eclipse-osgi-technology') {
  settings+: {
    description: "",
    name: " OSGi® Technology Project ",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
    orgs.newOrgSecret('GITLAB_API_TOKEN') {
      value: "pass:bots/technology.osgi-technology/gitlab.eclipse.org/api-token",
    },
    orgs.newOrgSecret('GPG_KEY_ID') {
      value: "pass:bots/technology.osgi-technology/gpg/key_id",
    },
    orgs.newOrgSecret('GPG_PASSPHRASE') {
      value: "pass:bots/technology.osgi-technology/gpg/passphrase",
    },
    orgs.newOrgSecret('GPG_PRIVATE_KEY') {
      value: "pass:bots/technology.osgi-technology/gpg/secret-subkeys.asc",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_PASSWORD') {
      value: "pass:bots/technology.osgi-technology/central.sonatype.org/token-password",
    },
    orgs.newOrgSecret('CENTRAL_SONATYPE_TOKEN_USERNAME') {
      value: "pass:bots/technology.osgi-technology/central.sonatype.org/token-username",
    },
    orgs.newOrgSecret('DOCKER_HUB_USER') {
      value: "pass:bots/technology.osgi-technology/docker.com/username",
    },
    orgs.newOrgSecret('DOCKER_HUB_TOKEN') {
      value: "pass:bots/technology.osgi-technology/docker.com/api-token",
    },
  ],
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
      code_scanning_default_languages: [
        "actions",
      ],
    },

    newOSGiTechRepo('maven-pom') {
      description: "Repository for the maven poms",
      code_scanning_default_languages: [
        "actions",
      ],
    },

    newOSGiTechRepo('command') {
      description: "Repository for the command related bundles",
      code_scanning_default_languages: [
        "actions",
        "java-kotlin",
      ],
    },

    newOSGiTechRepo('console') {
      description: "Repository for the console related bundles",
      code_scanning_default_languages: [
        "actions",
        "java-kotlin",
      ],
    },

    newOSGiTechRepo('feature-launcher') {
      description: "Repository for the feature-launcher osgi implementation",
      code_scanning_default_languages: [
        "actions",
        "java-kotlin",
      ],
    },

    newOSGiTechRepo('jakarta-webservices') {
      description: "Repository for the jakarta-webservices osgi implementation",
      code_scanning_default_languages: [
        "actions",
        "java-kotlin",
      ],
    },

    newOSGiTechRepo('jakarta-websockets') {
      description: "Repository for the jakarta-websockets osgi implementation",
    },

    newOSGiTechRepo('scheduler') {
      description: "Repository for the scheduler related bundles",
      code_scanning_default_languages: [
        "actions",
        "java-kotlin",
      ],
    },

    newOSGiTechRepo('plurl') {
      description: "Plurl library for managing multiple URL handler factories ",
    },

    newOSGiTechRepo('incubator') {
      description: "Repository for the incubating/draft bundles",
      code_scanning_default_languages: [
        "java-kotlin",
      ],
    },
    
    orgs.newRepo('osgi-test') {
      allow_merge_commit: true,
      allow_rebase_merge: false,
      allow_squash_merge: false,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "Testing support for OSGi. Includes JUnit 4 and JUnit 5 support and AssertJ support.",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/docs",
      homepage: "https://osgi.github.io/osgi-test/",
      topics+: [
        "assertj",
        "assertj-support",
        "junit",
        "junit4",
        "junit5",
        "osgi",
        "osgi-testing",
        "test",
        "testing"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        allow_action_patterns+: [
          "gradle/gradle-build-action@*",
          "gradle/wrapper-validation-action@*",
          "gradle/actions/wrapper-validation@*",
          "gradle/actions/setup-gradle@*",
          "step-security/harden-runner@*"
        ],
        allow_verified_creator_actions: false,
        allowed_actions: "selected",
      },
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    orgs.newRepo('osgi.enroute') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "The OSGi enRoute project provides a programming model of OSGi applications. This project contains bundles providing the API for the OSGi enRoute base profile and bundles for the OSGi enRoute project. The base profile establishes a runtime that contains a minimal set of services that can be used as a base for applications.",
      homepage: "https://enroute.osgi.org/",
      topics+: [
        "java",
        "osgi-applications",
        "osgi-enroute"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        allow_verified_creator_actions: false,
        allowed_actions: "selected",
      },
      secrets: [
        orgs.newRepoSecret('REPOSITORY_PASSWORD') {
          value: "********",
        },
        orgs.newRepoSecret('REPOSITORY_USERNAME') {
          value: "********",
        },
      ],
    },
    orgs.newRepo('osgi.enroute.site') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "gh-pages",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "GitHub Pages repo for OSGi enRoute website",
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "gh-pages",
      gh_pages_source_path: "/",
      has_wiki: false,
      homepage: "https://enroute.osgi.org/",
      topics+: [
        "osgi-enroute-website"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        allow_action_patterns+: [
          "ruby/setup-ruby@*"
        ],
        allow_verified_creator_actions: false,
        allowed_actions: "selected",
      },
      webhooks: [
        orgs.newRepoWebhook('https://notify.travis-ci.org') {
          events+: [
            "create",
            "delete",
            "issue_comment",
            "member",
            "public",
            "pull_request",
            "push",
            "repository"
          ],
        },
      ],
      environments: [
        orgs.newEnvironment('github-pages'),
      ],
    },
    
    orgs.newRepo('slf4j-osgi') {
      allow_merge_commit: true,
      allow_update_branch: false,
      dependabot_security_updates_enabled: true,
      description: "SLF4J Binding for OSGi Log Service",
      topics+: [
        "osgi",
        "slf4j-binding",
        "slf4j-osgi"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        allow_action_patterns+: [
          "step-security/harden-runner@*"
        ],
        allow_verified_creator_actions: false,
        allowed_actions: "selected",
      },
    },       
  ],
}
