locals {
  configuration_validation = {
    prod_requirements_met = (
      var.environment == "prod" ? (
        var.application_config.features.monitoring == true &&
        var.application_config.features.backup == true &&
        var.application_config.runtime.memory >= 1024
      ) : true
    )

    resource_names_unique = length(distinct([
      var.app_name,
      var.application_config.name
    ])) == 2
  }

  all_validations_passed = alltrue(values(local.configuration_validation))
}
