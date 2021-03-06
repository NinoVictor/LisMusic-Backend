#
# Autogenerated by Thrift Compiler (0.13.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'stream_types'

module StreamingService
  class Client
    include ::Thrift::Client

    def GetTrackAudio(trackRequest)
      send_GetTrackAudio(trackRequest)
      return recv_GetTrackAudio()
    end

    def send_GetTrackAudio(trackRequest)
      send_message('GetTrackAudio', GetTrackAudio_args, :trackRequest => trackRequest)
    end

    def recv_GetTrackAudio()
      result = receive_message(GetTrackAudio_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'GetTrackAudio failed: unknown result')
    end

    def UploadTrack(trackAudio)
      send_UploadTrack(trackAudio)
      return recv_UploadTrack()
    end

    def send_UploadTrack(trackAudio)
      send_message('UploadTrack', UploadTrack_args, :trackAudio => trackAudio)
    end

    def recv_UploadTrack()
      result = receive_message(UploadTrack_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'UploadTrack failed: unknown result')
    end

    def UploadPersonalTrack(trackAudio)
      send_UploadPersonalTrack(trackAudio)
      return recv_UploadPersonalTrack()
    end

    def send_UploadPersonalTrack(trackAudio)
      send_message('UploadPersonalTrack', UploadPersonalTrack_args, :trackAudio => trackAudio)
    end

    def recv_UploadPersonalTrack()
      result = receive_message(UploadPersonalTrack_result)
      return result.success unless result.success.nil?
      raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'UploadPersonalTrack failed: unknown result')
    end

  end

  class Processor
    include ::Thrift::Processor

    def process_GetTrackAudio(seqid, iprot, oprot)
      args = read_args(iprot, GetTrackAudio_args)
      result = GetTrackAudio_result.new()
      result.success = @handler.GetTrackAudio(args.trackRequest)
      write_result(result, oprot, 'GetTrackAudio', seqid)
    end

    def process_UploadTrack(seqid, iprot, oprot)
      args = read_args(iprot, UploadTrack_args)
      result = UploadTrack_result.new()
      result.success = @handler.UploadTrack(args.trackAudio)
      write_result(result, oprot, 'UploadTrack', seqid)
    end

    def process_UploadPersonalTrack(seqid, iprot, oprot)
      args = read_args(iprot, UploadPersonalTrack_args)
      result = UploadPersonalTrack_result.new()
      result.success = @handler.UploadPersonalTrack(args.trackAudio)
      write_result(result, oprot, 'UploadPersonalTrack', seqid)
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class GetTrackAudio_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    TRACKREQUEST = 1

    FIELDS = {
      TRACKREQUEST => {:type => ::Thrift::Types::STRUCT, :name => 'trackRequest', :class => ::TrackRequest}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class GetTrackAudio_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::TrackAudio}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class UploadTrack_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    TRACKAUDIO = 1

    FIELDS = {
      TRACKAUDIO => {:type => ::Thrift::Types::STRUCT, :name => 'trackAudio', :class => ::TrackAudio}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class UploadTrack_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::TrackUploaded}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class UploadPersonalTrack_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    TRACKAUDIO = 1

    FIELDS = {
      TRACKAUDIO => {:type => ::Thrift::Types::STRUCT, :name => 'trackAudio', :class => ::TrackAudio}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class UploadPersonalTrack_result
    include ::Thrift::Struct, ::Thrift::Struct_Union
    SUCCESS = 0

    FIELDS = {
      SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::TrackUploaded}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end

