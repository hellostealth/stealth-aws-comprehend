# stealth-aws-comprehend

This gem provides NLP via the [AWS Comprehend](https://aws.amazon.com/comprehend/) service. It integrates with the Stealth Controller to provide NLP against `current_message`.

## Setup

To use AWS Comprehend, set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables to your AWS account credentials. You may also want to optionally set your preferred AWS region by setting the environment variable `AWS_REGION`. That's the only setup required!

## Using NLP

This gem adds the following methods to `current_message`:

1. `language` identifies text written in over 100 languages and returns the dominant language in `current_message` with a confidence score
2. `entities` returns the named entities ("People," "Places," "Locations," etc.) present in `current_message`
3. `key_phrases` returns the key phrases or talking points and a confidence score to support for the `current_message`
4. `sentiment` returns the overall sentiment (Positive, Negative, Neutral, or Mixed) for the `current_message`
5. `sentiment_score` returns the scoring for each sentiment (Positive, Negative, Neutral, or Mixed) for the `current_message`

If `current_message.message` is not available, each of these will return `nil`.

The following examples are run on `current_message.message` when it is equal to `"I bought a brand new Craftsman Drill at Home Depot."`.

### language

`current_message.language` will return an Array of dominate languages:

```ruby
languages = [#<struct Aws::Comprehend::Types::DominantLanguage language_code="en", score=0.9921924471855164>]
languages.first.language_code # "en"
languages.first.score # 0.9921924471855164
```

### entities

`current_message.entites` will return an Array of entities:

```ruby
entities = [#<struct Aws::Comprehend::Types::Entity score=0.5775995850563049, type="ORGANIZATION", text="Craftsman", begin_offset=21, end_offset=30>, #<struct Aws::Comprehend::Types::Entity score=0.9224900007247925, type="ORGANIZATION", text="Home Depot", begin_offset=40, end_offset=50>]
entities.first.text # "Craftsman"
entities.first.score # 5775995850563049
entities.first.type # ORGANIZATION
```

### key_phrases

`current_message.key_phrases` will return an Array of key phrases:

```ruby
key_phrases = [#<struct Aws::Comprehend::Types::KeyPhrase score=0.965133786201477, text="a brand new Craftsman Drill", begin_offset=9, end_offset=36>, #<struct Aws::Comprehend::Types::KeyPhrase score=0.9943040609359741, text="Home Depot", begin_offset=40, end_offset=50>]
key_phrases.first.text # "a brand new Craftsman Drill"
key_phrases.first.score # 0.965133786201477
```

### sentiment

`current_message.sentiment` will return the dominate sentiment of the message:

```ruby
current_message.sentiment # "NEUTRAL"
```

### sentiment_score

`current_message.sentiment_score` will return the scoring for each sentiment of the message:

```ruby
sentiment_scores = #<struct Aws::Comprehend::Types::SentimentScore positive=0.0249068271368742, negative=0.012575631029903889, neutral=0.9605817794799805, mixed=0.0019358232384547591>
sentiment_scores.positive # 0.0249068271368742
sentiment_scores.negative # 0.012575631029903889
sentiment_scores.neutral # 0.9605817794799805
sentiment_scores.mixed # 0.0019358232384547591
```

## AWS Usage

Loading this gem into your bot doesn't automatically issue API requests to your AWS account. API requests are lazily made each time you call one of the above methods. One exception is `sentiment` and `sentiment_score` which share an API call and so that only a single API call is made between the two.
