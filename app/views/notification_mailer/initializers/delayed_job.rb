require 'exceptional'

module Delayed
  module Plugins
    class ExceptionalNotify < Plugin
      module Notify
        def error(job, error)
          Exceptional.handle(error, job.handler)
          super if defined?(super)
        end
      end

      callbacks do |lifecycle|
        lifecycle.before(:invoke_job) do |job|
          payload = job.payload_object
          payload = payload.object if payload.is_a? Delayed::PerformableMethod
          payload.extend Notify
        end
      end
    end
  end
end

Delayed::Worker.plugins << Delayed::Plugins::ExceptionalNotify
