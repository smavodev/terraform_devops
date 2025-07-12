resource "local_file" "validation_report" {
  filename = "validation-report-${var.environment}.txt"

  content = <<-EOF
    VALIDATION REPORT
    =================

    Environment: ${var.environment}
    Timestamp: ${timestamp()}

    Validation Results:
    %{ for check, result in local.configuration_validation ~}
    ${result ? "✅" : "❌"} ${check}: ${result}
    %{ endfor ~}

    Overall Status: ${local.all_validations_passed ? "✅ PASSED" : "❌ FAILED"}

    %{ if !local.all_validations_passed ~}
    Please fix the failing validations before proceeding.
    %{ endif ~}
  EOF
}
