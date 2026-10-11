resource "google_project_organization_policy" "project_organization_policies" {
  for_each = var.project_organization_policies

  constraint      = each.value.constraint
  project         = each.value.project
  deletion_policy = each.value.deletion_policy
  version         = each.value.version

  dynamic "boolean_policy" {
    for_each = each.value.boolean_policy != null ? [each.value.boolean_policy] : []
    content {
      enforced = boolean_policy.value.enforced
    }
  }

  dynamic "list_policy" {
    for_each = each.value.list_policy != null ? [each.value.list_policy] : []
    content {
      dynamic "allow" {
        for_each = list_policy.value.allow != null ? [list_policy.value.allow] : []
        content {
          all    = allow.value.all
          values = allow.value.values
        }
      }
      dynamic "deny" {
        for_each = list_policy.value.deny != null ? [list_policy.value.deny] : []
        content {
          all    = deny.value.all
          values = deny.value.values
        }
      }
      inherit_from_parent = list_policy.value.inherit_from_parent
      suggested_value     = list_policy.value.suggested_value
    }
  }

  dynamic "restore_policy" {
    for_each = each.value.restore_policy != null ? [each.value.restore_policy] : []
    content {
      default = restore_policy.value.default
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

