module Stealth
  class ServiceMessage

    def language
      @language ||= begin
        if message.present?
          Stealth::AwsComprehend.detect_dominate_language(
            message: message
          )
        end
      end
    end

    def entities
      @entities ||= begin
        if message.present?
          Stealth::AwsComprehend.detect_entities(
            message: message
          )
        end
      end
    end

    def key_phrases
      @key_phrases ||= begin
        if message.present?
          Stealth::AwsComprehend.detect_key_phrases(
            message: message
          )
        end
      end
    end

    def sentiment_score
      get_sentiment.sentiment_score
    end

    def sentiment
      get_sentiment.sentiment
    end

    private

      def get_sentiment
        @sentiment ||= begin
          if message.present?
            Stealth::AwsComprehend.detect_sentiment(
              message: message
            )
          end
        end
      end

  end
end
