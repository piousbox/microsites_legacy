
# development_cached
Microsites2::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  config.action_controller.page_cache_directory = '/home/piousbox/projects/microsites2/tmp/cache/pages'
  config.assets.compile = true

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  # config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
