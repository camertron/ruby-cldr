module Cldr
  module Export
    module Data
      class Variables < Base

        # only these variables will be exported
        VARIABLE_IDS = %w($grandfathered $language $territory $script $variant)

        def initialize
          super(nil)
          update(:variables => variables)
        end

        private

        def variables
          doc.xpath('//validity/variable').inject({}) do |ret, variable|
            name = variable.attribute('id').value
            if VARIABLE_IDS.include?(name)
              ret[fix_var_name(name)] = split_value_list(variable.text)
            end
            ret
          end
        end

        def fix_var_name(var_name)
          # remove leading dollar sign
          var_name.sub(/\A\$/, '')
        end

        def split_value_list(value_list)
          value_list.strip.split(/[\s]+/)
        end

        def path
          @path ||= "#{Cldr::Export::Data.dir}/supplemental/supplementalMetadata.xml"
        end

      end
    end
  end
end
