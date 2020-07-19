#
# Autogenerated by Thrift Compiler (0.13.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

module Quality
  HIGH = 0
  MIDDLE = 1
  LOW = 2
  VALUE_MAP = {0 => "HIGH", 1 => "MIDDLE", 2 => "LOW"}
  VALID_VALUES = Set.new([HIGH, MIDDLE, LOW]).freeze
end

class TrackRequest; end

class TrackUploaded; end

class TrackAudio; end

class TrackRequest
  include ::Thrift::Struct, ::Thrift::Struct_Union
  FILENAME = 1
  QUALITY = 2

  FIELDS = {
    FILENAME => {:type => ::Thrift::Types::STRING, :name => 'fileName'},
    QUALITY => {:type => ::Thrift::Types::I32, :name => 'quality', :enum_class => ::Quality}
  }

  def struct_fields; FIELDS; end

  def validate
    unless @quality.nil? || ::Quality::VALID_VALUES.include?(@quality)
      raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field quality!')
    end
  end

  ::Thrift::Struct.generate_accessors self
end

class TrackUploaded
  include ::Thrift::Struct, ::Thrift::Struct_Union
  FILENAME = 1

  FIELDS = {
    FILENAME => {:type => ::Thrift::Types::STRING, :name => 'fileName'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

class TrackAudio
  include ::Thrift::Struct, ::Thrift::Struct_Union
  IDTRACK = 1
  TRACKNAME = 2
  AUDIO = 3

  FIELDS = {
    IDTRACK => {:type => ::Thrift::Types::STRING, :name => 'idTrack'},
    TRACKNAME => {:type => ::Thrift::Types::STRING, :name => 'trackName'},
    AUDIO => {:type => ::Thrift::Types::STRING, :name => 'audio', :binary => true}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

