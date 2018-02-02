class NYTimes
  def initialize ( date, word_count_min ) 
    nytimes_api_key = ENV["NYTIMES_KEY"],
    nytimes_url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=word_count:(>" + word_count_min.to_s + ")&begin_date=" + date + "&end_date=" + date + "&sort=newest&api-key=" + nytimes_api_key
    
    @result = []
    parse_api( nytimes_url )
  end

  def parse_api( url )
    # Parses the the NYTimes API call and adds to the results array

    api_results = api_call( url )

    # Stop words to verify title with
    stop_words = [
      'The Latest:', 'California Today:', 'Friday Mailbag:',
      'New York Today:', ': Your Morning Briefing', 
      ': Your Monday Briefing', ': Your Tuesday Briefing', 
      ': Your Wednesday Briefing', ': Your Thursday Briefing', 
      ': Your Friday Briefing'
    ]

    # Iterate through all API Results
    api_results.each do |i|
      title = i['headline']['main']

      if RssHelper.verify_title(title, stop_words)
        @result.push({
          'web_url': i['web_url'],
          'title': title,
          'image_url': i['multimedia'].length > 0 ? ("http://static01.nyt.com/" + i["multimedia"][1]["url"]) : '',
          'snippet': i['lead_paragraph'],
          'word_count': i['word_count']
        })
      end
    end
  end

  def api_call( url )
    # Calls the NYTimes API

  	raw_date = RestClient.get url
    value =  JSON.parse raw_date

    return value["response"]["docs"]
  end

  def get_results
  	return @result
  end
end