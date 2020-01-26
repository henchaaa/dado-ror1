module Sanitization
  # include in operations that need to do input sanitization
  #
  # use:
  # sanitized_params({"field" => " value "}, {"field" => [:squish]})
  # #=> {"field" => "value"}

  extend ActiveSupport::Concern

  private

    # @return [Hash]
    def sanitized_params(params, sanitization_rules)
      sanitization_rules.each do |k, sanitization_methods|
        next unless params.key?(k)

        clean_value = params[k]

        if clean_value.is_a?(Hash)
          clean_value = sanitized_params(clean_value, sanitization_methods)
        else
          sanitization_methods.each do |sanitization_method|
            clean_value = send(sanitization_method, clean_value)
          end
        end

        params[k] = clean_value
      end

      params
    end

    def without_whitespace(text)
      text.gsub(%r'\s', "")
    end

    def squish(text)
      text.squish
    end
end
