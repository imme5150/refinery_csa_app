# encoding: utf-8
Refinery::Core.configure do |config|
  # When true will rescue all not found errors and display a friendly error page
  config.rescue_not_found = Rails.env.production?

  # When true this will force SSL redirection in all Refinery backend controllers.
  # config.force_ssl = false

  if Refinery::Setting.table_exists?
    # When true will use Amazon's Simple Storage Service instead of
    # the default file system for storing resources and images
    # config.s3_backend = true #!(ENV['S3_KEY'].nil? || ENV['S3_SECRET'].nil?)
    # config.s3_region = Refinery::Setting.find_or_set(:amazon_s3_region, 'us-west-2')
    # config.s3_secret_access_key = Refinery::Setting.find_or_set(:amazon_s3_secret_access_key, 'Paste your Amazon S3 Secret Access Key here')
    # config.s3_access_key_id = Refinery::Setting.find_or_set(:amazon_s3_access_key_id, 'Paste your Amazon S3 Access Key ID here')
    # config.s3_bucket_name = Refinery::Setting.find_or_set(:amazon_s3_bucket_name, 'Paste your Amazon S3 Bucket Name here')

    # Site name
    config.site_name = Refinery::Setting.find_or_set(:site_name, 'Site Name')
  end

  # Use a custom Dragonfly storage backend instead of the default
  # file system for storing resources and images
  config.dragonfly_custom_backend_class = 'Dragonfly::DataStorage::CloudinaryStore'
  # config.dragonfly_custom_backend_opts = {}

  # Whenever Refinery caches anything and can set a cache key, it will add
  # a prefix to the cache key containing the string you set here.
  # config.base_cache_key = :refinery

  # This activates Google Analytics tracking within your website. If this
  # config is left blank or set to UA-xxxxxx-x then no remote calls to
  # Google Analytics are made.
  # config.google_analytics_page_code = "UA-xxxxxx-x"

  # Enable/disable authenticity token on frontend
  # config.authenticity_token_on_frontend = false

  # Should set this if concerned about DOS attacks. See
  # http://markevans.github.com/dragonfly/file.Configuration.html#Configuration
  # config.dragonfly_secret = "af86d3b7f365ef9b6ca15f91b89e4a9f2109c4fd31d80635"

  # Register extra javascript for backend
  # config.register_javascript "prototype-rails"

  # Register extra stylesheet for backend (optional options)
  # config.register_stylesheet "custom", :media => 'screen'

  # Specify a different backend path than the default of /refinery.
  config.backend_route = "admin"
end
