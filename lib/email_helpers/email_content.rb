module EmailContent
  def EmailContent.get_unsubscribe_text( css_classes="" )
    # Returns the text to use for the unsubscribe section at the bottom of
    # all emails.
    # The css_classes argument is used if there are specific styling classes
    # the user wants to add to the hyperlink text.

    unsubscribe_content = "If you\'d like to manage your email preferences or unsubscribe, click <a class=\"#{css_classes}\" href=\"www.thedailybrief.co/settings\" target=\"_blank\" style=\"color: #8e8e8e; text-decoration: underline;\">here</a>."

    return unsubscribe_content
  end

  def EmailContent.newsletter_head
    html_content = "
      <head>
        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1\" user-scalable=\"no\">
        <meta name=\"robots\" content=\"none\">
        <style>
          @media all and (max-width:500px) {
            .email {
              width: 100% !important;
            }
            .email-hr {
              margin-top: 25px;
              margin-right: auto;
              margin-bottom: 25px;
              margin-left: auto;
            }
            .email-disclaimer {
              font-size: 12px;
            }
            .email-title--stats {
              font-size: 32px;
            }
            .email-allCaps {
              font-size: 12px;
              line-height: 14px;
            }
            .email-title--post {
              font-size: 22px;
              line-height: 26px;
            }
            .email-postImage {
              width: 92px;
              height: 80px;
            }
            .email-postImage--hero {
              float: right;
              margin-left: 7px;
            }
            .email-card {
              width: 100%;
              margin-left: 0;
              margin-right: 0;
            }
            .email-headline--section {
              font-size: 20px;
              line-height: 24px;
              margin-bottom: 5px;
            }
            .email-subtitle--section {
              font-size: 14px;
              line-height: 18px;
            }
            .email-xs-width100 {
              width: 100px !important;
            }
            .email-xs-height85 {
              max-height: 85px !important;
            }
            .email-xs-minHeight0 {
              min-height: 0 !important;
            }
            .email-xs-hide {
              display: none;
            }
          }
        </style>
      </head>
    "

    return html_content
  end

  def EmailContent.newsletter_logo
    html_content = "
      <div style=\"min-width: 100%; width: 100%; background-color: #ffffff;\">
        <table class=\"email\" style=\"width: 600px; margin-left: auto; margin-right: auto; padding-left: 15px; padding-right: 20px; padding-bottom:0; color: #333332; line-height: 1.4;\">
          <tr>
            <td>
              <div style=\"padding-top: 10px; padding-bottom: 10px; text-align: left;\">
                <a href=\"http://www.thedailybrief.co\" style=\"text-decoration: none; display: inline-block;\">
                  <img src=\"http://www.thedailybrief.co/logo.png\" alt=\"Daily Brief Logo\" style=\"height: 35px; vertical-align: middle;\">
                </a>
              </div>
            </td>
          </tr>
        </table>
      </div>
    "

    return html_content
  end

  def EmailContent.newsletter_section_header( section_title )
    if section_title == 'general'
      title = "Your top stories"
      top_margin = 15
    else
      topic = section_title == 'Race' ? 'Race & Culture' : section_title
      title = "Top stories in <span style=\"font-weight: 600;\">" + topic + "</span>"
      top_margin = 40
    end 

    html_content = "
      <div style=\"font-size: 18px; padding-left: 15px; padding-right: 15px; margin-top: #{top_margin}px;\">
        #{title}
      </div>
    "

    return html_content
  end

  def EmailContent.newsletter_items( topic, type, num_items )
    html_content = "
      <div style=\"min-width: 100%; width: 100%; margin-top: 15px; margin-bottom: 15px;\">
    "

    if num_items > 0
      for i in (0..(num_items-1))
        item_url = "#{topic}_#{type}_link#{i}"
        image_url = "#{topic}_#{type}_image#{i}"
        title = "#{topic}_#{type}_title#{i}"
        snippet = "#{topic}_#{type}_snippet#{i}"
        source = "#{topic}_#{type}_source#{i}"
        time = "#{topic}_#{type}_time#{i}"
        
        html_content += EmailContent.newsletter_item( item_url, image_url, title, snippet, source, time, type )
      end
    end

    html_content += "</div>"

    return html_content
  end

  def EmailContent.newsletter_item( item_url, image_url, title, snippet, source, time, item_type )
    if item_type == 'article'
      time_type = 'read'
    elsif item_type == 'podcast'
      time_type = 'listen'
    else
      time_type = ''
    end

    html_content = "
      <div class=\"email-xs-minHeight0\" style=\"overflow: auto; min-height: 150px; margin-bottom: 15px; box-shadow: 0 1px 3px rgba(0 , 0 , 0 , 0.1); background-color: #ffffff;\">
        <a href=\"{{{#{item_url}}}}\" style=\"color: #333332; text-decoration: none;\">
          <div style=\"padding-top: 15px; padding-left: 15px; padding-right: 15px;\">
            <div class=\"email-xs-height85\" style=\"overflow: hidden; min-width: 100%; width: 100%; max-height: 175px; margin-bottom: 10px;\">
              <img src=\"{{{#{image_url}}}}\" style=\"max-width: 100%; max-height: 100%;\">
            </div>
            <div style=\"font-size: 24px; line-height: 1.2; font-weight: 600; font-family: \'Source Sans Pro\', Helvetica, Arial, sans-serif;\">
              {{#{title}}}
            </div>
            <div style=\"font-size: 14px; color: #8e8e8e; margin-top: 5px;\">
              {{#{snippet}}}
            </div>
          </div>
          <div style=\"margin-top: 15px; padding-bottom: 15px; padding-left: 15px; padding-right: 15px;\">
            <div style=\"color: #8e8e8e; margin-top: 10px;\">
              <div style=\"font-size: 12px;\">
                <div style=\"color: #00ab6b; text-decoration: none;\">
                  {{#{source}}}
                </div>
                <div>{{#{time}}} min #{time_type}</div>
              </div>
            </div>
          </div>
        </a>
      </div>
    "

    return html_content
  end

  def EmailContent.newsletter_discover_button
    html_content = "
      <div style=\"text-align: center;\">
        <a href=\"http://www.thedailybrief.co\" style=\"color: #ffffff; text-decoration: none; display: inline-block; position: relative; height: 38px; line-height: 38px; padding-top: 0; padding-right: 16px; padding-bottom: 0; padding-left: 16px; border:0; outline: 0; background-color: #02b875; font-size: 14px; font-style: normal; font-weight: 400; text-align: center; cursor: pointer; white-space: nowrap; text-rendering: optimizeLegibility; -webkit-font-smoothing: antialiased; user-select: none; border-radius: 999em;\">
          Discover More Articles & Podcasts
        </a>
      </div>
    "

    return html_content
  end
end