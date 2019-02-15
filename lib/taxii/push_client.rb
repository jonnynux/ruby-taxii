module Taxii
  class PushClient
    include Client

    PARSE_OPTIONS = Nokogiri::XML::ParseOptions::DEFAULT_XML | Nokogiri::XML::ParseOptions::NOBLANKS
    RESULT_XPATH = '/taxii_11:Status_Message/@status_type'
    DETAIL_XPATH = '/taxii_11:Status_Message/taxii_11:Message'

    def push( push_request_message, url: self.inbox_service_url)
      msg = format_request(push_request_message)
      build_request(url: url, payload: msg).execute
    end

    def push_message( push_request_message,
                      url: self.inbox_service_url)
      response = self.push(push_request_message, url: url)
      content_xml = Nokogiri::XML(response.body,nil,nil,PARSE_OPTIONS)
      result = content_xml.xpath(RESULT_XPATH).first.value
      detail = content_xml.xpath(DETAIL_XPATH).first
      detail_msg = detail ? ": " + detail.content : ""
      result + detail_msg
    end

    def format_request(request_message)
      case request_message
        when String
          request_message
        when Taxii::Messages::PushRequest
          request_message.to_xml
        else
          fail ArgumentError, 'request message must be String or PushRequest'
      end
    end
  end
end
