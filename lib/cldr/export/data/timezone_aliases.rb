module Cldr
  module Export
    module Data
      class TimezoneAliases < Base
        def initialize(*)
          super(nil)
          update(aliases)
        end

        private

        def aliases
          select('//ldmlBCP47/keyword/key[@name="tz"]/type').inject({}) do |result, tz_data|
            alias_attribute = tz_data.attr('alias')
            next result unless alias_attribute

            tz_ids = alias_attribute.split(' ')

            if tz_ids.size > 1
              canonical_tz_id = tz_ids.delete_at(0)

              tz_ids.each do |alias_tz_id|
                result[alias_tz_id] = canonical_tz_id
              end
            end

            result
          end
        end

        def path
          @path ||= File.join(
            Cldr::Export::Data.dir, 'bcp47', 'timezone.xml'
          )
        end
      end
    end
  end
end
