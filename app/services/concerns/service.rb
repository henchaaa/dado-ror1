module Service
  # Include this module in services
  # to signal Single Responsibility Principle compliance and a single .call proc

  extend ActiveSupport::Concern

  module ClassMethods
    def call(**options)
      new(**options).call
    end
  end
end
