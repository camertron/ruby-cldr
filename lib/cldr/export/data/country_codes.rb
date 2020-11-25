module Cldr
  module Export
    module Data
      class CountryCodes < Base
        def initialize
          super(nil)
          update(:country_codes => country_codes)
        end

        private

        def country_codes 
          doc.xpath("//codeMappings/*").each_with_object({}) do |node, hash|
            if node.name == "territoryCodes"
              type = node.attribute('type').to_s.to_sym
              hash[type] = {}
              hash[type]["numeric"] = node[:numeric] if node[:numeric]
              hash[type]["alpha3"] = node[:alpha3] if node[:alpha3]
            end
          end        
        end

        def path
          @path ||= "#{Cldr::Export::Data.dir}/supplemental/supplementalData.xml"
        end
      end
    end
  end
end
