# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: stream.proto for package 'stream'

require 'grpc'
require 'stream_pb'

module Stream
  module StreamingService
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'stream.StreamingService'

      rpc :GetTrackAudio, TrackRequest, stream(TrackSample)
    end

    Stub = Service.rpc_stub_class
  end
end
