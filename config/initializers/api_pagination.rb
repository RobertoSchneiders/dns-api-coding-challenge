# frozen_string_literal: true

ApiPagination.configure do |config|
  config.page_param = :page
  config.include_total = false
end
