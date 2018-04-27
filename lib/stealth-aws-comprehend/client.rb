module Stealth
  class AwsComprehend

    def self.client
      @client ||= Aws::Comprehend::Client.new
    end

    def self.detect_dominate_language(message:)
      begin
        client.detect_dominant_language({
          text: message
        }).languages
      rescue Aws::Comprehend::Errors::ServiceError
        Stealth::Logger.l(topic: "AWS::Comprehend", message: e.message)
        return []
      end
    end

    def self.detect_entities(message:, language: 'en')
      begin
        client.detect_entities({
          text: message,
          language_code: language
        }).entities
      rescue Aws::Comprehend::Errors::ServiceError => e
        Stealth::Logger.l(topic: "AWS::Comprehend", message: e.message)
        return []
      end
    end

    def self.detect_key_phrases(message:, language: 'en')
      begin
        client.detect_key_phrases({
          text: message,
          language_code: language
        }).key_phrases
      rescue Aws::Comprehend::Errors::ServiceError
        Stealth::Logger.l(topic: "AWS::Comprehend", message: e.message)
        return []
      end
    end

    def self.detect_sentiment(message:, language: 'en')
      begin
        client.detect_sentiment({
          text: message,
          language_code: language
        })
      rescue Aws::Comprehend::Errors::ServiceError
        Stealth::Logger.l(topic: "AWS::Comprehend", message: e.message)
        return []
      end
    end

  end
end
