# frozen_string_literal: true

require "yabeda"
require "yabeda/grape/version"

module Yabeda
  module Grape
    LONG_RUNNING_REQUEST_BUCKETS = [
      0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5, 5, 10, # standard
      30, 60, 120, 300, 600, # Sometimes requests may be really long-running
    ].freeze

    class << self
      def bind_metrics
        Yabeda.configure do
          group :grape

          counter   :requests_total, comment: "A counter of the total number of HTTP requests rails processed.",
                                     tags: %i[method path status]
          histogram :request_duration, unit: :seconds, buckets: LONG_RUNNING_REQUEST_BUCKETS,
                                       tags: %i[method path status],
                                       comment: "A histogram of the response latency."

          ActiveSupport::Notifications.subscribe 'endpoint_run.grape' do |*args|
            event = ActiveSupport::Notifications::Event.new(*args)

            next unless (labels = Yabeda::Grape.extract_labels(event))

            grape_requests_total.increment(labels)
            grape_request_duration.measure(labels, Yabeda::Grape.ms2s(event.duration))
          end
        end
      end

      def ms2s(ms)
        (ms.to_f / 1000).round(3)
      end

      def extract_labels(event)
        return unless (endpoint = event.payload[:endpoint])

        # endpoint.route.path can throw an error in Grape inside_route.rb, which
        # is caught below
        path = endpoint.route&.path # path description (e.g. /user/{id}.json)
        method = endpoint.options[:method]&.first&.downcase # http method
        status = endpoint.status # http code

        { method: method, path: path, status: status }
      rescue StandardError
        nil
      end
    end
  end
end
