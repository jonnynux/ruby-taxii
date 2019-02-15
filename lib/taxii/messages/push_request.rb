module Taxii
  module Messages
    class PushRequest < Hashie::Dash
      include Hashie::Extensions::Coercion

      property :collection_name, default: 'system.Default'
      property :message_id, default: -> { Taxii::Messages.generate_id }
      property :push_parameters,
                 default: Taxii::Messages::Parameters::Push.new

      def destination_collection_name
        {'taxii_11:Destination_Collection_Name': collection_name}
      end

      def content_block
        {'taxii_11:Content_Block': push_parameters.to_h}
      end

      def to_h
        NAMESPACE_ATTRIBUTES.merge({
          '@message_id': message_id,
        }).merge(destination_collection_name)
          .merge(content_block)
      end

      def to_xml
        Gyoku.xml({'taxii_11:Inbox_Message': to_h}, key_converter: :none)
      end

    end
  end
end
