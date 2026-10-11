variable "project_organization_policies" {
  description = <<EOT
Map of project_organization_policies, attributes below
Required:
    - constraint
    - project
Optional:
    - deletion_policy
    - version
    - boolean_policy (block):
        - enforced (required)
    - list_policy (block):
        - allow (optional, block):
            - all (optional)
            - values (optional)
        - deny (optional, block):
            - all (optional)
            - values (optional)
        - inherit_from_parent (optional)
        - suggested_value (optional)
    - restore_policy (block):
        - default (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - read (optional)
        - update (optional)
EOT

  type = map(object({
    constraint      = string
    project         = string
    deletion_policy = optional(string)
    version         = optional(number)
    boolean_policy = optional(object({
      enforced = bool
    }))
    list_policy = optional(object({
      allow = optional(object({
        all    = optional(bool)
        values = optional(set(string))
      }))
      deny = optional(object({
        all    = optional(bool)
        values = optional(set(string))
      }))
      inherit_from_parent = optional(bool)
      suggested_value     = optional(string)
    }))
    restore_policy = optional(object({
      default = bool
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
}

