module Cldr
  module Export
    module Data
      class Territories < Base
        def initialize(locale)
          super
          update(:territories => territories)
        end

        def territories
          @territories ||= select('localeDisplayNames/territories/territory').inject({}) do |result, node|
            unless draft?(node)
              entry = { value: node.content }

              if alt = node.attribute('alt')
                entry[:alt] = alt.value
              end

              if draft = node.attribute('draft')
                entry[:draft] = draft.value
              end

              (result[node.attribute('type').value.to_sym] ||= []) << entry
            end

            result
          end
        end
      end
    end
  end
end
