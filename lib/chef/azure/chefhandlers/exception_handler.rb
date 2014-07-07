require 'chef/log'
require 'chef/azure/helpers/shared'

module AzureExtension
  class ExceptionHandler < Chef::Handler
    include ChefAzure::Shared
    include ChefAzure::Config
    include ChefAzure::Reporting

    def report
      if run_status.failed?
        load_azure_env
        message = "Check log file for details...\nBacktrace:\n"
        message << Array(backtrace).join("\n")
        report_status_to_azure message, "error"
      end
    end
  end
end
