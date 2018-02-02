require_relative '../email_helpers/email_content'

module Newsletter
  def Newsletter.get_html_content( stories )
    sections = Newsletter.get_sections( stories )

    html_content = "
      <html>
        #{EmailContent.newsletter_head}

        <body style=\"margin-top: 0;margin-right: 0; margin-bottom: 0; margin-left: 0; padding-top: 0; padding-right: 0; padding-bottom: 0; padding-left: 0; background-color: rgba(0 , 0, 0 , 0.05);\">
          #{EmailContent.newsletter_logo}
          <table class=\"email\" style=\"width: 600px; margin-left: auto; margin-right: auto; padding-left: 5px; padding-right: 5px; padding-bottom: 20px; color: #333332; line-height: 1.4; font-family: \'Open Sans\', Helvetica, Arial, sans-serif;\">
            <tr>
              <td>
                <div>
                  #{sections}
                  #{EmailContent.newsletter_discover_button}
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div style=\"padding-top: 15px; padding-right: 0; padding-bottom: 0; padding-left: 0; margin-top: 30px; color: #b3b3b1; font-size: 12px; text-align: center; border-top: 1px solid #e5e5e5;\">
                  <div>
                    #{EmailContent.get_unsubscribe_text}
                  </div>
                </div>
              </td>
            </tr>
          </table>
        </body>

      </html>
    "

    return html_content
  end

  def Newsletter.get_sections( stories )
    html_content = ""

    stories.each do |topic, values|
      if (!values[:articles].empty? || !values[:podcasts].empty?)
        html_content += EmailContent.newsletter_section_header( topic )
        values.each do |type, items|
          html_content += EmailContent.newsletter_items(topic, type, items.length)
        end
      end
    end

    return html_content
  end
end