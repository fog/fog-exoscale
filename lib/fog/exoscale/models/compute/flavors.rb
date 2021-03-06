require 'fog/core/collection'
require 'fog/exoscale/models/compute/flavor'

module Fog
  module Compute
    class Exoscale
      class Flavors < Fog::Collection
        model Fog::Compute::Exoscale::Flavor

        def all
          data = service.list_service_offerings["listserviceofferingsresponse"]["serviceoffering"] || []
          load(data)
        end

        def get(flavor_id)
          if flavor = service.list_service_offerings('id' => flavor_id)["listserviceofferingsresponse"]["serviceoffering"].first
            new(flavor)
          end
        rescue Fog::Compute::Exoscale::BadRequest
          nil
        end
      end
    end
  end
end
