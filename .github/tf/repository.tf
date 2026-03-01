import {
  id = "repo-settings-as-code"
  to = github_repository.this
}
resource "github_repository" "this" {
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_squash_merge          = true
  allow_update_branch         = true
  archived                    = false
  archive_on_destroy          = true
  auto_init                   = false
  delete_branch_on_merge      = true
  description                 = "Composite action to manage GitHub repository settings with OpenTofu."
  has_discussions             = false
  has_issues                  = true
  has_projects                = false
  has_wiki                    = false
  homepage_url                = ""
  name                        = "repo-settings-as-code"
  squash_merge_commit_message = "BLANK"
  squash_merge_commit_title   = "PR_TITLE"
  topics                      = ["github-actions", "opentofu"]
  visibility                  = "public"
  vulnerability_alerts        = var.github_actions ? null : true
  web_commit_signoff_required = false

  dynamic "security_and_analysis" {
    for_each = var.github_actions ? [] : [true]
    content {
      secret_scanning {
        status = "enabled"
      }
      secret_scanning_push_protection {
        status = "enabled"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      # Cannot be imported
      archive_on_destroy,
      # Deprecated
      ignore_vulnerability_alerts_during_read,
    ]
  }
}
